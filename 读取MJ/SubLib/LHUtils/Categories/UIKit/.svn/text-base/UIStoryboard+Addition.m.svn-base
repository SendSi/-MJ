//
//  UIStoryboard+Addition.m
//  YouYanChuApp
//
//  Created by Ron on 13-12-31.
//  Copyright (c) 2013年 HGG. All rights reserved.
//

#import "UIStoryboard+Addition.h"

@implementation UIStoryboard(Addition)

+ (UIStoryboard*)fromName:(NSString*)name
{
    return [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
}

+ (UIViewController *) getControllerFromController_id:(NSString *)identifier storyBoard_name:(NSString *)name{
    UIStoryboard *storyBoard = nil;
    if (name==NULL) {
        //应用程序的名称和版本号等信息都保存在mainBundle的一个字典中，用下面代码可以取出来。
        NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
        
        name = [infoDict objectForKey:@"UIMainStoryboardFile"];
        storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    }else{
        storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    }
    if (storyBoard == NULL) {
        return NULL;
    }
    
    UIViewController *viewController = [storyBoard instantiateViewControllerWithIdentifier:identifier];
    return viewController;
}


@end
