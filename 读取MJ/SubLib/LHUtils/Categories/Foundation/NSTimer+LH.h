//
//  NSTimer+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (LH)

/**
 *  暂停定时器
 */
- (void)lh_pauseTimer;

/**
 *  恢复定时器
 */
- (void)lh_resumeTimer;

/**
 *  一定时间间隔后，恢复定时器
 *
 *  @param interval 时间间隔
 */
- (void)lh_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
