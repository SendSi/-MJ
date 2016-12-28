//
//  UITableView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UITableView+LH.h"


@implementation UITableView (LH)

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
+ (UITableView *)lh_tableViewWithFrame:(CGRect)frame tableViewStyle:(UITableViewStyle)tableViewStyle delegate:(id<UITableViewDelegate>)delegate dataSourec:(id<UITableViewDataSource>)dataSource {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:tableViewStyle];
    tableView.delegate     = delegate;
    tableView.dataSource   = dataSource;
    
    return tableView;
}

/**
 *  设置分割线为0，iOS8以上还需要实现代理方法 willDisplayCell
 */
- (void)lh_setSeparatorInsetZero {
    // iOS7
    self.separatorInset = UIEdgeInsetsZero;
    
    if (IOS_VERSION_8_OR_ABOVE) {// iOS8 以上
        // Explictly set your cell's layout margins
        self.layoutMargins = UIEdgeInsetsZero;
    }
}

- (void)lh_registerNibFromCellClassName:(NSString *)cellClassName {
    
    [self registerNib:[UINib nibWithNibName:cellClassName bundle:nil] forCellReuseIdentifier:cellClassName];
    
}

- (void)lh_registerClassFromCellClassName:(NSString *)cellClassName {
    
    [self registerClass:NSClassFromString(cellClassName) forCellReuseIdentifier:cellClassName];
}

- (id)lh_dequeueReusableCellWithCellClassName:(NSString *)cellClassName {
    
    return [self dequeueReusableCellWithIdentifier:cellClassName];
}

- (id)lh_dequeueReusableCellWithCellClassName:(NSString *)cellClassName forIndexPath:(NSIndexPath *)indexPath {
    
    return [self dequeueReusableCellWithIdentifier:cellClassName forIndexPath:indexPath];
}

@end

@implementation UITableView (LH_Refresh)

- (void)setPageNo:(NSUInteger)pageNo {
    
    objc_setAssociatedObject(self, @selector(pageNo), @(pageNo), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)pageNo {
    
    NSNumber *pageNo = objc_getAssociatedObject(self, _cmd);
    return pageNo.integerValue;
}

- (void)setPageSize:(NSUInteger)pageSize {
    
    objc_setAssociatedObject(self, @selector(pageSize), @(pageSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSUInteger)pageSize {
    
    NSNumber *pageSize = objc_getAssociatedObject(self, _cmd);
    return pageSize.integerValue;
}

- (void)setRefreshHeader:(MJRefreshNormalHeader *)refreshHeader {
    
    objc_setAssociatedObject(self, @selector(refreshHeader), refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MJRefreshNormalHeader *)refreshHeader {
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setRefreshDataSource:(NSArray *)refreshDataSource {
    
    objc_setAssociatedObject(self, @selector(refreshDataSource), refreshDataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)refreshDataSource {
    
    return objc_getAssociatedObject(self, _cmd);
}


- (void)lh_addHeaderHandleEvent:(id<UITableViewRefreshHandlerDelegate>)refreshHandler{
    
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.pageNo = 1;

        if (refreshHandler&&[refreshHandler respondsToSelector:@selector(tableViewRefreshDataHandle:)]) {
            
            [refreshHandler tableViewRefreshDataHandle:self];
        }
    }];
    self.refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    
    self.mj_header = self.refreshHeader;
    
    [self.refreshHeader beginRefreshing];

}

- (void)lh_addFooterHandleEvent:(id<UITableViewRefreshHandlerDelegate>)refreshHandler {
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.pageNo++;
        
        if (refreshHandler&&[refreshHandler respondsToSelector:@selector(tableViewRefreshDataHandle:)]) {
            [refreshHandler tableViewRefreshDataHandle:self];
        }
    }];
}

- (void)lh_setRefreshDataSource:(NSArray *)dataSource {
    if (self.pageNo == 1) {
        self.refreshDataSource = dataSource.mutableCopy;
    } else {
        
        NSMutableArray *refreshDataSource = self.refreshDataSource.mutableCopy;
        [refreshDataSource addObjectsFromArray:dataSource];
        
        self.refreshDataSource = refreshDataSource;
    }
    
    SEL selector = @selector(reloadData);    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
    
    [self endRefreshing];
}

- (void)endRefreshing{
    [self.refreshHeader endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
