//
//  NSObject+NC.h
//  Bsh
//
//  Created by lh on 16/1/2.
//  Copyright © 2016年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NetworkClient Categories
 */
@interface NSObject (NC)

@end


@interface UIImageView (NC)

- (void)nc_setImageWithUrlString:(NSString *)urlString;

@end


@interface UIButton (NC)

- (void)nc_setImageWithUrlString:(NSString *)urlString;

@end