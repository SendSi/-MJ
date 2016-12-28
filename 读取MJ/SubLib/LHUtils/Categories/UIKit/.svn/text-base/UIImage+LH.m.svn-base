//
//  UIImage+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImage+LH.h"

@implementation UIImage (LH)

/**
 *  截取图中某部分小图
 *
 *  @param rect 矩形区域
 *
 *  @return 截取的图片
 */
- (UIImage *)lh_captureImageWithRect:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    CGSize size = CGSizeMake(rect.size.width, rect.size.height);
    
    // 创建一个新图像上下文
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, subImageRef);
    
    //    CGImageRelease(imageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    
    CGImageRelease(subImageRef);
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

/**
 *  缩放图片
 *
 *  @param size 指定大小
 *
 *  @return 缩放后的图片
 */
- (UIImage *)lh_scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context，并把它设置成为当前正在使用的context
    //Determine whether the screen is retina
    if([[UIScreen mainScreen] scale] == 2.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    }else{
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  通过颜色返回图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage *)lh_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (CGFloat)lh_sizeWidth {
    
    return self.size.width;
}

- (CGFloat)lh_sizeHeight {
    
    return self.size.height;
}

+ (UIImage *)lh_imageWithName:(NSString *)imageName
{
    UIImage *newImage = nil;
    if (iOS7) {
        newImage = [UIImage imageNamed:[imageName stringByAppendingString:@"_os7"]];
    }
    if (newImage == nil) {
        newImage = [UIImage imageNamed:imageName];
    }
    return newImage;
    
}
+ (UIImage *)lh_resizableImageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    // 获取原有图片的宽高的一半
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    
    // 生成可以拉伸指定位置的图片
    UIImage *newImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    
    return newImage;
}

- (UIImage*)lh_scaleImageWithSize:(CGSize)size
{
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

///**
// *  <#Description#>
// *
// *  @param width  <#width description#>
// *  @param height <#height description#>
// *
// *  @return <#return value description#>
// */
//- (UIImage*)transformWidth:(CGFloat)width
//                    height:(CGFloat)height {
//
//    CGFloat destW = width;
//    CGFloat destH = height;
//    CGFloat sourceW = width;
//    CGFloat sourceH = height;
//
//    CGImageRef imageRef = self.CGImage;
//    CGContextRef bitmap = CGBitmapContextCreate(NULL,
//                                                destW,
//                                                destH,
//                                                CGImageGetBitsPerComponent(imageRef),
//                                                4*destW,
//                                                CGImageGetColorSpace(imageRef),
//                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
//
//    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
//
//    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
//    UIImage *resultImage = [UIImage imageWithCGImage:ref];
//    CGContextRelease(bitmap);
//    CGImageRelease(ref);
//
//    return resultImage;
//}

@end
