//
//  HJBaseAPI.h
//  Bsh
//
//  Created by lh on 15/12/21.
//  Copyright © 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJBaseModel.h"
#import "HJNetworkClient.h"
/**
 *  父 API
 */
@interface HJBaseAPI : NSObject

@property (nonatomic, assign) NetworkCodeType code;

@property (nonatomic, strong) NSString *msg;

@property (nonatomic, strong) NSMutableDictionary *parameters;

@property (nonatomic, strong) NSArray *uploadFile;

@property (nonatomic, copy) NSString *subUrl;

@property (nonatomic, assign) id<HJDataHandlerProtocol>dataHandler;


/**
 *  API类网络请求客户端
 *
 *  @return API类网络请求客户端
 */
- (HJNetworkClient *)netWorkClient;

/**
 *  判断是否属于HJBaseAPI某个子类
 *
 *  @param apiClass HJBaseAPI某个子类
 *
 *  @return 是 返回YES
 */
- (BOOL)isKindOfAPIClass:(Class)apiClass;

@end

@interface HJBaseAPI (HUD)

@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) UIView *containerView;

/**
 *  Default YES...
 */
@property (nonatomic, assign, getter=isShowErrorMsg) BOOL showErrorMsg;

/**
 *  Default YES...
 */
@property (nonatomic, assign, getter=isShowFailureMsg) BOOL showFailureMsg;

/**
 *  Default YES...
 */
@property (nonatomic, assign, getter=isParametersAddToken) BOOL parametersAddToken;


- (void)showHUDWhileRequest:(UIView *)containerView isShow:(BOOL)isShow;

- (void)hideHUDWhileFinish;

- (void)showMsgWhileJSONError;

/**
 *  @author hejing
 *
 *  请求成功，但返回code不是成功状态提示错误信息
 *
 *  @param msg 错误信息
 */
- (void)showMsgWhileRequestFailure:(NSString *)msg;

- (void)showMsgWhileTokenExpire:(NSString *)msg;

/**
 *  @author hejing
 *
 *  请求错误，提示失败信息
 *
 *  @param msg 请求错误信息
 */
- (void)showMsgWhileRequestError:(NSString *)msg;


#pragma mark - LocalResponse

- (NSString *)localResponseDataPath;

- (NSDictionary *)localResponseJSON;

- (void)retrunCodeEqualToSuccessDoNextStep:(voidBlock)nextStep;

- (void)retrunMsgEqualTo:(NSString *)msg doNextStep:(voidBlock)nextStep;

@end

