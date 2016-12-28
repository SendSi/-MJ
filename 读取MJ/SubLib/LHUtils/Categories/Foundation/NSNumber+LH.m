//
//  NSNumber+LH.m
//  Test
//
//  Created by lh on 15/11/30.
//  Copyright © 2015年 lh. All rights reserved.
//

#import "NSNumber+LH.h"

@implementation NSNumber (LH)

/**
 *  将 num 四舍五入
 *
 *  @param position 在指定位数四舍五入
 *
 *  @return 新值的字符串
 */
- (NSString *)lh_roundAfterPoint:(int)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    float num = [self floatValue];
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:num];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@", roundedOunces];
}

/**
 *  格式化小数 四舍五入类型
 *
 *  @param format 格式
 *
 *  @return 新值的字符串
 */
- (NSString *)lh_decimalwithFormat:(NSString *)format {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.positiveFormat = format;
    
    return  [numberFormatter stringFromNumber:self];
}

@end
