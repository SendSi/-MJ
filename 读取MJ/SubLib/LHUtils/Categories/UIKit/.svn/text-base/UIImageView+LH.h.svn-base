//
//  UIImageView+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LH)

/** 设图片  */
-(void)lh_setImage:(NSString *)imageName;

/**
 *  初始化
 *
 *  @param frame 大小
 *  @param image 图片
 *
 *  @return 实例
 */
+ (UIImageView *)lh_imageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 *  imageView设置成圆形，有圆环边框
 *
 *  @param borderWidth 圆形边框间距大小
 *  @param borderColor 圆形边框间距颜色
 */
- (void)lh_setRoundImageViewWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  初始化
 *
 *  @param frame                  大小
 *  @param image                  图片
 *  @param userInteractionEnabled 是否用户交互
 *
 *  @return 实例
 */
+ (UIImageView *)lh_imageViewWithFrame:(CGRect)frame image:(UIImage *)image userInteractionEnabled:(BOOL)userInteractionEnabled;

/**
 *  根据图片部分url接口地址加载imageView图片
 *
 *  @param imagePartUrl 图片部分url接口地址
 *  @param placeholder  图片未加载完毕背景图片
 */
- (void)lh_setImageWithImagePartUrlString:(NSString *)imagePartUrl placeholderImage:(UIImage *)placeholder;

@end

@interface UIImageView (PickerPhoto)

-(UIImage *)pickImageWithController:(UIViewController *)controller;
- (void)setRoundImageViewWithBorderWidth:(CGFloat)borderWidth;
@end
