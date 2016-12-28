//
//  UIViewController+LH.h
//  
//
//  Created by zhipeng-mac on 16/2/23.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (LH)

@end

@interface UIViewController (NavigationItem)

/**
 *  设置导航栏右边按钮item
 *
 *  @param title       按钮名字
 *  @param actionBlock 按钮响应方法
 */

- (void)lh_setRightNavigationItemWithTitle:(NSString *)title actionBlock:(voidBlock)actionBlock;

@end

@interface UIViewController (Create)

+ (instancetype)lh_create;

/**
 *  从storyBoard创建viewController
 *
 *  @param sbName     stroyBoard名字
 *  @param identifier viewController标识符
 *
 *  @return viewController对象
 */
+ (id)lh_createFromStoryboardName:(NSString *)sbName WithIdentifier:(NSString *)identifier;

/**
 *  从storyBoard创建viewController，viewController标识符为控制器类名
 *
 *  @param sbName stroyBoard名字
 *
 *  @return viewController对象
 */
+ (id)lh_createFromStoryboardName:(NSString *)sbName;

@end

@interface UIViewController  (BarButtonItemOffset);

//offset大于0往右偏移
- (NSArray *)rightBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset;

- (NSArray *)leftBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset;

@end
