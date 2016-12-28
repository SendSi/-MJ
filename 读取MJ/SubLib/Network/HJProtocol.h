//
//  HJBaseAPIProtocol.h
//  Cancer
//
//  Created by zhipeng-mac on 16/2/23.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HJDataHandlerProtocol <NSObject>

@optional

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject;

- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject;

- (void)netWorkRequestSuccessDealWithResponseObject :(NSString *)phoneUserIco ids:(id)responseObject;
@end
