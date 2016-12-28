//
//  APIClient.m
//  Bsh
//
//  Created by lh on 15/12/21.
//  Copyright © 2015年 lh. All rights reserved.
//

#import "HJNetworkClient.h"
#import "HJBaseAPI.h"

#define kTimeoutInterval 60

@interface HJNetworkClient ()

/// 请求子网址
@property (nonatomic, copy) NSString *subUrl;

/// 请求参数
@property (nonatomic, strong) NSDictionary *parameters;

/// 容器，HUD父视图
@property (strong, nonatomic) UIView *containerView;

@property (nonatomic, strong) NSArray *files;

@end

@implementation HJNetworkClient

/*
 + (instancetype)sharedAPIClient {
 static APIClient *_instance;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{
 _instance = [[self alloc] init];
 });
 return _instance;
 }
 */


#pragma mark - Init

- (void)defaultInit {
    self.hudCenter = YES;
}

+ (instancetype)networkClientWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters HJBaseAPI:(HJBaseAPI *)HJBaseAPI {
    
    return [self networkClientWithSubUrl:subUrl parameters:parameters files:nil HJBaseAPI:HJBaseAPI];
}

+ (instancetype)networkClientWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters files:(NSArray *)files HJBaseAPI:(HJBaseAPI *)HJBaseAPI {
    
    HJNetworkClient *client = [HJNetworkClient new];
    client.subUrl = subUrl;
    client.parameters = parameters;
    client.files = files;
    client.baseAPI = HJBaseAPI;
    
    [client defaultInit];
    
    return client;
}


#pragma mark - Getter

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", NULL];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = kTimeoutInterval;
        
        [_manager.requestSerializer setValue:APP_key forHTTPHeaderField:@"secretKey"];
      //  [_manager.requestSerializer setValue:[[APP_key stringByAppendingString:API_APP_BASE_URL] md5String]forHTTPHeaderField:@"iv"];
    //lnwy被注释
    }
    return _manager;
}


#pragma mark - Log

/**
 *  请求完成后打印
 *
 *  @param response 返回对象
 *  @param error    错误
 */
- (void)logFinished:(NSDictionary*)response error:(NSError*)error {
    
#ifdef DEBUG
    
    // 字典格式
    NSString *paramStr = [NSString stringWithFormat:@"\n%@", self.parameters];
    NSLogs(@"*************start**************\n-------------------- 接口请求开始 ----------123------------subUrl=%@",self.subUrl);
    NSLogs(@"接口地址：%@\n请求参数：%@\n拼接url：%@", self.subUrl, paramStr,    [NSString lh_subUrlString:self.subUrl appendingParameters:self.parameters]);
    if (!error) {
        NSLogs(@"请求成功：\n%@\n  msg=%@", response ,[response objectForKey:@"msg"]);
    }
    else {
        NSLogs(@"请求失败：\n%@", error);
    }

    NSLogs(@"-------------------- 接口请求结束 ----------------321------subUrl=%@\n************end**************",self.subUrl);
    
#endif
}

/**
 *  获取请求完成后block
 *
 *  @return 请求完成后block
 */
- (APIFinishedBlock)requestFinishedBlock {
    APIFinishedBlock aReqFinishedBlock = ^(NSDictionary *response, NSError *error) {
        // 去掉HUD
        //        [self.bAPI hideHUDWhileFinish];
        
        // DEBUG模式下打印
#if DEBUG
        [self logFinished:response error:error];
#endif
    };
    
    return aReqFinishedBlock;
}


#pragma mark - Request

- (void)readyForRequest:(UIView *)containerView isShow:(BOOL)isShow{
    // 添加 UserId 和 Token
    if (self.baseAPI.isParametersAddToken) {
        
//        [self addUserIdAndToken];
    }
    // 添加 HUD
    if (containerView) {
        UIView *tmpContainerView = containerView;
        if ([containerView isKindOfClass:[UIScrollView class]]) {
            if (self.hudCenter) {
                UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
                UIViewController *rootViewController = window.rootViewController;
                if (rootViewController) {
                    tmpContainerView = rootViewController.view;
                }
            }
        }
        
        self.containerView = tmpContainerView;
        [self.baseAPI showHUDWhileRequest:tmpContainerView isShow:isShow];
    }
}

- (HJBaseAPI *)dealWhileSuccess:(id)responseObject {
    // 请求完成后block
    APIFinishedBlock reqFinishedBlock = [self requestFinishedBlock];
    reqFinishedBlock(responseObject, nil);
    
    HJBaseAPI *bAPIModel = [self.baseAPI.class mj_objectWithKeyValues:responseObject];
    NSInteger code = bAPIModel.code;
    NSString *msg = bAPIModel.msg;
    
    //返回数据不存在，显示服务器错误
    if (!responseObject) {
        [self.baseAPI showMsgWhileJSONError];
    }
    
    else if (code == NetworkCodeTypeTokenInvalid) {
        // token过期，直接退出
        [self.baseAPI showMsgWhileTokenExpire:msg];
        
        return nil;
    }
    else if (code != NetworkCodeTypeSuccess) {
        
        //返回code不为成功是否显示返回msg信息
        [self.baseAPI showMsgWhileRequestFailure:msg];
    }
    else {
        // 成功获取数据后，去掉HUD
        [self.baseAPI hideHUDWhileFinish];
    }
    
    return bAPIModel;
}

- (void)dealWhileError:(NSError *)error {
    // 请求完成后block
    APIFinishedBlock reqFinishedBlock = [self requestFinishedBlock];
    reqFinishedBlock(nil, error);
    // 获取数据失败，去掉HUD
    [self.baseAPI showMsgWhileRequestError:error.localizedDescription];
}

- (void)requestSucces:(id)responseObject finishedBlock:(APIFinishedBlock)finishedBlock {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    if (!bAPIModel) {
        return;
    }
    
    !finishedBlock ?: finishedBlock(bAPIModel, nil);
}

- (void)requestSucces:(id)responseObject successBlock:(APISuccessBlock)successBlock {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    if (!bAPIModel) {
        return;
    }
    
    !successBlock ?: successBlock(bAPIModel);
}

/**
 *  请求成功且return code ＝ 1执行block操作
 *
 *  @param responseObject 网络请求成功返回数据
 *  @param successJCBlock 返回数据映射成model进行回调的block
 */
- (void)requestSucces:(id)responseObject successJCBlock:(APINetworkCodeTypeSuccessBlock)successJCBlock {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    if (!bAPIModel || bAPIModel.code != NetworkCodeTypeSuccess) {
        return;
    }
    
    !successJCBlock ?: successJCBlock(bAPIModel);
}


/**
 *  请求成功且return code ＝ 1执行block操作*
 */
- (void)requestSucces:(id)responseObject successAndErrorJCBlock:(APINetworkCodeTypeSuccessBlock)successJCBlock {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    !successJCBlock ?: successJCBlock(bAPIModel);
}

- (void)requestSucces:(id)responseObject successJCDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    
    if (!bAPIModel || bAPIModel.code != NetworkCodeTypeSuccess) {
        return;
    }

    if (dataHandler && [dataHandler respondsToSelector:@selector(netWorkCodeSuccessDealWithResponseObject:)]) {
        
        [dataHandler netWorkCodeSuccessDealWithResponseObject:bAPIModel];
    }
}

- (void)requestSucces:(id)responseObject successDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    if (!bAPIModel) {
        return;
    }
    if (dataHandler && [dataHandler respondsToSelector:@selector(netWorkRequestSuccessDealWithResponseObject:)]) {
        [dataHandler netWorkRequestSuccessDealWithResponseObject:bAPIModel];
    }
}


- (void)requestSucces:(id)responseObject phoneUserIco:(NSString *)phoneUserIco successDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    HJBaseAPI *bAPIModel = [self dealWhileSuccess:responseObject];
    if (!bAPIModel) {
        return;
    }
    if (dataHandler && [dataHandler respondsToSelector:@selector(netWorkRequestSuccessDealWithResponseObject:ids:)]) {
        [dataHandler netWorkRequestSuccessDealWithResponseObject:phoneUserIco ids:bAPIModel];
    }
}

- (void)requestFailure:(NSError *)error failurBlock:(APIFailureBlock)failurBlock {
    [self dealWhileError:error];
    
    !failurBlock ?: failurBlock(error);
}

- (void)requestFailure:(NSError *)error finishedBlock:(APIFinishedBlock)finishedBlock {
    [self dealWhileError:error];
    
    !finishedBlock ?: finishedBlock(nil, error);
}


#pragma mark - Get Request
/** 没上用吧  */
- (void)getRequestInView:(UIView *)containerView finishedBlock:(APIFinishedBlock)finishedBlock {
    [self readyForRequest:containerView isShow:YES];
    
    // 开始请求
    [self.manager GET:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        HJBaseAPI *bAPIModel = [self.baseAPI.class mj_objectWithKeyValues:responseObject];
        
        [self requestSucces:bAPIModel finishedBlock:finishedBlock];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error finishedBlock:finishedBlock];
    }];
}

#pragma mark - Post Request

- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessBlock:(APINetworkCodeTypeSuccessBlock)successJCBlock {
    [self readyForRequest:containerView isShow:YES];
#ifdef kNCLoaclResponse
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject successJCBlock:successJCBlock];
#else
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestSucces:responseObject successJCBlock:successJCBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFailure:error failurBlock:nil];
    }];
#endif
}


- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessAndErrorCodeBlock:(APINetworkCodeTypeSuccessBlock)successAndErrorJCBlock {
    [self readyForRequest:containerView isShow:YES];
#ifdef kNCLoaclResponse
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject successJCBlock:successJCBlock];
#else
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self requestSucces:responseObject successAndErrorJCBlock:successAndErrorJCBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self requestFailure:error failurBlock:nil];
    }];
#endif
}

//postRequestInView :self successBlock:^(id responseObject)

- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    
    [self readyForRequest:containerView isShow:YES];
    
#ifdef kNCLoaclResponse
    
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject successJCBlock:successJCBlock];
    
#else
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject successJCDataHandler:dataHandler];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];
    
#endif

}

- (void)postRequestInView:(UIView *)containerView networkRequestSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject successDataHandler:dataHandler];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];

}

- (void)postRequestInView:(UIView *)containerView phoneUserIco:(NSString *)phoneUserIcon networkRequestSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler {
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject phoneUserIco:phoneUserIcon successDataHandler:dataHandler];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];
    
}



/** 改变  不变的  */
- (void)postRequestInView:(UIView *)containerView successBlock:(APISuccessBlock)successBlock {
    [self readyForRequest:containerView isShow:YES];
    
#ifdef kNCLoaclResponse
    
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject successBlock:successBlock];
    
#else
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject successBlock:successBlock];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];
    
#endif
}
/** 改变  要变的 isShow:就是加载中的圈圈  这个post请求,主要用来,计时器 加载 的 */
- (void)postRequestInView:(UIView *)containerView isShow:(BOOL)isShow successBlock:(APISuccessBlock)successBlock {
    [self readyForRequest:containerView isShow:isShow];
    
#ifdef kNCLoaclResponse
    
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject successBlock:successBlock];
    
#else
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject successBlock:successBlock];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];
    
#endif
}

- (void)postRequestInView:(UIView *)containerView finishedBlock:(APIFinishedBlock)finishedBlock {
    [self readyForRequest:containerView isShow:YES];
    
#ifdef kNCLoaclResponse
    
    id responseObject = [self.bAPI localResponseJSON];
    [self requestSucces:responseObject finishedBlock:finishedBlock];
    
#else
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject finishedBlock:finishedBlock];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error finishedBlock:finishedBlock];
    }];
    
#endif
}

#pragma mark - Upload Request

- (void)uploadFileInView:(UIView *)containerView successBlock:(APISuccessBlock)successBlock {
    [self readyForRequest:containerView isShow:YES];
    
    // 开始请求
    [self.manager POST:self.subUrl parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    [self.files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            HJNetworkClientFile *file = obj;
            [formData appendPartWithFileData:file.fileData name:file.name fileName:file.fileName mimeType:file.mimeType];
        }];
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self requestSucces:responseObject successBlock:successBlock];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self requestFailure:error failurBlock:nil];
    }];
}


@end


@implementation HJNetworkClientFile

+ (instancetype)imageFileWithFileData:(NSData *)fileData name:(NSString *)name {
    HJNetworkClientFile *file = [HJNetworkClientFile new];
    file.fileData = fileData;
    file.name = name;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    file.fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
    file.mimeType = @"image/jpeg";
    
    return file;
}

@end

