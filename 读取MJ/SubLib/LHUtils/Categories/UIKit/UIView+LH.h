//
//  UIView+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LH) <UIWebViewDelegate>

/**
 *  初始化
 *
 *  @param rect      大小
 *  @param backColor 背景颜色
 *
 *  @return 实例
 */
+ (UIView *)lh_viewWithFrame:(CGRect)rect backColor:(UIColor *)backColor;

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
+(UIView *)creatBtn:(NSArray *)titleArr AndFrame:(CGRect)cgrect AndFont:(float)fontSize AndTagHeight:(float)tagHeight AndCornerRadius:(float)cornerRadius AndTagBackgroundColor:(UIColor *)tagBackgroundColor AndTagTintColor:(UIColor *)tagTitleColor AndBorderColor:(UIColor *)borderColor AndBorderWidth:(float)borderWidth;

/**
 *  将视图转为图片
 *
 *  @return 图片
 */
- (UIImage *)lh_toImage;

/**
 *  拨打电话号码，弹出提示框
 *
 *  @param phoneNumber 电话号码
 *  @param view        指定视图
 */
- (void)telWithPhoneNumber:(NSString *)phoneNumber;

/**
 *  重设x起点
 *
 *  @param x        新的x坐标
 *  @param animated 是否允许动画
 */
- (void)lh_resetOriginX:(float)x animated:(BOOL)animated;

/**
 *  重设y起点
 *
 *  @param y        新的y坐标
 *  @param animated 是否允许动画
 */
- (void)lh_resetOriginY:(float)y animated:(BOOL)animated;

@end


#pragma mark - 圆角

@interface UIView (CornerRadius)

/**
 *  设置顶部两个圆角
 *
 *  @param radii 圆角大小
 */
- (void)lh_setUpRadii:(int)radii;

/**
 *  设置底部两个圆角
 *
 *  @param radii 圆角大小
 */
- (void)lh_setDownRadii:(int)radii;

/**
 *  设置四个圆角大小，边框宽度，边框颜色，-1 和 nil表示不设置
 *
 *  @param Radius      圆角大小
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)lh_setCornerRadius:(float)Radius borderWidth:(float)Width borderColor:(UIColor *)BorderColor;

@end


#pragma mark - 动画

@interface UIView (Animation)

/**
 *  震动
 */
- (void)lh_shake;

@end


#pragma mark - 视图坐标扩展

@interface UIView (ViewFrameGeometry)

/**
 *  rect移动到中心点
 *
 *  @param rect   原矩形
 *  @param center 中心点
 *
 *  @return 新的矩形
 */
//CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

/// 坐标
@property (assign, nonatomic) CGPoint lh_origin;
/// 大小
@property (assign, nonatomic) CGSize lh_size;

/// x坐标
@property (assign, nonatomic) CGFloat lh_left;
/// y坐标
@property (assign, nonatomic) CGFloat lh_top;
/// 宽度
@property (assign, nonatomic) CGFloat lh_width;
/// 高度
@property (assign, nonatomic) CGFloat lh_height;

/// 右面
@property (assign, nonatomic) CGFloat lh_right;
/// 下面
@property (assign, nonatomic) CGFloat lh_bottom;

/// y中心
@property (assign, nonatomic) CGFloat lh_centerY;

/// x中心
@property (nonatomic, assign) CGFloat lh_centerX;

/// 左下角
@property (assign, nonatomic, readonly) CGPoint lh_bottomLeft;
/// 右下角
@property (assign, nonatomic, readonly) CGPoint lh_bottomRight;
/// 右上角
@property (assign, nonatomic, readonly) CGPoint lh_topRight;


/**
 *  根据传入的子视图与当前视图计算出水平中心开始点
 *
 *  @param subView 子视图
 *
 *  @return 水平中心开始点
 */
- (CGFloat)lh_centerHorizontalWithSubView:(UIView *)subView;

/**
 *  根据传入的子视图与当前视图计算出垂直中心开始点
 *
 *  @param subView 子视图
 *
 *  @return 垂直中心开始点
 */
- (CGFloat)lh_centerVerticalWithSubView:(UIView *)subView;

/**
 *  根据传入的子视图与当前视图计算出中心点
 *
 *  @param subView 子视图
 *
 *  @return 中心点
 */
- (CGPoint)lh_centerWithSubView:(UIView *)subView;


/**
 *  居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToCenter:(UIView *)subView;

/**
 *  水平居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToHorizontalCenter:(UIView *)subView;

/**
 *  垂直居中增加子视图
 *
 *  @param subView 子视图
 */
- (void)lh_addSubViewToVerticalCenter:(UIView *)subView;

@end



#pragma mark - 视图层次扩展 -

@interface UIView (ZOrder)

/**
 *  获取当前视图在父视图中的索引
 *
 *  @return 索引值
 */
- (NSUInteger)lh_getSubviewIndex;

/**
 *  将视图置于父视图最上面
 */
- (void)lh_bringToFront;

/**
 *  将视图置于父视图最下面
 */
- (void)lh_sendToBack;

/**
 *  视图层次上移一层
 */
- (void)lh_bringOneLevelUp;

/**
 *  视图层次下移一层
 */
- (void)lh_sendOneLevelDown;

/**
 *  是否在最上面
 *
 *  @return 最上层视图 → YES
 */
- (BOOL)lh_isInFront;

/**
 *  是否在最下面
 *
 *  @return 最下层视图 → YES
 */
- (BOOL)lh_isAtBack;

/**
 *  视图交换层次
 *
 *  @param swapView 交换的视图
 */
- (void)lh_swapDepthsWithView:(UIView*)swapView;

/**
 * Removes all subviews.
 */
- (void)lh_removeAllSubviews;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)lh_descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)lh_ancestorOrSelfWithClass:(Class)cls;

#pragma mark - 视图响应 －

/**
 * Exclusive all the buttons in view 通过设置[self setExclusiveTouch:YES];可以达到同一界面上多个控件接受事件时的排他性，从而避免一些问题。
 */
-(void)lh_exclusiveTouchForAllButtons;

#pragma mark - 视图添加手势操作 -

/**
 Attaches the given block for a single tap action to the receiver.
 @param block The block to execute.
 */
- (void)lh_setTapActionWithBlock:(void (^)(void))block;

/**
 Attaches the given block for a long press action to the receiver.
 @param block The block to execute.
 */
- (void)lh_setLongPressActionWithBlock:(void (^)(void))block;

/**
 Attaches the given block for a swipe action to the receiver.
 @param block The block to execute.
 */
-(void)lh_setSwipeActionWithBlock:(void (^)(void))block;

@end

@interface UIView(Create)


/**
 * create From Nib method , You can pass CGRectNull if you do not want to change the size of View in Nib
 *
 */
+ (id)lh_createByFrame:(CGRect)frame;

@end

@interface UIView (Effects)
///**
// *  准备高斯模糊
// */
//- (void)prepareToBlur;
//
///**
// *  添加高斯模糊
// *
// *  @param block 点击模糊的范围触发的事件
// */
//- (void)blur;
//
///**
// *  撤销高斯模糊
// */
//- (void)unBlur;
//
//
/////**
//// *  点击模糊的范围触发的事件
//// */
////- (void)tapBlurView;
//
//
///**
// *  纯色设置高斯模糊
// *
// *  @param blurTintColor 颜色
// */
//- (void) setBlurTintColor:(UIColor *)blurTintColor;


/**
 *  添加高斯模糊
 *
 */
- (void)blur;

/**
 *  撤销高斯模糊
 */
- (void)unBlur;

@end

@interface UIView (LayoutConstraintHelper)

- (NSLayoutConstraint*)widthConstraint;

- (NSLayoutConstraint*)heightConstraint;

- (NSLayoutConstraint*)top2SupviewConstraintWithTopLayoutGuideOwner:(UIViewController*)controller;

- (NSLayoutConstraint*)bottom2SupviewConstraintWithBottomLayoutGuideOwner:(UIViewController*)controller;

- (NSLayoutConstraint*)left2SupviewConstraint;

- (NSLayoutConstraint*)right2SupviewConstraint;

@end

@interface UIView (SelfManager)

@property (nonatomic, copy) idBlock tapActionHandler;

@end

