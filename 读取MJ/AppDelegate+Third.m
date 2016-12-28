//
//  AppDelegate+Third.m
//  读取MJ
//
//  Created by SunSi on 16/12/25.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "AppDelegate+Third.h"
#import "ThirdShareManager.h"

@implementation AppDelegate (Third)


-(BOOL) thrid_application_url:(NSURL *)url{
    return
    [TencentOAuth HandleOpenURL:url]//QQ登录
    || [WXApi handleOpenURL:url delegate:ThirdShareManager.Instance];//微信登录
}
- (void)third_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
  BOOL isSucdessWX=  [WXApi registerApp:@"wx0f8b2fa15745bcc1"];
    if(isSucdessWX){
        NSLogs(@"wx --成功");
    }else{
        NSLogs(@"wx --失败");
    }
}

@end
