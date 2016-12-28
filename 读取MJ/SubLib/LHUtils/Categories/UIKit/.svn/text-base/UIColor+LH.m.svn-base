//
//  UIColor+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIColor+LH.h"

@implementation UIColor (LH)

/**
 *  将由6个字符十六进制颜色转换到UIColor对象，会自动截取前面的 #号
 */
+ (UIColor *)lh_hexColor:(NSString *)hexColor
{
    if ([hexColor hasPrefix:@"#"]) {
        hexColor = [hexColor substringFromIndex:1];
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    //取得red的值
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    //取得green的值
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    //取得blue的值
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}


/**
 *  获取随机颜色color
 */
+ (UIColor *)lh_randomColor {
    return [UIColor colorWithRed:(float)(1 + arc4random() % 99) / 100 green:(float)(1 + arc4random() % 99) / 100 blue:(float)(1 + arc4random() % 99) / 100 alpha:1];
}

@end
