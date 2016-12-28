//
//  UITableViewCell+LH.m
//  Transport
//
//  Created by IMAC on 15/12/3.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "UITableViewCell+LH.h"

@implementation UITableViewCell (LH)

/**
 *  设置分割线为0，iOS8以上在代理方法 willDisplayCell 执行
 */
- (void)lh_setSeparatorInsetZero {
    // iOS7
    self.separatorInset = UIEdgeInsetsZero;
    
    if (IOS_VERSION_8_OR_ABOVE) {// iOS8 以上
        // Prevent the cell from inheriting the Table View's margin settings
        self.preservesSuperviewLayoutMargins = NO;;
        // Explictly set your cell's layout margins
        self.layoutMargins = UIEdgeInsetsZero;
    }
}



/**
 *  设置有圆角 有边距的Cell
 *
 *  @param tableView    列表
 *  @param indexPath
 *  @param headerRadius 顶部的弧度
 *  @param footRadius   底部的弧度
 *  @param bound        边距
 */
-(void)creatRoundedCornersCell:(UITableView *)tableView AndIndexPath:(NSIndexPath *)indexPath AndHeaderCornerRadius:(CGFloat)headerRadius AndFootCornerRadius:(CGFloat)footRadius AndBound:(CGFloat)bound{
    if ([self respondsToSelector:@selector(tintColor)]) {
        
        self.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(self.bounds, bound, 0);
        
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, headerRadius, headerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), headerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), headerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), footRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), footRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            
            CGPathAddRect(pathRef, nil, bounds);
            
            addLine = YES;
            
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        
        
        
        if (addLine == YES) {
            
            CALayer *lineLayer = [[CALayer alloc] init];
            
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            
            lineLayer.backgroundColor = tableView.separatorColor.CGColor;
            
            [layer addSublayer:lineLayer];
            
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        
        self.backgroundView = testView;
    }
}


@end
