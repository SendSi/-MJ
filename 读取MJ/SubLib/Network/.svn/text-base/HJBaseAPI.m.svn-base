//
//  HJBaseAPI.m
//  Bsh
//
//  Created by lh on 15/12/21.
//  Copyright © 2015年 lh. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJUser.h"

static NSString * const kParametersAddTokenKeyPath = @"parametersAddToken";

@interface HJBaseAPI ()


@end

@implementation HJBaseAPI

- (NSString *)debugDescription {
    NSArray *keys = @[
                      @"code",
                      @"msg",
                      @"data",
                      ];
    
    return [NSString stringWithFormat:@"%@\n%@", [super debugDescription], [self mj_keyValuesWithKeys:keys]];
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if (oldValue == nil || oldValue == [NSNull null]) {
        return @"";
    }
    return oldValue;
}

- (HJNetworkClient *)netWorkClient {
    return [HJNetworkClient networkClientWithSubUrl:self.subUrl parameters:self.parameters files:self.uploadFile HJBaseAPI:self];
}

- (BOOL)isKindOfAPIClass:(Class)apiClass {
    
    if ([self isKindOfClass:apiClass]) {
        
        return YES;
    }
    
    return NO;
}

- (NSMutableDictionary *)parameters {
    
    if (!_parameters) {
        
        _parameters = [NSMutableDictionary dictionary];
    }
    
    return _parameters;
}

@end

@implementation HJBaseAPI (HUD)

@dynamic containerView;
@dynamic HUD;
@dynamic showErrorMsg;

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //KVO
        [self addObserver:self forKeyPath:kParametersAddTokenKeyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        self.showErrorMsg = YES;
        self.showFailureMsg = YES;
        self.parametersAddToken = YES;
    }
    return self;
}

- (void)dealloc {
    
    [self removeObserver:self forKeyPath:kParametersAddTokenKeyPath];
}

#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:kParametersAddTokenKeyPath])
    {
        if (self.parametersAddToken) {
            
            [self addUserIdAndToken];
        }
    }
}


#pragma mark - Getter

- (UIView *)containerView {
    UIView *containerView = objc_getAssociatedObject(self, _cmd);
    
    return containerView ?: [UIApplication sharedApplication].keyWindow;
}

- (MBProgressHUD *)HUD {
    MBProgressHUD *hud = objc_getAssociatedObject(self, _cmd);
    
    return hud;
}

- (BOOL)isShowErrorMsg {
    NSNumber *isShowErrorMsg = objc_getAssociatedObject(self, _cmd);
    
    return isShowErrorMsg.boolValue;
}

- (BOOL)isShowFailureMsg {
    NSNumber *isShowFailureMsg = objc_getAssociatedObject(self, _cmd);
    
    return isShowFailureMsg.boolValue;
}

- (BOOL)isParametersAddToken {
    NSNumber *isParametersAddToken = objc_getAssociatedObject(self, _cmd);
    
    return isParametersAddToken.boolValue;
}

#pragma mark - Setter

- (void)setContainerView:(UIView *)containerView {
    objc_setAssociatedObject(self, @selector(containerView), containerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHUD:(MBProgressHUD *)HUD {
    objc_setAssociatedObject(self, @selector(HUD), HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShowErrorMsg:(BOOL)showErrorMsg {
    objc_setAssociatedObject(self, @selector(isShowErrorMsg), @(showErrorMsg), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setShowFailureMsg:(BOOL)showFailureMsg {
    objc_setAssociatedObject(self, @selector(isShowFailureMsg), @(showFailureMsg), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setParametersAddToken:(BOOL)parametersAddToken {
    objc_setAssociatedObject(self, @selector(isParametersAddToken), @(parametersAddToken), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - ParameterAddToken

- (void)addUserIdAndToken {
    
    HJLoginModel *loginModel = [HJUser sharedUser].loginModel;
    if (loginModel) {
        [self.parameters setObject:loginModel.userId forKey:@"userId"];
        [self.parameters setObject:loginModel.token forKey:@"token"];
    }
}

#pragma mark - MBProgressHUD

- (void)mbShowIndeterminate:(BOOL )isShow {
    if(isShow)
    {
    self.HUD = [MBProgressHUD showHUDAddedTo:self.containerView animated:YES];
    [self.HUD show:YES];
    }
}

- (void)mbShowText:(NSString *)text {
    
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.detailsLabelText = text;
    self.HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    [self.HUD show:YES];
    [self hideHUDWhileFinishAfterDelay:1.0];
}

#pragma mark - HUD

- (void)showHUDWhileRequest:(UIView *)containerView isShow:(BOOL)isShow{
    self.containerView = containerView;
    [self mbShowIndeterminate:isShow];
}

- (void)hideHUDWhileFinish {
    [self hideHUDWhileFinishAfterDelay:0];
}

- (void)hideHUDWhileFinishAfterDelay:(NSTimeInterval)delay {
    [self.HUD hide:YES afterDelay:delay];
    
#ifdef kNCLoaclResponse
    NSLog(@"加载本地数据文件 -----  __%@__   -----", self.class);
#endif
}

- (void)showMsgWhileJSONError {
    
    if (self.isShowErrorMsg) {
        
        [self mbShowText:@"服务器错误"];
    }else {
        
        [self hideHUDWhileFinish];
    }
}

- (void)showMsgWhileRequestFailure:(NSString *)msg {
    
    if (self.isShowFailureMsg) {
        
        [self mbShowText:msg];
        
    }else {
        
        [self hideHUDWhileFinish];
    }
}

- (void)showMsgWhileTokenExpire:(NSString *)msg {
    
    [self hideHUDWhileFinish];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifation_TokenInvalidate object:msg];
    // mb显示不了
    //    [self mbShowText:msg];
}

- (void)showMsgWhileRequestError:(NSString *)msg {
    [self mbShowText:msg];
}


#pragma mark - LocalResponse

- (NSString *)localResponseDataPath {
    NSString *filename = [NSString stringWithFormat:@"__%@__", NSStringFromClass(self.class)];
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:filename ofType:nil inDirectory:@"LocalResponse/Data"];
    
    return dataPath;
}

- (NSDictionary *)localResponseJSON {
    NSString *dataPath = [self localResponseDataPath];
    if (dataPath) {
        NSData *data = [NSData dataWithContentsOfFile:dataPath];
        NSError *error;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        return json;
    }
    
    return nil;
}

- (void)retrunCodeEqualToSuccessDoNextStep:(voidBlock)nextStep {
    
    if (self.code == NetworkCodeTypeSuccess) {
        
        nextStep();
    }
}

- (void)retrunMsgEqualTo:(NSString *)msg doNextStep:(voidBlock)nextStep {
    
    if ([self.msg isEqualToString:msg]) {
        
        nextStep();
    }
}

@end
