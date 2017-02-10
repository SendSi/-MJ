//
//  AppDelegate.m
//  读取MJ
//
//  Created by SunSi on 16/12/18.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "AppDelegate.h"
#import "RGUtilObject.h"
#import "AppDelegate+Third.h"
#import "WXApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self thrid_application_url:url];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
  return  [self thrid_application_url:url];
}

/** 9.0 的方法- 应该注释  */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [self thrid_application_url:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动时,微信要先注册,要先在didFinish
   [self third_application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}



/**  存储 Plist  */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [RGUtilObject.instance save];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
