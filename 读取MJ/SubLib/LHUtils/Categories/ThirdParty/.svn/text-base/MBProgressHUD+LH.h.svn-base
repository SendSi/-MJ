//
//  MBProgressHUD+LH.h
//  Test
//
//  Created by lh on 15/11/29.
//  Copyright © 2015年 lh. All rights reserved.
//


#define EnableMBProgressHUD


#ifdef EnableMBProgressHUD


#import "MBProgressHUD.h"

@interface MBProgressHUD (LH)

/**
 *  显示文本HUD，1.5秒后消失
 *
 *  @param view 要添加到得视图
 *  @param text 文本
 */
+ (void)lh_showTextHUDAddedTo:(UIView *)view text:(NSString *)text;

@end

@interface UIViewController (MBProgressHUD)

/**
 *  显示HUD文本
 *
 *  @param message 文本
 */
- (void)lh_showMBHUDWithMessage:(NSString *)message;

@end


#endif
