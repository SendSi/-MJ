//
//  CATransition+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CATransition+LH.h"

@implementation CATransition (LH)

/**
 *  过渡动画，duration 默认 0.3
 *
 *  @param type    过渡类型，例如 kCATransitionFade
 *  @param subType 过渡方向，例如 kCATransitionFromRight
 *
 *  @return 动画
 */
+ (instancetype)lh_transitionWithType:(NSString *)type subType:(NSString *)subType {
    CATransition *transition = [CATransition animation];
    transition.type = type;
    transition.subtype = subType;
    
    // default
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return transition;
}

@end
