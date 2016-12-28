//
//  CATextLayer+LH.m
//  YDT
//
//  Created by lh on 15/5/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CATextLayer+LH.h"

@implementation CATextLayer (LH)

/**
 *  初始化
 *
 *  @param frame           大小
 *  @param string          字符串
 *  @param font            字体
 *  @param foregroundColor 前景色，nil则系统默认为白色
 *
 *  @return 实例
 */
+ (instancetype)lh_textLayerWithFrame:(CGRect)frame string:(id)string fontSize:(CGFloat)fontSize foregroundColor:(CGColorRef)foregroundColor {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = frame;
    textLayer.string = string;
    textLayer.fontSize = fontSize;
    if (foregroundColor) {
        textLayer.foregroundColor = foregroundColor;
    }
    
    [textLayer lh_setInitDefaultValues];
    
    return textLayer;
}

@end
