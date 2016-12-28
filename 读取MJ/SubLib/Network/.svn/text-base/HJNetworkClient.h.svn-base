//
//  APIClient.h
//  Bsh
//
//  Created by lh on 15/12/21.
//  Copyright © 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class HJBaseAPI;

#if DEBUG

//#define kNCLoaclResponse

#endif

#pragma mark - 网络配置信息

typedef NS_ENUM(NSInteger, NetworkCodeType) {
    /// 失败
    NetworkCodeTypeFail = 0,
    /// 成功
    NetworkCodeTypeSuccess = 1,
    /// 服务繁忙
    NetworkCodeTypeServiceBusy = -1,
    /// Token无效
    NetworkCodeTypeTokenInvalid = 40000,
};


/**
 *  请求成功block
 */
typedef void (^APISuccessBlock)(id responseObject);

/**
 *  请求失败block
 */
typedef void (^APIFailureBlock) (NSError *error);

/**
 *  请求成功 且 code == NetworkCodeTypeSuccess block
 */
typedef void (^APINetworkCodeTypeSuccessBlock)(id responseObject);

/**
 *  请求完成block
 */
typedef void(^APIFinishedBlock)(id responseObject, NSError *error);

/**
 *  Network客户端
 */

@interface HJNetworkClient : NSObject

/**
 *  @author hejing
 *
 *  AFHTTPRequestOperationManager对象，负责管理和调度网络请求
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/**
 *  @author hejing
 *
 *  服务器返回Json数据映射模型
 */
@property (nonatomic, strong) HJBaseAPI *baseAPI;

/**
 *  默认为YES,加载等待view居中
 */
@property (nonatomic, assign) BOOL hudCenter;

/**
 *  @author hejing
 *
 *  获取NetworkClient实例
 *
 *  @param subUrl     请求对应的url
 *  @param parameters url请求所需的参数
 *  @param HJBaseAPI    返回数据所要映射的API模型
 *
 *  @return NetworkClient实例
 */
+ (instancetype)networkClientWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters HJBaseAPI:(HJBaseAPI *)HJBaseAPI;

/**
 *  @author hejing
 *
 *  获取NetworkClient实例
 *
 *  @param subUrl     请求对应的url
 *  @param parameters url请求所需的参数
 *  @param files      上传文件
 *  @param HJBaseAPI    返回数据所要映射的API模型
 *
 *  @return NetworkClient实例
 */
+ (instancetype)networkClientWithSubUrl:(NSString *)subUrl parameters:(NSDictionary *)parameters files:(NSArray *)files HJBaseAPI:(HJBaseAPI *)HJBaseAPI;


- (void)getRequestInView:(UIView *)containerView finishedBlock:(APIFinishedBlock)finishedBlock;

- (void)postRequestInView:(UIView *)containerView finishedBlock:(APIFinishedBlock)finishedBlock;
/** 改变  不变的 lnwy 改的*/
- (void)postRequestInView:(UIView *)containerView successBlock:(APISuccessBlock)successBlock;

/** 改变  要变的 isShow:就是加载中的圈圈  这个post请求,主要用来,计时器 加载 的 */
- (void)postRequestInView:(UIView *)containerView isShow:(BOOL)isShow successBlock:(APISuccessBlock)successBlock;

/**
 *  post操作
 *
 *  @param containerView  网络请求发生的view，hud位于其中心
 *  @param successJCBlock 返回api code ＝ 1执行操作
 */
- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessBlock:(APINetworkCodeTypeSuccessBlock)successJCBlock;
/**
 *  post操作
 *
 *  @param containerView  网络请求发生的view，hud位于其中心
 *  @param successJCBlock 返回api code ＝
 */
- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessAndErrorCodeBlock:(APINetworkCodeTypeSuccessBlock)successAndErrorJCBlock;

/**
 *  post操作，网络数据回调有baseAPI操作
 *
 *  @param containerView 网络请求发生的view，hud位于其中心
 */
- (void)postRequestInView:(UIView *)containerView networkCodeTypeSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler;
/** 手机验证码  */
- (void)postRequestInView:(UIView *)containerView phoneUserIco:(NSString *)phoneUserIcon networkRequestSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler;

- (void)postRequestInView:(UIView *)containerView networkRequestSuccessDataHandler:(id<HJDataHandlerProtocol>)dataHandler;

- (void)uploadFileInView:(UIView *)containerView successBlock:(APISuccessBlock)successBlock;

@end

#pragma mark - 上传文件类

@interface HJNetworkClientFile : NSObject

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  服务器接收参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *fileName;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;


+ (instancetype)imageFileWithFileData:(NSData *)fileData name:(NSString *)name;

@end

