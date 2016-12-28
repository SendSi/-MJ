//
//  UINavigationController+LH.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "UINavigationController+LH.h"
#

@implementation UINavigationController (LH)

- (void)lh_pushViewControllerWithStoryBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier {
    
    UIViewController *controller = [UIViewController lh_createFromStoryboardName:storyBoardName WithIdentifier:identifier];
    [self pushViewController:controller animated:YES];
}

- (void)lh_pushVC:(UIViewController *)viewController {
    
    [self pushViewController:viewController animated:YES];
}

- (void)lh_popVC {
    
    [self popViewControllerAnimated:YES];
}

- (void)lh_popToVC:(UIViewController *)viewController {
    
    [self popToViewController:viewController animated:YES];
    
}

- (void)lh_popToRootVC {
    
    [self popToRootViewControllerAnimated:YES];
}

@end
