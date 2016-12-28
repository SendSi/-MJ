//
//  BaseModel.h
//  Bsh
//
//  Created by IMAC on 15/12/16.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseModelReadWriteProtocol <NSCoding,NSCopying>

/**
 *  本地文件路径
 *
 *  @return 本地文件路径
 */
+ (NSString *)filePath;

/**
 *  读取本地
 *
 *  @return model
 */
+ (instancetype)read;

/**
 *  写入本地
 */
- (void)write;

@end


/**
 *  父 Model
 */
@interface HJBaseModel : NSObject<BaseModelReadWriteProtocol>

@end

