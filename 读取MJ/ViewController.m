//
//  ViewController.m
//  读取MJ
//
//  Created by SunSi on 16/12/18.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "ViewController.h"
#import "RGUtilObject.h"
//sortedArrayUsingDescriptors
#import <TencentOpenAPI/TencentOAuth.h>
#import "ThirdShareManager.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   NSLog(@"%@",   NSHomeDirectory());
    NSArray<RGUtilModel *> *be= RGUtilObject.instance.allArrItems;//必须先 得到数据
    NSLog(@"data===%@",[be lastObject].name);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  /** 数据整理  */
    NSArray *myDataArray =@[@"a1", @"b2", @"a5", @"a4", @"555", @"66666"];
    NSArray *descriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]];
    NSArray *resultArray = [myDataArray sortedArrayUsingDescriptors:descriptors];
    NSLog(@"%@", resultArray);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)clickRead:(UIButton *)sender {
    NSArray<RGUtilModel *> *be= RGUtilObject.instance.allArrItems;
    NSLog(@"be===%@",[be lastObject].name);
}

- (IBAction)clickWrite:(UIButton *)sender {
    
    RGUtilModel *model=[[RGUtilModel alloc] init];
    model.name=@"名字210";
    model.number=210;
    model.address=41;
    model.mode=71;
    model.datas=@[@11,@21,@31].mutableCopy;
  
    [RGUtilObject.instance addItems:@[model]];
}

- (IBAction)clickImport:(UIButton *)sender {
         [RGUtilObject.instance save];
}

- (IBAction)sinaLogin:(UIButton *)sender {
    [ThirdShareManager.Instance sinaLogin_success:^(NSDictionary *getUserDic) {
        NSLogs(@"user===%@,head===%@,dicAll===%@",getUserDic[@"nickname"],getUserDic[@"headimg"],getUserDic);
    } fail:^(NSString *obj) {
        NSLogs(@"objErr==%@",obj);
    }];
}

- (IBAction)clickQQShare:(UIButton *)sender {
    [ThirdShareManager.Instance qqShareSessionWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    }];
//    NSDictionary *qq=@{@"image":@"icon_qq02",@"handler":^{
//
//    }
//};
}

- (IBAction)ClickQQZoneShare:(UIButton *)sender {
    [ThirdShareManager.Instance qqShardTimeLineWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    }];
}

- (IBAction)clickQQZoneVC:(UIButton *)sender {
    [ThirdShareManager.Instance qqshareZoneWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    } shareTitle:@"小小曾测试" shareImage:@"http://news.youth.cn/gn/201702/W020170213297482155817.jpg" sharePage:@"https://www.baidu.com/" descText:@"百度一下"];
}

- (IBAction)clickWxMsgShare:(UIButton *)sender {
    [ThirdShareManager.Instance wxShareMessageWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    } shareTitle:@"小小曾测试" shareImage:@"http://news.youth.cn/gn/201702/W020170213297482155817.jpg" sharePage:@"https://www.baidu.com/" descText:@"百度一下"];
    
}

- (IBAction)clickWXFriendShare:(UIButton *)sender {
    [ThirdShareManager.Instance wxShareFriendWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    } shareTitle:@"小小曾测试" shareImage:@"http://news.youth.cn/gn/201702/W020170213297482155817.jpg" sharePage:@"https://www.baidu.com/" descText:@"百度一下"];
}

- (IBAction)clickSinaShare:(UIButton *)sender {
    [ThirdShareManager.Instance sinaShareWithSuccess:^(id obj) {
        
    } fail:^(id obj) {
        
    } shareTitle:@"测试的小小曾" shareImage:@"http://news.youth.cn/gn/201702/W020170213297482155817.jpg" sharePage:@"https://www.baidu.com/" descText:@"百悦者"];
}

- (IBAction)ClickWXPay:(UIButton *)sender {
    [ThirdShareManager.Instance getInfoWX];
    
}

- (IBAction)click_wx_pay2:(UIButton *)sender {
}









- (IBAction)login_QQ:(id)sender {
    
    [ThirdShareManager.Instance qqLogin_success:^(NSDictionary *obj) {
        NSLogs(@"dic==%@",obj);
        
    } fail:^(NSString *failInfo) {
        
    }];
}

- (IBAction)loginWX:(id)sender {
    [ThirdShareManager.Instance wxLogin_success:^(NSDictionary *obj) {
             NSLog(@"dic wx==%@",obj);
    } fail:^(NSString *failInfo) {
        
    }];
}






@end
