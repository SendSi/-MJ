//
//  NSArray+LH.m
//  Cancer
//
//  Created by zhipeng-mac on 16/2/16.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import "NSArray+LH.h"

@implementation NSArray (LH)

- (NSString *)lh_synthetiseStringFromInsideWithBreakString:(NSString *)breakString {
    
    NSMutableString *string = [NSMutableString new];
    
    if (self.count == 1) {
        
        [string appendString:[self firstObject]];
    }
    else {
        [self enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            
            if (idx == 0) {
                
                [string appendString:obj];
            }
            else {
                
            [string appendString:[breakString stringByAppendingString:obj]];
            }
        }];
    }
    
    return string;
}

@end
