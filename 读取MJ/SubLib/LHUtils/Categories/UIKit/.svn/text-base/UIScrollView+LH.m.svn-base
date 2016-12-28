//
//  UIScrollView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIScrollView+LH.h"

@implementation UIScrollView (LH)

/**
 *  初始化
 *
 *  @param frame           大小
 *  @param contentSize     内容大小
 *  @param backgroundColor 背景颜色
 *  @param delegate        代理
 *
 *  @return 实例
 */
+ (UIScrollView *)lh_scrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize backgroundColor:(UIColor *)backgroundColor delegate:(id<UIScrollViewDelegate>)delegate {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.contentSize     = contentSize;
    scrollView.backgroundColor = backgroundColor;
    scrollView.delegate        = delegate;
    
    return scrollView;
}

@end
