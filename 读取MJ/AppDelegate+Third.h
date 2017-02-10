//
//  AppDelegate+Third.h
//  读取MJ
//
//  Created by SunSi on 16/12/25.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"


@interface AppDelegate (Third)

/**  第三方应用的URL  */
-(BOOL) thrid_application_url:(NSURL *)url;

- (void)third_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;




@end
