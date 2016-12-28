//
//  UIImageView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIImageView+LH.h"

@implementation UIImageView (LH)
/** 设图片  */
-(void)lh_setImage:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName]];
}
/**
 *  初始化
 *
 *  @param frame 大小
 *  @param image 图片
 *
 *  @return 实例
 */
+ (UIImageView *)lh_imageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

- (void)lh_setRoundImageViewWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self.layer setCornerRadius:CGRectGetHeight([self bounds]) / 2];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
}

/**
 *  初始化
 *
 *  @param frame                  大小
 *  @param image                  图片
 *  @param userInteractionEnabled 是否用户交互
 *
 *  @return 实例
 */
+ (UIImageView *)lh_imageViewWithFrame:(CGRect)frame image:(UIImage *)image userInteractionEnabled:(BOOL)userInteractionEnabled {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.userInteractionEnabled = userInteractionEnabled;
    return imageView;
}

-(void)lh_setImageWithImagePartUrlString:(NSString *)imagePartUrl placeholderImage:(UIImage *)placeholder {
    
    NSString *imageWholeUrl = [kAPIImageFromUrl(imagePartUrl) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:imageWholeUrl] placeholderImage:placeholder];
}

@end

#import <MobileCoreServices/MobileCoreServices.h>
@interface UIImageView ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIImage *pickerImg;
@property (nonatomic, copy) voidBlock finshiSelectedPhoto;
@end
@implementation UIImageView (PickerPhoto)
-(UIImage *)pickImageWithController:(UIViewController *)controller
{
    self.controller = controller;
    [self showPhotoSheetActionWithFinishSelectedBlock:^(UIImage *image) {
        self.pickerImg = image;
    }];
    return self.pickerImg;
}

#pragma mark - 拍照 & 相册

- (void)showPhotoSheetActionWithFinishSelectedBlock:(idBlock)finshiSelectedPhoto {
    
    self.finshiSelectedPhoto = finshiSelectedPhoto;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
    [actionSheet bk_setWillDismissBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
            // 相册
            [self getMediaFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        }else if (buttonIndex == 1) {
            // 拍照
            [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
        }
        
    }];
    [actionSheet showInView:self.controller.view];
}
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = sourceType;
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self.controller presentViewController:ipc animated:YES completion:nil];
    }else {
        [UIAlertView lh_showWithMessage:@"当前设备不支持拍摄功能"];
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
            self.finshiSelectedPhoto(image);
            
        }];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    picker.delegate = nil;
    picker = nil;
}

- (void)setRoundImageViewWithBorderWidth:(CGFloat)borderWidth
{
    [self.layer setCornerRadius:CGRectGetHeight([self bounds]) / 2];
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
}
@end

