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

static NSString* const QQ_APPID  = @"1105861684";

@interface ThirdShareManager : NSObject<TencentSessionDelegate,WXApiDelegate>
/** 单例  */
+(instancetype)Instance;

/** QQ登录  */
-(void)qqLogin_success:(idBlock)success fail:(idBlock)fail;

@property (copy,nonatomic) idBlock blockQQSuccess;
@property (copy,nonatomic) idBlock blockQQFail;
@property (strong,nonatomic) TencentOAuth *oauth;


/** WX 登录  */
-(void)wxLogin_success:(idBlock)success fail:(idBlock)fail;
@property (copy,nonatomic) idBlock blockWXSuccess;
@property (copy,nonatomic) idBlock blockWXFail;

@end
