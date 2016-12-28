//
//  NSTimer+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSTimer+LH.h"

@implementation NSTimer (LH)

/**
 *  暂停定时器
 */
-(void)lh_pauseTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

/**
 *  恢复定时器
 */
-(void)lh_resumeTimer {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

/**
 *  一定时间间隔后，恢复定时器
 *
 *  @param interval 时间间隔
 */
- (void)lh_resumeTimerAfterTimeInterval:(NSTimeInterval)interval {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
