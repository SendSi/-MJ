//
//  CATransition+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CATransition (LH)

/**
 *  过渡动画，duration 默认 0.3
 *
 *  @param type    过渡类型，例如 kCATransitionFade
 *  @param subType 过渡方向，例如 kCATransitionFromRight
 *
 *  @return 动画
 */
+ (instancetype)lh_transitionWithType:(NSString *)type subType:(NSString *)subType;

@end
