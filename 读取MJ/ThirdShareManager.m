//
//  ThirdShareManager.m
//  读取MJ
//
//  Created by SunSi on 16/12/25.
//  Copyright © 2016年 SunSi. All rights reserved.
//



#import "ThirdShareManager.h"
#import "AFNetworking.h"
#import "HJBaseAPI.h"
#import "WeiboSDK.h"

@interface ThirdShareManager()

@end



@implementation ThirdShareManager

/**  单例  */
+(instancetype)Instance{
    static ThirdShareManager *_instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[[ThirdShareManager alloc] init];
    });
    return _instance;
}
#pragma mark - QQ登录
-(void)qqLogin_success:(idBlock)success fail:(idBlock)fail{
    self.blockQQFail=fail;
    self.blockQQSuccess=success;
    self.oauth=[[TencentOAuth alloc] initWithAppId:QQ_APPID andDelegate:self];
    
    NSArray *getInfoArr=[NSArray arrayWithObjects:kOPEN_PERMISSION_GET_USER_INFO,kOPEN_PERMISSION_GET_SIMPLE_USER_INFO ,nil];
    
    
    [self.oauth authorize:getInfoArr inSafari:NO];
}

// QQ必传 的代理
-(void)tencentDidLogin{
    [self.oauth getUserInfo];
    NSLog(@"登录成功");
}
-(void)tencentDidLogout{
    
}
-(void)tencentDidNotNetWork{
    self.blockQQFail(@"没网络,失败");
}
-(void)tencentDidNotLogin:(BOOL)cancelled{
    self.blockQQFail(@"登录有误,失败");
}
- (void)getUserInfoResponse:(APIResponse *)response{
    NSDictionary* info = response.jsonResponse;
    NSLog(@"%@", info);
    NSString* sex = info[@"gender"];
    NSDictionary* info_new = @{@"openid"   : self.oauth.openId,
                               @"nickname" : info[@"nickname"],
                               @"headimg"  : info[@"figureurl"],
                               @"province" : info[@"province"],
                               @"city"     : info[@"city"],
                               @"sex"      : [sex isEqualToString:@"男"] ? @0 : @1};
    
    self.blockQQSuccess(info_new);
}


#pragma mark - wx登录
-(void)wxLogin_success:(idBlock)success fail:(idBlock)fail{
    self.blockWXFail=fail;
    self.blockWXSuccess=success;
    if ([WXApi isWXAppInstalled]){
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"App";
        [WXApi sendReq:req];
    }
    else {
        NSLogs(@"wx 登录失败");
    }
}
-(void)onResp:(BaseResp *)resp{
    // 向微信请求授权后,得到响应结果
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp *)resp;
        /**  1.先获取 accessToken,openid   2.再获取用户信息  */
        
        NSString *accessUrlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",  WX_APPID, @"370a177e935643135728415edec63cdb", temp.code];
        
        
        HJNetworkClient *client= [[HJNetworkClient alloc] init];
        [client.manager GET:accessUrlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary   *obj) {
            
            NSString *infoUserStr= [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",obj[@"access_token"],obj[@"openid"]];
            
            [client.manager GET:infoUserStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *dicInfo) {
                NSDictionary *new_dic=@{
                                        @"openid":obj[@"openid"],
                                        @"nickName":dicInfo[@"nickname"],
                                        @"headimg":dicInfo[@"headimgurl"]
                                        };
                self.blockWXSuccess(new_dic);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                self.blockWXFail(@"获取个人信息中~~错误");
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            self.blockWXFail(@"获取accessToken~~错误");
        }];
    }
}

-(void)httpManager:(NSString *)url success:(idBlock)blockSuccess fail:(idBlock)blockFail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain", nil];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        blockSuccess(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        blockFail(error);
    }];
}



#pragma mark - sina
-(void)sinaLogin_success:(idBlock)success fail:(idBlock)fail{
    self.blockSinaFail=fail;
    self.blockSinaSuccess=success;
    //高级信息里的授权回调页：http://led.linkfun.cc
    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
    request.redirectURI=@"http://led.linkfun.cc";//开发者后台:高级信息里的授权回调页：http://led.linkfun.cc
    request.scope=@"all";
    request.userInfo=nil;
    [WeiboSDK sendRequest:request];
}
-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}
-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if([response isKindOfClass:[WBAuthorizeRequest class]]){
        if(response.statusCode==WeiboSDKResponseStatusCodeSuccess){
            WBAuthorizeResponse *auth=(WBAuthorizeResponse *)response;
            NSString *oathStringUrl=[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@",auth.userID,auth.accessToken];
            HJNetworkClient *client= [[HJNetworkClient alloc] init];
            [client.manager GET:oathStringUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *info_new=@{@"openid":responseObject[@"idstr"],
                                         @"nickname":responseObject[@"name"],
                                         @"headimg":responseObject[@"avatar_hd"],
                                         @"province":responseObject[@"province"],
                                         @"city":responseObject[@"city"],
                                         @"sex":[responseObject[@"gender"] isEqualToString:@"m"]?@0:@1
                                         };
                self.blockSinaSuccess(info_new);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                self.blockSinaFail(error);
            }];
        }
        else{
            self.blockSinaFail([NSString stringWithFormat:@"%ld", response.statusCode]);
        }
    }
}































@end












