//
//  CAShapeLayer+LH.m
//  YDT
//
//  Created by lh on 15/5/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CAShapeLayer+LH.h"

@implementation CAShapeLayer (LH)

/**
 *  初始化
 *
 *  @param frame    大小
 *  @param contents 内容，如果是图片需要 CGImage
 *
 *  @return 实例
 */
+ (instancetype)lh_shapeLayerWithFrame:(CGRect)frame contents:(id)contents {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame;
    shapeLayer.contents = contents;
    
    [shapeLayer lh_setInitDefaultValues];
    
    return shapeLayer;
}

@end
