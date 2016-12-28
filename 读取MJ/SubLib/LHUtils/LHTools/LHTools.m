//
//  LHTools.m
//  Test
//
//  Created by lh on 15/11/29.
//  Copyright © 2015年 lh. All rights reserved.
//

#import "LHTools.h"

@implementation LHTools


//+ (void)load {
//    // 程序默认启动
//    [DDLog lh_setupDDLog];
//}

/**
 *  获取手机唯一标示，手机重置后会不一样
 *
 *  @return 手机唯一标示
 */
+ (NSString *)phoneId {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/**
 *  拨打电话号码，直接拨打
 */
- (void)telWithPhoneNumber:(NSString *)phoneNumber {
    NSString * str = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}


@end
