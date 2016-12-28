//
//  MBProgressHUD+LH.m
//  Test
//
//  Created by lh on 15/11/29.
//  Copyright © 2015年 lh. All rights reserved.
//


#ifdef EnableMBProgressHUD


#import "MBProgressHUD+LH.h"

@implementation MBProgressHUD (LH)

/**
 *  显示文本HUD，1.5秒后消失
 *
 *  @param view 要添加到得视图
 *  @param text 文本
 */
+ (void)lh_showTextHUDAddedTo:(UIView *)view text:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        [hud hide:YES];
    }
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [hud show:true];
    [hud hide:true afterDelay:1.5];
}

@end

@implementation UIViewController (MBProgressHUD)

/**
 *  显示HUD文本
 *
 *  @param message 文本
 */
- (void)lh_showMBHUDWithMessage:(NSString *)message {
    [MBProgressHUD lh_showTextHUDAddedTo:self.view text:message];
}

@end


#endif
