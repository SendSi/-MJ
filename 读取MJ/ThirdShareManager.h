//
//  ThirdShareManager.h
//  读取MJ
//
//  Created by SunSi on 16/12/25.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
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









@end













