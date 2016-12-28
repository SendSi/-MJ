//
//  NSString+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LH)

/**
 *  判断字符串是否为空。字符串为nil时，不会执行getter方法，直接返回 NO。
 *
 *  @return 空值 → YES，非空值 → NO
 */
@property (nonatomic, assign, readonly) BOOL lh_isEmpty;

/**
 *  判断字符串是否不为空。如果字符串可能为nil时，调用这个会好点。
 *
 *  @return 非空值 → YES，空值 → NO
 */
@property (nonatomic, assign, readonly) BOOL lh_isNotEmpty;


/**
 *  \<br /> 和 \<br>  替换为  \\n
 *
 *  @return 字符串
 */
- (NSString *)lh_replaceNewLine;

@end


#pragma mark - 日期

@interface NSString (Date)

/**
 *  获取日期，默认格式为 yyyy-MM-dd
 *
 *  @return 日期
 */
- (NSDate *)lh_yyyyMMdd_Date;

/**
 *  获取日期，默认格式为 yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期
 */
- (NSDate *)lh_yyyyMMdd_HHmmss_Date;

/**
 *  获取日期，默认格式为 yyyyMMddHHmmss
 *
 *  @return 日期
 */
- (NSDate *)lh_yyyyMMddHHmmss_Date;

/**
 *  获取日期，自定义格式
 *
 *  @param format 指定格式：比如 yyyy-MM-dd HH:mm:ss
 *
 *  @return 日期
 */
- (NSDate *)lh_dateWithFormat:(NSString *)format;


@end



#pragma mark - 去掉字符

@interface NSString (TrimmingAdditions)

/**
 *  trim掉左面字符串
 *
 *  @param characterSet 字符集
 *
 *  @return 字符串
 */
- (NSString *)lh_stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;

/**
 *  trim掉右面字符串
 *
 *  @param characterSet 字符集
 *
 *  @return 字符串
 */
- (NSString *)lh_stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

@end


#pragma mark - 加密 -

@interface NSString (Encrypt)

/**
 *  16位MD5加密方式
 *
 *  @return 16位加密字符串
 */
- (NSString *)lh_md5_16Bit_String;

/**
 *  32位MD5加密方式
 *
 *  @return 32位加密字符串
 */
- (NSString *)lh_md5_32Bit_String;

/**
 *  sha1加密方式
 *
 *  @return sha1加密字符串
 */
- (NSString *)lh_sha1String;

/**
 *  sha256加密方式
 *
 *  @return sha256加密字符串
 */
- (NSString *)lh_sha256String;

/**
 *  sha384加密方式
 *
 *  @return sha384加密字符串
 */
- (NSString *)lh_sha384String;

/**
 *  sha512加密方式
 *
 *  @return sha512加密字符串
 */
- (NSString*)lh_sha512String;

@end


#pragma mark - 字体 -

@interface NSString (Font)

/*
 字母 ”a“  下面为调用 systemFontOfSize 的结果，得到高度会小于下面的高度
 汉字 ”我“ 宽度为字体大小，高度跟下面一样
 system font 10, size is {6, 12}
 system font 11, size is {7, 14}
 system font 12, size is {7, 15}
 system font 13, size is {8, 16}
 system font 14, size is {8, 17}
 system font 15, size is {9, 18}
 system font 16, size is {9, 20}
 system font 17, size is {10, 21}
 system font 18, size is {10, 22}
 system font 19, size is {11, 23}
 system font 20, size is {11, 24}
 system font 21, size is {12, 26}
 */

/**
 *  获取字符串大小
 *
 *  @param font 字体
 *  @param size 规定范围大小
 *
 *  @return 字符串大小
 */
- (CGSize)lh_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end


#pragma mark - 垂直绘画 -

@interface NSString (VerticalAlign)

typedef enum {
    NSVerticalTextAlignmentTop,
    NSVerticalTextAlignmentMiddle,
    NSVerticalTextAlignmentBottom
} NSVerticalTextAlignment;


/**
 *  垂直画文本
 *
 *  @param rect   矩形范围
 *  @param font   字体
 *  @param vAlign 垂直文本对齐方式
 *
 *  @return 文本大小
 */
- (CGSize)lh_drawVerticallyInRect:(CGRect)rect withFont:(UIFont *)font verticalAlignment:(NSVerticalTextAlignment)vAlign;

/**
 *  垂直画文本
 *
 *  @param rect          矩形范围
 *  @param font          字体
 *  @param lineBreakMode 换行模式
 *  @param vAlign        垂直文本对齐方式
 *
 *  @return 文本大小
 */
- (CGSize)lh_drawVerticallyInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode verticalAlignment:(NSVerticalTextAlignment)vAlign;

/**
 *  垂直画文本
 *
 *  @param rect          矩形范围
 *  @param font          字体
 *  @param lineBreakMode 换行模式
 *  @param alignment     文本水平对齐方式
 *  @param vAlign        垂直文本对齐方式
 *
 *  @return 文本大小
 */
- (CGSize)lh_drawVerticallyInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment verticalAlignment:(NSVerticalTextAlignment)vAlign;

@end


#pragma mark - 验证 -

@interface NSString (Validate)

/**
 *  判断是否为整形
 *
 *  @return 整形 → YES
 */
- (BOOL)lh_isPureInt;

/**
 *  判断是否为浮点型
 *
 *  @return 浮点型 → YES
 */
- (BOOL)lh_isPureFloat;

/**
 *  身份证验证
 *
 *  @return 身份证合法 → YES，不合法 → NO。
 */
- (BOOL)lh_isValidateCardID;

/**
 *  根据身份证号，判断年龄是否满18岁
 *
 *  @return 年龄 ≥ 18 → YES，年龄 ＜ 18 → NO。
 */
- (BOOL)lh_isValidateTeenager;

/**
 *  手机号码验证
 *
 *  @return 是 → YES，否 → NO。
 */
- (BOOL)lh_isValidateMobile;

/**
 *  固定电话号码验证
 *
 *  @return 是 → YES，否 → NO。
 */
- (BOOL)lh_isValidateTel;

/**
 *  电话号码与手机号码同时验证
 *
 *  @return 是 → YES，否 → NO。
 */
- (BOOL)lh_isValidateTelAndMobile;

/**
 *  车牌号验证
 *
 *  @return 是 → YES，否 → NO。
 */
- (BOOL)lh_isValidateCarNumber;

/**
 *  邮箱验证
 *
 *  @return 是 → YES，否 → NO。
 */
- (BOOL)lh_isValidateEmail;

#pragma mark - url 拼接

/**
 *  获取url拼接字符串
 *
 *  @param subUrl     请求接口地址
 *  @param patameters 参数字典
 *
 *  @return 完整url拼接字符串
 */
+ (NSString *)lh_subUrlString:(NSString *)subUrl appendingParameters:(NSDictionary *)patameters;

@end
