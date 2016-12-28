//
//  UIWebView+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIWebView+LH.h"

@implementation UIWebView (LH)

/**
 *  调用 javascript，即时执行
 *
 *  @param jsString js代码
 */
- (void)lh_evaluatingJavaScript:(NSString *)jsString {
    [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
                                                  @"var script = document.createElement('script');"
                                                  "script.type = 'text/javascript';"
                                                  "script.text = \"function myFunction() { "
                                                  "%@"
                                                  "}\";"
                                                  "document.getElementsByTagName('head')[0].appendChild(script);", jsString]];
    
    [self stringByEvaluatingJavaScriptFromString:@"myFunction();"];
}

@end
