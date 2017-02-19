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
//static NSString* const WX_APPID  = @"wx0f8b2fa15745bcc1";//LED
static NSString* const WX_APPID  = @"wx273df92f37ad2bed";//小吱
static NSString* const WB_APPKEY = @"1098884526";

#pragma mark - 小吱 wx
// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define MXWechatAPPID       @"wx273df92f37ad2bed"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define MXWechatAPPSecret   @"370a177e935643135728415edec63cdb"
// 微信支付商户号
#define MXWechatMCHID       @"1402967402"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define MXWechatPartnerKey  @"wx198806050615198806050615wxwxwx"
//微信下单接口
#define kUrlWechatPay       @"https://api.mch.weixin.qq.com/pay/unifiedorder"

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
/** 跳转到支付页面  */
-(void)jumpToWXPayPanel;

@end













