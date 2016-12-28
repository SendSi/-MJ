//
//  UINavigationController+LH.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (LH)

/**
 *  @author hejing
 *
 *  跳转时animated默认为YES
 */

- (void)lh_pushViewControllerWithStoryBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier;

- (void)lh_pushVC:(UIViewController *)viewController;

- (void)lh_popVC;

- (void)lh_popToVC:(UIViewController *)viewController;

- (void)lh_popToRootVC;

@end
