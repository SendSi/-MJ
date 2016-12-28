//
//  UIButton+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LH)

@property (nonatomic, copy) idBlock actionHandler;
/**
 *  初始化，无图无字
 *
 *  @param frame           大小
 *  @param target          对象
 *  @param action          事件
 *  @param backgroundColor 背景颜色
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action backgroundColor:(UIColor *)backgroundColor;

/**
 *  初始化，背景图片
 *
 *  @param frame           大小
 *  @param target          对象
 *  @param action          事件
 *  @param backgroundImage 背景图片
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action backgroundImage:(UIImage *)backgroundImage;

/**
 *  初始化，文字
 *
 *  @param frame           大小
 *  @param target          对象
 *  @param action          事件
 *  @param title           标题
 *  @param titleColor      标题颜色
 *  @param font            字体
 *  @param backgroundColor 背景颜色
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor;


/**
 *  初始化，文字
 *
 *    大小
 *       对象
 *        事件
 *    标题
 *       标题颜色
 *      字体
 *  背景颜色
 *  圆角大小，
 *边框宽度，
 *边框颜色
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame fontSize:(NSInteger)fontSize target:(id)target action:(SEL)action title:(NSString *)title titleColor:(UIColor *)titleColor  backgroundColor:(UIColor *)backgroundColor Radius:(float)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  初始化，背景图 + 文字
 *
 *  @param frame           大小
 *  @param target          对象
 *  @param action          事件
 *  @param backgroundImage 背景图片
 *  @param title           标题
 *  @param titleColor      标题颜色
 *  @param font            字体
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action backgroundImage:(UIImage *)backgroundImage title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  初始化，图片 + 文字
 *
 *  @param frame      大小
 *  @param target     对象
 *  @param action     事件
 *  @param image      图片
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param font       字体
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

/**
 *  初始化，图片 + 文字
 *
 *  @param frame      大小
 *  @param target     对象
 *  @param action     事件
 *  @param nor_image      图片
 *  @param title      标题
 *  @param titleColor 标题颜色
 *  @param fontSize       字体
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame fontSize:(NSInteger )fontSize target:(id)target action:(SEL)action nor_image:(NSString *)nor_image  title:(NSString *)title titleColor:(UIColor *)titleColor ;

/**
 *  初始化，图片
 *
 *  @param frame  大小
 *  @param target 对象
 *  @param action 事件
 *  @param image  图片
 *
 *  @return 实例
 */
+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action image:(UIImage *)image;

+ (UIButton *)lh_buttonWithFrame:(CGRect)frame target:(id)target actionHandler:(idBlock)actionHandler image:(UIImage *)image;

/** 按钮正常颜色 */
- (void )lh_buttonNormalTitle:(NSString *)title;
/** 字体颜色 */
- (void )lh_buttonNormalTitleColor:(UIColor  *)color;
-(void)lh_buttonAddTarget:(id)target action:(SEL)action;
/** 图片 */
- (void )lh_buttonNormalCurrentImage:(NSString *)imageName;
/** 图片与字体颜色  */
- (void )lh_buttonNormalCurrentImage:(NSString *)imageName titleColor:(UIColor *)titleColor;
/**
 *  设置四个圆角大小，边框宽度，边框颜色，字体颜色,-1 和 nil表示不设置
 */
- (void)lh_setCornerRadius:(float)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor titleColor:(UIColor *)titleColor ;
/**
 *  设置四个圆角大小，边框宽度，边框颜色，字体颜色,点击事件,-1 和 nil表示不设置
 */
- (void)lh_setCornerRadius:(float)cornerRadius borderWidth:(float)borderWidth borderColor:(UIColor *)borderColor titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;

/** 按钮,点击,与,长按  */
-(void)lh_buttonNormalTouchUpInside_target:(id)target normalAction:(SEL)normalAction longPressAction:(SEL)longPressAction;
@end


#pragma mark - 不同状态的背景颜色

@interface UIButton (BackgroundState)

/**
 *  设置不同状态的背景颜色，实际上是设置背景图片
 *
 *  @param backgroundColor 背景颜色
 *  @param state           不同状态
 */
- (void)lh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/**
 *  @author hejing
 *
 *  点击改变选中状态
 */
- (void)changeSelectState;

#pragma mark - 倒数计时按钮

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

@end


