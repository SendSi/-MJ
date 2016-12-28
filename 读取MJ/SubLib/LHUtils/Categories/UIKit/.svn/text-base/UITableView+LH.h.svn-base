//
//  UITableView+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshNormalHeader.h"

@interface UITableView (LH)

/**
 *  初始化
 *
 *  @param frame          大小
 *  @param tableViewStyle 表格样式
 *  @param delegate       代理
 *  @param dataSource     数据源
 *
 *  @return 实例
 */
+ (UITableView *)lh_tableViewWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)tableViewStyle delegate:(id<UITableViewDelegate>)delegate dataSourec:(id<UITableViewDataSource>)dataSource;


/**
 *  设置分割线为0，iOS8以上还需要实现代理方法 willDisplayCell
 */
- (void)lh_setSeparatorInsetZero;

/**
 *  从mian bundle里面注册cell nib，nib名字和重用标示符为类名
 *
 *  @param cellClassName 注册cell的类名
 */
- (void)lh_registerNibFromCellClassName:(NSString *)cellClassName;

/**
 *  注册cell类，重用标识符为类名
 *
 *  @param cellClassName 注册cell的类名
 */
- (void)lh_registerClassFromCellClassName:(NSString *)cellClassName;

/**
 *  返回重用cell，重用标示符为cell类名
 *
 *  @param cellClassName 重用cell类名
 *
 *  @return 重用cell
 */
- (id)lh_dequeueReusableCellWithCellClassName:(NSString *)cellClassName;

/**
 *  返回重用cell，重用标示符为cell类名
 *
 *  @param cellClassName 重用cell类名
 *  @param indexPath     cell 路径
 *
 *  @return 重用cell
 */
- (id)lh_dequeueReusableCellWithCellClassName:(NSString *)cellClassName forIndexPath:(NSIndexPath *)indexPath;

@end


@protocol UITableViewRefreshHandlerDelegate <NSObject>

@optional

- (void)tableViewRefreshDataHandle:(UITableView *)tableView;

@end

@interface UITableView (LH_Refresh) //Refresh

@property (nonatomic, assign) NSUInteger pageNo;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) NSArray *refreshDataSource;

- (void)lh_addHeaderHandleEvent:(id<UITableViewRefreshHandlerDelegate>)refreshHandler;
- (void)lh_addFooterHandleEvent:(id<UITableViewRefreshHandlerDelegate>)refreshHandler;
- (void)lh_setRefreshDataSource:(NSArray *)dataSource;

@end
