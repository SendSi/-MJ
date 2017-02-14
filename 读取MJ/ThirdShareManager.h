//
//  ThirdShareManager.h
//  读取MJ
//
//  Created by SunSi on 16/12/25.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"//wechat
#import "WeiboSDK.h"

static NSString* const QQ_APPID  = @"1105861684";
// SDK APPID
static NSString* const WX_APPID  = @"wx0f8b2fa15745bcc1";
static NSString* const WB_APPKEY = @"1098884526";

@interface ThirdShareManager : NSObject<TencentSessionDelegate,WXApiDelegate,WeiboSDKDelegate>
/** 单例  */
+(instancetype)Instance;


#pragma mark - QQ
/** QQ登录  */
-(void)qqLogin_success:(idBlock)success fail:(idBlock)fail;

@property (copy,nonatomic) idBlock blockQQSuccess;
@property (copy,nonatomic) idBlock blockQQFail;
@property (strong,nonatomic) TencentOAuth *oauth;

#pragma mark - WX
/** WX 登录  */
-(void)wxLogin_success:(idBlock)success fail:(idBlock)fail;
@property (copy,nonatomic) idBlock blockWXSuccess;
@property (copy,nonatomic) idBlock blockWXFail;


#pragma mark - sina
/**  新浪  */
-(void)sinaLogin_success:(idBlock)success fail:(idBlock)fail;
@property (nonatomic, copy) idBlock blockSinaSuccess;
@property (nonatomic, copy) idBlock blockSinaFail;


#pragma mark - 分享
#pragma mark - QQ share
-(void)qqShareSessionWithSuccess:(idBlock )blockSuccess fail:(idBlock)blockFail;
-(void)qqShardTimeLineWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail;

/**  VC可以指定的 QQ空间  */
-(void)qqshareZoneWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText;

#pragma mark -wx share
-(void)wxShareMessageWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText;
-(void)wxShareFriendWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText;

#pragma mark - sina share
-(void)sinaShareWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText;




#pragma mark - wx 支付
-(void)wxPayLNWY;

-(void)getInfoWX;
@property (nonatomic, copy) idBlock blockWXPaySuccess;
@property (nonatomic, copy) idBlock blockWXPayFail;


@end













