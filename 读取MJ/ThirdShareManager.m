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
#import <CommonCrypto/CommonCrypto.h>
#import "XMLDictionary.h"

@interface ThirdShareManager()
@property (nonatomic, strong) NSMutableDictionary *payDic;
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
    //wx支付
    else if([resp isKindOfClass:[PayResp class]]){
        NSString *strMsg;
        switch (resp.errCode) {
            case WXSuccess:
                strMsg=@"支付结果:成功!";
                NSLogs(@"-MJ-支付成功啦");
                break;
                
            default:
                strMsg=@"支付结果:失败!";
                NSLogs(@"支付失败,%d,retstr==%@",resp.errCode,resp.errStr);
                break;
                
        }
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
    // 请求授权响应
    if ([response isKindOfClass:[WBAuthorizeResponse class]]) {
        
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            
            WBAuthorizeResponse* auth = (WBAuthorizeResponse*)response;
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


static NSString* title = @"测试lnwy";
static NSString* imageURL = @"http://pic6.huitu.com/res/20130116/84481_20130116142820494200_1.jpg";
static NSString* pageURL = @"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E5%9B%BE%E7%89%87&hs=0&pn=0&spn=0&di=73588436130&pi=0&rn=1&tn=baiduimagedetail&is=0%2C0&ie=utf-8&oe=utf-8&cl=2&lm=-1&cs=1794894692%2C1423685501&os=2269231183%2C2892498381&simid=3483244408%2C577623349&adpicid=0&lpn=0&ln=30&fr=ala&fm=&sme=&cg=&bdtype=0&oriquery=&objurl=http%3A%2F%2Fpic6.huitu.com%2Fres%2F20130116%2F84481_20130116142820494200_1.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fooo_z%26e3Bi7tp7_z%26e3Bv54AzdH3F1jft2gAzdH3Ffi5oAzdH3Fda8na88mAzdH3F89dbda9l9daa_z%26e3Bip4s&gsm=0";
#pragma mark - 分享
-(SendMessageToQQReq *)qqShare{
    return [self qqShare:title image:imageURL url:imageURL descText:@"小小曾给的惊喜"];
}
/**  QQ对话  */
-(void)qqShareSessionWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail{
    QQApiSendResultCode send=[QQApiInterface sendReq:[self qqShare]];
    if(send==EQQAPISENDSUCESS){
        if(blockSuccess) blockSuccess(nil);
    }else{
        if(blockFail)blockFail(@(send));
    }
}
/**  QQ空间  */
-(void)qqShardTimeLineWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail{
    QQApiSendResultCode send=[QQApiInterface SendReqToQZone:[self qqShare]];
    if(send==EQQAPISENDSUCESS){
        if(blockSuccess)blockSuccess(nil);
    }
    else{
        if(blockFail) blockFail(@(send));
    }
}
-(SendMessageToQQReq *)qqShare:(NSString *)titles image:(NSString *)images url:(NSString *)urls descText:(NSString *)descTexts{
    TencentOAuth *auth=[[TencentOAuth alloc] initWithAppId:QQ_APPID andDelegate:nil];
    QQApiNewsObject *h5=[QQApiNewsObject objectWithURL:urls.mj_url title:titles description:descTexts previewImageURL:images.mj_url];
    
    SendMessageToQQReq *req=[SendMessageToQQReq reqWithContent:h5];
    return  req;
}
/**  VC可以指定的 QQ空间  */
-(void)qqshareZoneWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText{
    QQApiSendResultCode send=[QQApiInterface SendReqToQZone:[self qqShare:shareTitle image:shareImage url:sharePage descText:descText]];
    if(send==EQQAPISENDSUCESS){
        if(blockSuccess)blockSuccess(nil);
    }
    else{
        if(blockFail) blockFail(@(send));
    }
}





#pragma mark - wx share
-(SendMessageToWXReq *)wxShareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText{
    SendMessageToWXReq *req=[[SendMessageToWXReq alloc] init];
    req.bText=NO;//多媒体
    
    WXMediaMessage* message = [WXMediaMessage message];
    message.title = shareTitle;
    message.description = descText;
    [message setThumbImage:[UIImage imageNamed:@"123"]];
    WXWebpageObject* web = [WXWebpageObject object];
    web.webpageUrl = pageURL;
    message.mediaObject = web;
    req.message = message;
    return req;
}
-(void)wxShareMessageWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText{
    
    SendMessageToWXReq *req=[self wxShareTitle:shareTitle shareImage:shareImage sharePage:sharePage descText:descText];
    
    req.scene=WXSceneSession;
    BOOL result=[WXApi sendReq:req];
    
    if(result){
        if(blockSuccess) blockSuccess(nil);
    }else{
        if(blockFail) blockFail(@(result));
    }
}

-(void)wxShareFriendWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText{
    SendMessageToWXReq *req=[self wxShareTitle:shareTitle shareImage:shareImage sharePage:sharePage descText:descText];
    
    req.scene=WXSceneTimeline;
    BOOL result=[WXApi sendReq:req];
    
    if(result){
        if(blockSuccess) blockSuccess(nil);
    }else{
        if(blockFail) blockFail(@(result));
    }
}


#pragma mark - sina share
-(void)sinaShareWithSuccess:(idBlock)blockSuccess fail:(idBlock)blockFail shareTitle:(NSString *)shareTitle shareImage:(NSString *)shareImage sharePage:(NSString *)sharePage descText:(NSString *)descText{
    WBMessageObject *message=[WBMessageObject message];
    message.text=@"对话框写的内容";
    
    WBWebpageObject *web=[WBWebpageObject object];
    web.objectID=[NSString stringWithFormat:@"%.0f",[NSDate date].timeIntervalSince1970];
    web.title=shareTitle;
    web.description=descText;
    web.thumbnailData=UIImagePNGRepresentation([UIImage imageNamed:@"123"]);
    web.webpageUrl=sharePage;
    
    message.mediaObject=web;//
    
    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
    request.redirectURI=@"http://led.linkfun.cc";
    request.scope=@"all";
    request.shouldShowWebViewForAuthIfCannotSSO=YES;
    WBSendMessageToWeiboRequest *req=[WBSendMessageToWeiboRequest requestWithMessage:message authInfo:request access_token:nil];
    BOOL result=[WeiboSDK sendRequest:req];
    if(result){
        if(blockSuccess)blockSuccess(nil);
    }else{
        if(blockFail)blockFail(@(result));
    }
    
}




#pragma mark - 支付
-(void)wxPayLNWY{
    PayReq *request = [[PayReq alloc] init] ;
    request.partnerId = MXWechatMCHID;
    request.prepayId= MXWechatPartnerKey;
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= 1397527777;
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    [WXApi sendReq:request];
}


//http://led.linkfun.cc:8092/wx/unifiedorder

//得到partnerId
-(void)getInfoWX{
    HJNetworkClient *client= [[HJNetworkClient alloc] init];
    
    NSDictionary *dic=@{@"price":@"1",@"body":@"body=recharge",@"order_id":@"1234567890"};
    
    [client.manager POST:@"http://led.linkfun.cc:8092/wx/unifiedorder" parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
/** 跳转到支付页面  */
-(void)jumpToWXPayPanel{
    NSDictionary *dicInfo=@{
                            @"wxAppId":WX_APPID,
                            @"wxMCHID":MXWechatMCHID,
                            @"wechatPatenerKey":MXWechatPartnerKey,
                            @"tradeType":@"APP",//交易类型
                            @"totalFee":@"1",//金额
                            @"tradeNO":@"22sf1s2fasfsfsf",//交易号,这个先随写
                            @"addressIP":@"192.168.1.1",//网络地址,wifi下好解决....但4G下就生成不了.....先写死
                            @"orderNo":[NSString stringWithFormat:@"%ld",time(0)],
                            @"notifyUrl":@"http://wxpay.weixin.qq.com/pub_v2/pay/notify.v2.php", //交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
                            @"payTitle":@"资费"
                            };
    [self sendPayInfo:dicInfo];
    //转换成XML字符串,这里只是形似xml,实际并不是正确的xml的格式,需要使用ap方法戴德转义
    NSString *string=[self.payDic XMLString];
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    session.responseSerializer=[[AFHTTPResponseSerializer alloc] init];
    [session.requestSerializer setValue:@"text/xml;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [session.requestSerializer setValue:kUrlWechatPay forHTTPHeaderField:@"SOAPAction"];
    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        return string;
    }];
    [session POST:kUrlWechatPay parameters:string progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseString=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];;
        NSDictionary *dic=[NSDictionary dictionaryWithXMLString:responseString];
        if([[dic objectForKey:@"result_code"]isEqualToString:@"SUCCESS"]   &&   [[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"]){
            //发起微信支付
            PayReq *request=[[PayReq alloc] init];
            request.openID=[dic objectForKey:@"appid"];
            request.partnerId=[dic objectForKey:@"mch_id"];
            request.prepayId=[dic objectForKey:@"prepay_id"];// 预支付交易会话id
            request.package=@"Sign=WXPay";
            request.nonceStr=[dic objectForKey:@"nonce_str"];//随机字符串
            
            NSString *timeSp=[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
            UInt32 timeStamp=[timeSp intValue];
            request.timeStamp=timeStamp;
            
            NSLogs(@"requset.openId==%@",request.openID);
            
            request.sign=[self createMD5SingForPay:request.openID partnerid:request.partnerId
                                          prepayid:request.prepayId
                                           package:request.package
                                          noncestr:request.nonceStr
                                         timestamp:request.timeStamp];
            [WXApi sendReq:request];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
-(void)sendPayInfo:(NSDictionary *)methodInfo{
    [self.payDic setValue:methodInfo[@"wxAppId"] forKey:@"appid"];// 应用id
    [self.payDic setValue:methodInfo[@"wxMCHID"] forKey:@"mch_id"];// 商户号
    [self.payDic setValue:methodInfo[@"tradeNO"] forKey:@"nonce_str"];// 随机字符串
    [self.payDic setValue:methodInfo[@"payTitle"] forKey:@"body"];// 商品描述
    [self.payDic setValue:methodInfo[@"orderNo"] forKey:@"out_trade_no"];// 商户订单号
    [self.payDic setValue:methodInfo[@"totalFee"] forKey:@"total_fee"];// 总金额
    [self.payDic setValue:methodInfo[@"addressIP"] forKey:@"spbill_create_ip"];// 终端IP
    [self.payDic setValue:methodInfo[@"notifyUrl"] forKey:@"notify_url"];//通知地
    [self.payDic setValue:methodInfo[@"tradeType"] forKey:@"trade_type"];//交易类型
   
    [self createMd5Sign:self.payDic];//创建md5的sign签名
}
//创建md5的sign签名
-(void)createMd5Sign:(NSMutableDictionary *)dict{
    NSMutableString *contentString=[NSMutableString string];
    NSArray *keys=[dict allKeys];
    //第一步，设所有发送或者接收到的数据为集合M，将集合M内非空参数值的参数按照参数名ASCII码从小到大排序（字典序），使用URL键值对的格式（即key1=value1&key2=value2…）拼接成字符串stringA。
    //特别注意以下重要规则：
    //◆ 参数名ASCII码从小到大排序（字典序）；
    //◆ 如果参数的值为空不参与签名；
    //◆ 参数名区分大小写；
    //◆ 验证调用返回或微信主动通知签名时，传送的sign参数不参与签名，将生成的签名与该sign值作校验。
    //◆ 微信接口可能增加字段，验证签名时必须支持增加的扩展字段
    
    //按字母顺序排序
    NSArray *sortedArray=[keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSBackwardsSearch];
    }];
    //拼接字符串
    for(NSString *categoryId in sortedArray){
        if(![dict[categoryId] isEqualToString:@""]  && ![dict[categoryId] isEqualToString:@"sign"]  && ![dict[categoryId] isEqualToString:@"key"]){
            [contentString appendFormat:@"%@=%@&",categoryId,dict[categoryId]];
        }
    }
    //再接partnerKey
    [contentString appendFormat:@"key=%@",MXWechatPartnerKey];
    
    //得到md5签名
    NSString *md5Sign=[self md5:contentString];
    [self.payDic setValue:md5Sign forKey:@"sign"];
}

-(NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    //加密规则，因为逗比微信没有出微信支付demo，这里加密规则是参照安卓demo来得
    unsigned char result[16]= "0123456789abcdef";
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //这里的x是小写则产生的md5也是小写，x是大写则md5是大写，这里只能用大写，逗比微信的大小写验证很逗
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
//创建发起支付时的sign签名
-(NSString *)createMD5SingForPay:(NSString *)appid_key
                       partnerid:(NSString *)partnerid_key
                        prepayid:(NSString *)prepayid_key
                         package:(NSString *)package_key
                        noncestr:(NSString *)noncestr_key
                       timestamp:(UInt32)timestamp_key
{
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid_key forKey:@"appid"];
    [signParams setObject:noncestr_key forKey:@"noncestr"];
    [signParams setObject:package_key forKey:@"package"];
    [signParams setObject:partnerid_key forKey:@"partnerid"];
    [signParams setObject:prepayid_key forKey:@"prepayid"];
    [signParams setObject:[NSString stringWithFormat:@"%u",(unsigned int)timestamp_key] forKey:@"timestamp"];
    
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [signParams allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[signParams objectForKey:categoryId] isEqualToString:@""]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[signParams objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [signParams objectForKey:categoryId]];
        }
    }
    
    //添加商户密钥key字段
    [contentString appendFormat:@"key=%@", MXWechatPartnerKey];
    
    NSString *result = [self md5:contentString];
    
    return result;
}



-(NSMutableDictionary *)payDic{
    if(_payDic==nil){
        _payDic=[NSMutableDictionary dictionary];
    }
    return _payDic;
}


@end





















