//
//  UILabel+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UILabel+LH.h"

@implementation UILabel (LH)

/**
 *  初始化
 *
 *  @param frame           大小
 *  @param text            文本
 *  @param textColor       文本颜色
 *  @param font            字体
 *  @param textAlignment   文本对齐方式
 *  @param backgroundColor 背景颜色
 *
 *  @return 实例
 */
+ (UILabel *)lh_labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backgroundColor:(UIColor *)backgroundColor
{
    UILabel *label        = [[UILabel alloc] initWithFrame:frame];
    label.text            = text;
    label.textColor       = textColor;
    label.font            = font;
    label.textAlignment   = textAlignment;
    label.backgroundColor = backgroundColor;
    
    return label;
}

/**
 *  创建自适应高度的label，frame的高度将会被忽略
 *
 *  @param frame         大小
 *  @param text          文本
 *  @param textColor     文本颜色
 *  @param font          字体
 *  @param textAlignment 文本对齐方式
 *
 *  @return 实例
 */
+ (UILabel *)lh_labelAdaptionWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    // 测量高度
    CGSize measureSize = [text lh_sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, MAXFLOAT)];
    frame.size.height = measureSize.height;
    
    UILabel *label = [self lh_labelWithFrame:frame text:text textColor:textColor font:font textAlignment:textAlignment backgroundColor:[UIColor clearColor]];
    label.numberOfLines = 0;
    
    return label;
}

@end


#pragma mark - 对齐样式

@implementation UILabel (VerticalAlign)

- (int)lh_newLinesToPad {
    NSDictionary *attrs = @{NSFontAttributeName: self.font};
    CGSize fontSize =[self.text sizeWithAttributes:attrs];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    
    return newLinesToPad;
}

/**
 *  顶部对齐
 */
-(void)lh_alignTop {
    int newLinesToPad = [self lh_newLinesToPad];
    for(int i=0; i < newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

/**
 *  底部对齐
 */
-(void)lh_alignBottom {
    int newLinesToPad = [self lh_newLinesToPad];
    for(int i=0; i < newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}

@end

@implementation UILabel (FormattedText)

- (void)lh_setTextColor:(UIColor *)textColor range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSForegroundColorAttributeName
                 value: textColor
                 range: range];
    
    [self setAttributedText: text];
}

- (void)lh_setTextColor:(UIColor *)textColor fromStringLocation:(NSUInteger)location {
    
    NSRange range = NSMakeRange(location, self.text.length-location);
    [self lh_setTextColor:textColor range:range];
}

- (void)lh_setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSFontAttributeName
                 value: font
                 range: range];
    
    [self setAttributedText: text];
}

- (void)lh_setLineSpace:(CGFloat)space
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText: text];
}

- (void)lh_setTextColor:(UIColor *)textColor subString:(NSString *)subString {
    
    NSRange range = [self.text rangeOfString:subString];
    [self lh_setTextColor:textColor range:range];
}

- (void)lh_setTextFont:(UIFont *)textFont subString:(NSString *)subString {    
    NSRange range = [self.text rangeOfString:subString];
    [self lh_setFont:FONT(16) range:range];
}

- (CGFloat)lh_contentHeight{
//    CGFloat contentHeight;
//    contentHeight = [self.text sizeForFont:self.font size:CGSizeMake(self.frame.size.width, MAXFLOAT) mode:self.lineBreakMode].height;
//    return MAX(21, contentHeight);
    return 0;
}



- (CGFloat)lh_contentWeigh{
//    CGFloat contentWeigh;
//    contentWeigh = [self.text sizeForFont:self.font size:CGSizeMake(self.frame.size.width, MAXFLOAT) mode:self.lineBreakMode].width;
//    return MIN(self.lh_width, contentWeigh);
    return 0;
}

- (void)lh_headBaseStringAddString:(NSString *)addString {
    
    self.text = [self.lh_headBaseString stringByAppendingString:addString];
}

- (void)setLh_headBaseString:(NSString *)lh_headBaseString {
    
    objc_setAssociatedObject(self, @selector(lh_headBaseString), lh_headBaseString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lh_headBaseString {
    
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation UILabel (LH_ShopCart)

- (void)lh_shopCartNumIncrease {
    
    NSInteger shopCartNum = self.text.integerValue;
    shopCartNum++;
    
    self.text = [NSString stringWithFormat:@"%ld",shopCartNum];
}

- (void)lh_shopCartNumReduce {
    
    NSInteger shopCartNum = self.text.integerValue;
    shopCartNum--;
    
    if (shopCartNum >= 0) {
        
        self.text = [NSString stringWithFormat:@"%ld",shopCartNum];
    }
}

@end
