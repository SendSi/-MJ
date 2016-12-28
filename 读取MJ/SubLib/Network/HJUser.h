//
//  HJUser.h
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJBaseModel.h"
@class HJLoginModel;

@interface HJLoginModel : HJBaseModel
@property (nonatomic, assign) NSNumber *userState;
@property (nonatomic, assign) NSNumber *userId;
@property (nonatomic, strong) NSString *userSign;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *token;
@end

@interface HJUser : HJBaseModel {
    HJLoginModel *_userModel;
}

singleton_h(User)

@property (nonatomic, strong) HJLoginModel *loginModel;

@property (nonatomic, assign) BOOL isRememberPwd;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL isLogin;

-(BOOL)isFirstEnterApp;
-(void)setIsFirstEnterApp:(BOOL)isFirstEnterApp;

@end
