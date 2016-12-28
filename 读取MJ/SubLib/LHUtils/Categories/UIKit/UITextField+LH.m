//
//  UITextField+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITextField+LH.h"

@implementation UITextField (LH)

/// 是否是空的文本，空文本 → YES，非空文本 → NO
- (BOOL)lh_isEmptyText {
    return ![self.text lh_isNotEmpty];
}


/**
 *  初始化
 *
 *  @param frame           大小
 *  @param placeholder     占位文本
 *  @param font            字体
 *  @param textAlignment   文本对齐方式
 *  @param backgroundColor 背景颜色
 *
 *  @return 实例
 */
+ (UITextField *)lh_textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder  = placeholder;
    textField.font = font;
    textField.textAlignment = textAlignment;
    textField.backgroundColor = backgroundColor;
    
    return textField;
}

@end
