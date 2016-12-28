//
//  UITableViewCell+LH.h
//  Transport
//
//  Created by IMAC on 15/12/3.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (LH)

/**
 *  设置分割线为0，iOS8以上在代理方法 willDisplayCell 执行
 */
- (void)lh_setSeparatorInsetZero;

/**
 *  设置有圆角 有边距的Cell
 *
 *  @param tableView    列表
 *  @param indexPath
 *  @param headerRadius 顶部的弧度
 *  @param footRadius   底部的弧度
 *  @param bound        边距
 */
-(void)creatRoundedCornersCell:(UITableView *)tableView AndIndexPath:(NSIndexPath *)indexPath AndHeaderCornerRadius:(CGFloat)headerRadius AndFootCornerRadius:(CGFloat)footRadius AndBound:(CGFloat)bound;
@end
