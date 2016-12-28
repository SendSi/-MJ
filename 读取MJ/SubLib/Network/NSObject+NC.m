//
//  NSObject+NC.m
//  Bsh
//
//  Created by lh on 16/1/2.
//  Copyright © 2016年 lh. All rights reserved.
//

#import "NSObject+NC.h"

@implementation NSObject (NC)

@end


@implementation UIImageView (NC)

- (void)nc_setImageWithUrlString:(NSString *)urlString {
#ifndef kNCLoaclResponse
    
    [self sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(urlString)]];
    
#else
    
    NSString *tmpUrlString = urlString;
    NSRange range = [tmpUrlString rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        tmpUrlString = [tmpUrlString substringFromIndex:NSMaxRange(range)];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:tmpUrlString ofType:@"png" inDirectory:@"LocalResponse/Image"];
    self.image = [UIImage imageWithContentsOfFile:imagePath];
    
#endif
}

@end


@implementation UIButton (NC)

- (void)nc_setImageWithUrlString:(NSString *)urlString {
#ifndef kNCLoaclResponse    
    [self sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(urlString)] forState:UIControlStateNormal];
    
#else
    
    NSString *tmpUrlString = urlString;
    NSRange range = [tmpUrlString rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        tmpUrlString = [tmpUrlString substringFromIndex:NSMaxRange(range)];
    }
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:tmpUrlString ofType:@"png" inDirectory:@"LocalResponse/Image"];
    [self setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    
#endif
}

@end
