//
//  BaseModel.m
//  Bsh
//
//  Created by IMAC on 15/12/16.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJBaseModel.h"

@implementation HJBaseModel

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (NSString *)debugDescription {
    
    return [NSString stringWithFormat:@"%@\n%@", [super debugDescription], [self mj_keyValues]];
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (oldValue == nil || oldValue == [NSNull null]) {
        if (property.type.typeClass == [NSArray class]) {
            return @[];
        }
        else if (property.type.typeClass == [NSDictionary class]) {
            return @{};
        }
        return @"";
    }
    return oldValue;
}

#pragma mark - <BaseModelReadWriteProtocol>

MJCodingImplementation

+ (NSString *)filePath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return [cachePath stringByAppendingPathComponent:NSStringFromClass(self.class)];
}

+ (instancetype)read {
    NSString *filePath = [self filePath];
    if (filePath && [[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    return nil;
}

- (void)write {
    NSString *filePath = [[self class] filePath];
    if (filePath) {
        BOOL isSuccess = [NSKeyedArchiver archiveRootObject:self toFile:filePath];
        if (isSuccess) {
            NSLog(@"归档 %@ 成功", self.class);
        }
    }
}

@end
