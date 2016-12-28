//
//  HJUser.m
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJUser.h"

#define kHJUserFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"HJUser"]

@implementation HJLoginModel


@end


@implementation HJUser

singleton_m(User)

- (instancetype)init {
    
    HJUser *localUser = [HJUser read];
    
    if (localUser) {
        _instance = localUser;
    } else {
        
        _instance = [super init];
    }
    
    return _instance;
}


- (HJLoginModel *)userModel {
    if (!_userModel) {
        _userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kHJUserFilePath];
    }
    return _userModel;
}

- (void)setUserModel:(HJLoginModel *)userModel {
    _userModel = userModel;
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:userModel toFile:kHJUserFilePath];
    if (isSuccess) {
        NSLogs(@"个人信息归档成功：%@", kHJUserFilePath);
    }
}

-(BOOL)isFirstEnterApp{
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    return [ud boolForKey:@"isFirstEnterApp"];
}
-(void)setIsFirstEnterApp:(BOOL)isFirstEnterApp{
    NSUserDefaults * ud =[NSUserDefaults standardUserDefaults];
    [ud setBool:isFirstEnterApp forKey:@"isFirstEnterApp"];
}


@end
