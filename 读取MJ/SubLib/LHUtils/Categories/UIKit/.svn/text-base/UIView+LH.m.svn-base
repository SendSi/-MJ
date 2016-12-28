//
//  UIView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+LH.h"
#import <objc/runtime.h>
#import "FXBlurView.h"

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;
static char KDTActionHandlerSwipeBlockKey;
static char KDTActionHandlerSwipeGestureKey;

@implementation UIView (LH)

/**
 *  初始化
 *
 *  @param rect      大小
 *  @param backColor 背景颜色
 *
 *  @return 实例
 */
+ (UIView *)lh_viewWithFrame:(CGRect)rect backColor:(UIColor *)backColor
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    return view;
}


/**
 *  创建内含多个标签按钮视图
 *
 *  @param titleArr           标签名称数组
 *  @param cgrect             视图大小
 *  @param fontSize           标签字号
 *  @param tagHeight          标签高度
 *  @param cornerRadius       标签圆角大小
 *  @param tagBackgroundColor 标签背景颜色
 *  @param tagTitleColor      标签文字颜色
 *  @param borderColor        标签边框颜色
 *  @param borderWidth        标签边框大小
 *
 *  @return 实例
 */
+(UIView *)creatBtn:(NSArray *)titleArr AndFrame:(CGRect)cgrect AndFont:(float)fontSize AndTagHeight:(float)tagHeight AndCornerRadius:(float)cornerRadius AndTagBackgroundColor:(UIColor *)tagBackgroundColor AndTagTintColor:(UIColor *)tagTitleColor AndBorderColor:(UIColor *)borderColor AndBorderWidth:(float)borderWidth{
    
    UIView *view=[[UIView alloc]initWithFrame:cgrect];
    int width  = 0;
    int height = 0;
    int number = 0;
    int han = 0;
    //创建button
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 300 + i;
        
        CGSize titleSize = [titleArr[i] boundingRectWithSize:CGSizeMake(999, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize+1]} context:nil].size;
        titleSize.width += 5;
        
        //自动的折行
        han = han +titleSize.width+5;
        if (han > view.frame.size.width) {
            han = 0;
            han = han + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            number = 0;
            button.frame = CGRectMake(0, (tagHeight+5)*height, titleSize.width, tagHeight);
        }else{
            button.frame = CGRectMake(width+(number*5), (tagHeight+5)*height, titleSize.width, tagHeight);
            width = width+titleSize.width;
        }
        number++;
        //第一个数据为标题  不需要背景边框 并且需要靠边对其
        if (i!=0) {
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = cornerRadius;
            button.layer.borderWidth = borderWidth;
            button.layer.borderColor = borderColor.CGColor;
            button.backgroundColor = tagBackgroundColor;
        }else{
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        [button setTitleColor:tagTitleColor forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        [view addSubview:button];
    }
    
    return view;
}

/**
 *  将视图转为图片
 *
 *  @return 图片
 */
- (UIImage *)lh_toImage {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  拨打电话号码，弹出提示框
 *
 *  @param phoneNumber 电话号码
 *  @param view        指定视图
 */
- (void)telWithPhoneNumber:(NSString *)phoneNumber {
    NSString *str = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    callWebview.delegate = self;
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}

#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLogs(@"call Phone error = %@",error);
}

/**
 *  重设x起点
 *
 *  @param x        新的x坐标
 *  @param animated 是否允许动画
 */
- (void)lh_resetOriginX:(float)x animated:(BOOL)animated {
    CGRect rect = self.frame;
    rect.origin.x = x;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
        }];
    }
    else {
        self.frame = rect;
    }
}

/**
 *  重设y起点
 *
 *  @param y        新的y坐标
 *  @param animated 是否允许动画
 */
- (void)lh_resetOriginY:(float)y animated:(BOOL)animated {
    CGRect rect = self.frame;
    rect.origin.y = y;
    
    if(animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = rect;
        }];
    }
    else {
        self.frame = rect;
    }
}


@end


#pragma mark - 圆角

@implementation UIView (CornerRadius)

/**
 *  设置顶部两个圆角
 *
 *  @param radii 圆角大小
 */
- (void)lh_setUpRadii:(int)radii {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.borderColor = kRedColor.CGColor;
    layer.borderWidth = 2;
    layer.frame = self.bounds;
    self.layer.mask = layer;
}

/**
 *  设置底部两个圆角
 *
 *  @param radii 圆角大小
 */
- (void)lh_setDownRadii:(int)radii {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.frame = self.bounds;
    self.layer.mask = layer;
}

/**
 *  设置四个圆角大小，边框宽度，边框颜色，-1 和 nil表示不设置
 *
 *  @param Radius      圆角大小
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)lh_setCornerRadius:(float)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor {
    if (cornerRadius != -1) {
        self.layer.cornerRadius = cornerRadius;
    }
    if(borderWidth != -1) {
        self.layer.borderWidth = borderWidth;
    }
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    self.layer.masksToBounds = YES;
}



@end


#pragma mark - 动画

@implementation UIView (Animation)

/**
 *  震动
 */
- (void)lh_shake {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

@end


#pragma mark - 视图坐标扩展 -

@implementation UIView (ViewGeometry)

/**
 *  rect移动到中心点
 *
 *  @param rect   原矩形
 *  @param center 中心点
 *
 *  @return 新的矩形
 */
//CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
//{
//    CGRect newrect = CGRectZero;
//    newrect.origin.x = center.x - CGRectGetMidX(rect);
//    newrect.origin.y = center.y - CGRectGetMidY(rect);
//    newrect.size = rect.size;
//    return newrect;
//}

/// 坐标
- (CGPoint)lh_origin {
    return self.frame.origin;
}
- (void)setLh_origin:(CGPoint)lh_origin {
    CGRect newFrame = self.frame;
    newFrame.origin = lh_origin;
    self.frame = newFrame;
}

// 大小
- (CGSize)lh_size {
    return self.frame.size;
}
- (void)setLh_size:(CGSize)lh_size {
    CGRect newFrame = self.frame;
    newFrame.size = lh_size;
    self.frame = newFrame;
}

/// x坐标
- (CGFloat)lh_left {
    return CGRectGetMinX(self.frame);
}
- (void)setLh_left:(CGFloat)lh_left {
    CGRect newFrame = self.frame;
    newFrame.origin.x = lh_left;
    self.frame = newFrame;
}

/// y坐标
- (CGFloat)lh_top{
    return CGRectGetMinY(self.frame);
}
- (void)setLh_top:(CGFloat)lh_top {
    CGRect newFrame = self.frame;
    newFrame.origin.y = lh_top;
    self.frame = newFrame;
}

/// 宽度
- (CGFloat)lh_width{
    return CGRectGetWidth(self.frame);
}
- (void)setLh_width:(CGFloat)lh_width {
    CGRect newFrame = self.frame;
    newFrame.size.width = lh_width;
    self.frame = newFrame;
}

/// 高度
- (CGFloat)lh_height{
    return CGRectGetHeight(self.frame);
}
- (void)setLh_height:(CGFloat)lh_height {
    CGRect rect = self.frame;
    rect.size.height = lh_height;
    self.frame = rect;
}

/// 右面
- (CGFloat)lh_right {
    return CGRectGetMaxX(self.frame);
}
- (void)setLh_right:(CGFloat)lh_right {
    CGFloat delta = lh_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

/// 下面
- (CGFloat)lh_bottom {
    return CGRectGetMaxY(self.frame);
}
- (void)setLh_bottom:(CGFloat)lh_bottom {
    CGRect newframe = self.frame;
    newframe.origin.y = lh_bottom - self.frame.size.height;
    self.frame = newframe;
}

/// y中心
- (CGFloat)lh_centerY {
    return CGRectGetMidY(self.frame);
}
- (void)setLh_centerY:(CGFloat)lh_centerY {
    CGPoint newCenter = self.center;
    newCenter.y = lh_centerY;
    self.center = newCenter;
}

/// x中心
- (CGFloat)lh_centerX {
    return CGRectGetMidX(self.frame);
}
- (void)setLh_centerX:(CGFloat)lh_centerX {
    CGPoint newCenter = self.center;
    newCenter.x = lh_centerX;
    self.center = newCenter;
}


/// 左下角
- (CGPoint)lh_bottomLeft {
    CGFloat x = CGRectGetMinX(self.frame);
    CGFloat y = CGRectGetMaxY(self.frame);
    return CGPointMake(x, y);
}

/// 右下角
- (CGPoint)lh_bottomRight {
    CGFloat x = CGRectGetMaxX(self.frame);
    CGFloat y = CGRectGetMaxY(self.frame);
    return CGPointMake(x, y);
}

/// 右上角
- (CGPoint)lh_topRight {
    CGFloat x = CGRectGetMaxX(self.frame);
    CGFloat y = CGRectGetMinY(self.frame);
    return CGPointMake(x, y);
}


/**
 *  根据传入的子视图与当前视图计算出水平中心开始点
 *
 *  @param subView 子视图
 *
 *  @return 水平中心开始点
 */
- (CGFloat)lh_centerHorizontalWithSubView:(UIView *)subView {
    return (self.lh_width - subView.lh_width) / 2;
}

/**
 *  根据传入的子视图与当前视图计算出垂直中心开始点
 *
 *  @param subView 子视图
 *
 *  @return 垂直中心开始点
 */
- (CGFloat)lh_centerVerticalWithSubView:(UIView *)subView {
    return (self.lh_height - subView.lh_height) / 2;
}

/**
 *  根据传入的子视图与当前视图计算出中心点
 *
 *  @param subView 子视图
 *
 *  @return 中心点
 */
- (CGPoint)lh_centerWithSubView:(UIView *)subView {
    return CGPointMake([self lh_centerHorizontalWithSubView:subView],[self lh_centerVerticalWithSubView:subView]);
}


/**
 *  居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToCenter:(UIView *)subView {
    CGRect rect = subView.frame;
    rect.origin = [self lh_centerWithSubView:subView];
    subView.frame = rect;
    [self addSubview:subView];
}

/**
 *  水平居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToHorizontalCenter:(UIView *)subView {
    CGRect rect = subView.frame;
    rect.origin.x = [self lh_centerHorizontalWithSubView:subView];
    subView.frame = rect;
    [self addSubview:subView];
}

/**
 *  垂直居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToVerticalCenter:(UIView *)subView {
    CGRect rect = subView.frame;
    rect.origin.y = [self lh_centerVerticalWithSubView:subView];
    subView.frame = rect;
    [self addSubview:subView];
}

@end


#pragma mark - 视图层次扩展 -

@implementation UIView (ZOrder)

/**
 *  获取当前视图在父视图中的索引
 *
 *  @return 索引值
 */
- (NSUInteger)lh_getSubviewIndex {
    return [self.superview.subviews indexOfObject:self];
}

/**
 *  将视图置于父视图最上面
 */
- (void)lh_bringToFront {
    [self.superview bringSubviewToFront:self];
}

/**
 *  将视图置于父视图最下面
 */
- (void)lh_sendToBack {
    [self.superview sendSubviewToBack:self];
}

/**
 *  视图层次上移一层
 */
- (void)lh_bringOneLevelUp
{
    int currentIndex = (int)[self lh_getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

/**
 *  视图层次下移一层
 */
- (void)lh_sendOneLevelDown {
    int currentIndex = (int)[self lh_getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

/**
 *  是否在最上面
 *
 *  @return 最上层视图 → YES
 */
- (BOOL)lh_isInFront {
    return [self.superview.subviews lastObject] == self;
}

/**
 *  是否在最下面
 *
 *  @return 最下层视图 → YES
 */
- (BOOL)lh_isAtBack {
    return [self.superview.subviews objectAtIndex:0] == self;
}

/**
 *  视图交换层次
 *
 *  @param swapView 交换的视图
 */
- (void)lh_swapDepthsWithView:(UIView *)swapView {
    [self.superview exchangeSubviewAtIndex:[self lh_getSubviewIndex] withSubviewAtIndex:[swapView lh_getSubviewIndex]];
}

- (void)lh_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIView*)lh_descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child lh_descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}

- (UIView*)lh_ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview lh_ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}

#pragma mark - 视图响应 －

-(void)lh_exclusiveTouchForAllButtons
{
    for (UIView * subview in [self subviews]) {
        if([subview isKindOfClass:[UIButton class]])
            [((UIButton *)subview) setExclusiveTouch:YES];
        else if ([subview isKindOfClass:[UIView class]]){
            [subview lh_exclusiveTouchForAllButtons];
        }
    }
}

#pragma mark - 视图添加手势操作 -

- (void)lh_setTapActionWithBlock:(void (^)(void))block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)lh_setLongPressActionWithBlock:(void (^)(void))block
{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

-(void)lh_setSwipeActionWithBlock:(void (^)(void))block{
    UISwipeGestureRecognizer *gesture = objc_getAssociatedObject(self, &KDTActionHandlerSwipeGestureKey);
    
    if (!gesture) {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForSwipeGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &KDTActionHandlerSwipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &KDTActionHandlerSwipeBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)__handleActionForSwipeGesture:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        void(^action)(void) = objc_getAssociatedObject(self, &KDTActionHandlerSwipeBlockKey);
        
        if (action) {
            action();
        }
    }
}

@end

@implementation UIView(Create)

+ (id)lh_createByFrame:(CGRect)frame
{
    NSString *className = NSStringFromClass(self);
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil] objectAtIndex:0];
    if (view) {
        if (!CGRectIsNull(frame)) {
            view.frame = frame;
        }
    }else {
        view = [[self alloc] initWithFrame:frame];
    }
    return view;
}

@end

@implementation UIView (Effects)

///**
// *  准备高斯模糊
// */
//- (void)prepareToBlur{
//    UIGraphicsBeginImageContext(self.bounds.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    CIContext *context = [CIContext contextWithOptions:nil];
//
//    CIImage *imageToBlur = [CIImage imageWithCGImage:viewImage.CGImage];
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
//    [gaussianBlurFilter setValue:imageToBlur forKey: @"inputImage"];
//    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: 8] forKey: @"inputRadius"];
//    CIImage *resultImage = [gaussianBlurFilter valueForKey: @"outputImage"];
//
//    CGImageRef cgImage = [context createCGImage:resultImage fromRect:self.bounds];
//    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
//    imageView.tag = -1;
//    imageView.image = blurredImage;
//
//    UIView *overlay = [[UIView alloc] initWithFrame:self.bounds];
//    overlay.tag = -2;
//    overlay.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55/255.0 blue:55/255.0 alpha:0.6];
//
//    [imageView setAlpha:0];
//    [overlay setAlpha:0];
//
//    [self addSubview:imageView];
//    [self addSubview:overlay];
//}
//
///**
// *  添加高斯模糊
// */
//- (void)blur{
//
//    UIImageView *imageView = (UIImageView *)[self viewWithTag:-1];
//    UIView *overlay = [self viewWithTag:-2];
//
//    [UIView animateWithDuration:0.6 animations:^{
//        [imageView setAlpha:1];
//        [overlay setAlpha:1];
//    }];
//}
//
///**
// *  撤销高斯模糊
// */
//-(void)unBlur{
//    UIImageView *imageView = (UIImageView *)[self viewWithTag:-1];
//    UIView *overlay = [self viewWithTag:-2];
//
//    [UIView animateWithDuration:0.6 animations:^{
//        [imageView setAlpha:0];
//        [overlay setAlpha:0];
//    }];
//}



/**
 *  添加高斯模糊
 */
- (void)blur{
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:self.window.bounds];
    blurView.dynamic = NO;
    blurView.tintColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    blurView.iterations = 3; //像素偏移度
    blurView.blurRadius = 20; //模糊程度
    [blurView setAlpha:0];
    blurView.tag = 2000;
    [self.window addSubview:blurView];
    
    [UIView animateWithDuration:0.6 animations:^{
        [blurView setAlpha:1];
    }];
}

/**
 *  撤销高斯模糊
 */
-(void)unBlur{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    FXBlurView *blurView = (FXBlurView *)[self.window viewWithTag:2000];
    [UIView animateWithDuration:0.6 animations:^{
        [blurView setAlpha:0];
    } completion:^(BOOL finished) {
        [blurView removeFromSuperview];
    }];
}

@end

@implementation UIView (LayoutConstraintHelper)

- (NSLayoutConstraint*)widthConstraint
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)heightConstraint
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight && !constraint.secondItem && constraint.relation == NSLayoutRelationEqual) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)top2SupviewConstraintWithTopLayoutGuideOwner:(UIViewController*)controller
{
    id topLayoutGuide;
    
    if ([controller respondsToSelector:@selector(topLayoutGuide)]) {
        topLayoutGuide = [controller topLayoutGuide];
    }
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (([constraint.firstItem isEqual:self] && [constraint.secondItem isEqual:topLayoutGuide] && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondAttribute == NSLayoutAttributeBottom) || ([constraint.firstItem isEqual:self] && [constraint.secondItem isEqual:self.superview] && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondAttribute == NSLayoutAttributeTop)) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)bottom2SupviewConstraintWithBottomLayoutGuideOwner:(UIViewController*)controller
{
    id bottomLayoutGuide;
    
    if ([controller respondsToSelector:@selector(bottomLayoutGuide)]) {
        bottomLayoutGuide = [controller bottomLayoutGuide];
    }
    
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if (([constraint.firstItem isEqual:bottomLayoutGuide] && [constraint.secondItem isEqual:self] && constraint.firstAttribute == NSLayoutAttributeTop && constraint.secondAttribute == NSLayoutAttributeBottom) || ([constraint.firstItem isEqual:self.superview] && [constraint.secondItem isEqual:self] && constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondAttribute == NSLayoutAttributeBottom)) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)left2SupviewConstraint
{
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if ([constraint.firstItem isEqual:self] && [constraint.secondItem isEqual:self.superview] && constraint.firstAttribute == NSLayoutAttributeLeading && constraint.secondAttribute == NSLayoutAttributeLeading) {
            return constraint;
        }
    }
    return nil;
}

- (NSLayoutConstraint*)right2SupviewConstraint
{
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if ([constraint.firstItem isEqual:self.superview] && [constraint.secondItem isEqual:self] && constraint.firstAttribute == NSLayoutAttributeTrailing && constraint.secondAttribute == NSLayoutAttributeTrailing) {
            return constraint;
        }
    }
    return nil;
}

@end

@implementation UIView (SelfManager)

#pragma mark - Setter&Getter

- (idBlock)tapActionHandler {
    
    idBlock actionHandler = objc_getAssociatedObject(self, _cmd);
    
    return actionHandler;
}

-(void)setTapActionHandler:(idBlock)tapActionHandler {
    
    objc_setAssociatedObject(self, @selector(tapActionHandler), tapActionHandler, OBJC_ASSOCIATION_COPY);
}

@end
