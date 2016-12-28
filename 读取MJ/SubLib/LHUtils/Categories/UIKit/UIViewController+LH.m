//
//  UIViewController+LH.m
//  
//
//  Created by zhipeng-mac on 16/2/23.
//
//

#import "UIViewController+LH.h"
#import "UIStoryboard+Addition.h"

@implementation UIViewController (LH)

@end

@implementation UIViewController (NavigationItem)

- (void)lh_setRightNavigationItemWithTitle:(NSString *)title actionBlock:(voidBlock)actionBlock {
    
    CGFloat buttonTitleWidth = [title lh_sizeWithFont:FONT(14) constrainedToSize:CGSizeMake(MAXFLOAT, 14)].width;
    UIButton *navRightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonTitleWidth+20, 30)];
    [navRightButton setTitle:title forState:UIControlStateNormal];
    [navRightButton bk_addEventHandler:^(id sender) {
        
        !actionBlock?:actionBlock();
        
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navRightButton];
    self.navigationItem.rightBarButtonItems = [self rightBarButtonItemsWithOffSetBarButtonItem:rightButtonItem Offset:5];
}


@end

@implementation UIViewController(Create)

+ (id)lh_create
{
    NSString *className = NSStringFromClass([self class]);
    id newObj = [[UIStoryboard fromName:className] instantiateInitialViewController];
    return newObj;
}

+ (id)lh_createFromStoryboardName:(NSString *)sbName WithIdentifier:(NSString *)identifier;
{
    if (sbName && identifier) {
        
        UIStoryboard *storyboard = [UIStoryboard fromName:sbName];
        
        return [storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }
    return nil;
}

+ (id)lh_createFromStoryboardName:(NSString *)sbName {
    //    return  [self lh_createFromStoryboardName:sbName WithIdentifier:[self className]];
   return  [self lh_createFromStoryboardName:sbName WithIdentifier:NSStringFromClass(self)];
}



@end

@implementation UIViewController (BarButtonItemOffset)

-(NSArray *)rightBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset {
    
    return @[[self fixedSpaceItemWithOffset:offset], barButtomItem];
    
}

- (NSArray *)leftBarButtonItemsWithOffSetBarButtonItem:(UIBarButtonItem *)barButtomItem Offset:(CGFloat)offset {
    
    return @[[self fixedSpaceItemWithOffset:-offset], barButtomItem];
}

- (UIBarButtonItem *)fixedSpaceItemWithOffset:(CGFloat)offset {
    
    UIBarButtonItem *fixedSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceItem.width = -offset;
    
    return fixedSpaceItem;
}

@end
