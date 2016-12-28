//
//  UIAlertView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIAlertView+LH.h"

@implementation UIAlertView (LH)

/**
 *  显示简单弹窗，消息
 *
 *  @param message 消息
 */
+ (void)lh_showWithMessage:(NSString *)message {
    [self lh_showWithTitle:@"" message:message];
}

/**
 *  显示简单弹窗，标题 + 内容
 *
 *  @param title   标题
 *  @param message 内容
 */
+ (void)lh_showWithTitle:(NSString *)title message:(NSString *)message {
    [self lh_showWithTitle:title message:message delegate:nil];
}

/**
 *  显示简单弹窗，标题 + 内容 + 代理
 *
 *  @param title    标题
 *  @param message  内容
 *  @param delegate 代理
 */
+ (void)lh_showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate {
    [self lh_showWithTitle:title message:message delegate:delegate tag:0];
}

/**
 *  显示简单弹窗，标题 + 内容 + 代理 + tag
 *
 *  @param title    标题
 *  @param message  内容
 *  @param delegate 代理
 *  @param tag      tag
 */
+ (void)lh_showWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate tag:(int)tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alertView.tag = tag;
    [alertView show];
}

@end
