//
//  LHTools.h
//  Test
//
//  Created by lh on 15/11/29.
//  Copyright © 2015年 lh. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *   工具类
 */
@interface LHTools : NSObject


/**
 *  获取手机唯一标示，手机重置后会不一样
 *
 *  @return 手机唯一标示
 */
+ (NSString *)phoneId;

/**
 *  拨打电话号码，直接拨打
 */
- (void)telWithPhoneNumber:(NSString *)phoneNumber;


@end
