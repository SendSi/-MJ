//
//  UIImage+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LH)

/**
 *  截取图中某部分小图
 *
 *  @param rect 矩形区域
 *
 *  @return 截取的图片
 */
- (UIImage *)lh_captureImageWithRect:(CGRect)rect;

/**
 *  缩放图片
 *
 *  @param size 指定大小
 *
 *  @return 缩放后的图片
 */
- (UIImage *)lh_scaleToSize:(CGSize)size;

/**
 *  通过颜色返回图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)lh_imageWithColor:(UIColor *)color;

/**
 *  @author hejing
 *
 *  图片的size宽度
 *
 *  @return 图片的size宽度
 */
- (CGFloat)lh_sizeWidth;

/**
 *  @author hejing
 *
 *  图片的size高度
 *
 *  @return 图片的size高度
 */
- (CGFloat)lh_sizeHeight;

/**
 *  争对ios7以上的系统适配新的图片资源
 *
 *  @param imageName 图片名称
 *
 *  @return 新的图片
 */
+ (UIImage*)lh_imageWithName:(NSString *) imageName;

/**
 *  生成可以拉伸指定位置的图片
 *
 *  @param imageName 图片名字
 *
 *  @return 新的图片
 */
+ (UIImage*)lh_resizableImageWithName:(NSString *)imageName;

/**
 *  图片缩放
 *
 *  @param size 指定大小
 *
 *  @return 缩放后的图片
 */
- (UIImage*)lh_scaleImageWithSize:(CGSize)size;


@end
