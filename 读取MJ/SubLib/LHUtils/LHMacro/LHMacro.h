//
//  LHMacro.h
//  Test
//
//  Created by lh on 15/11/29.
//  Copyright © 2015年 lh. All rights reserved.
//


// 3.5 320 * 480   640 * 980
// 4.0 320 * 568   640 * 1136
// 4.7 375 * 667   750 * 1334
// 5.5 414 * 736   828 * 1472


#ifndef LHMacro_h
#define LHMacro_h

#pragma mark - NSLog

// release 版本屏蔽 NSLog
#ifndef DEBUG

// 屏蔽 SDWebImagePrefetcher 的警告
#define SD_VERBOSE

#define NSLog(...) {}

#endif


#pragma mark - App Singleton

#define kAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kFileManager        [NSFileManager defaultManager]
#define kApplication        [UIApplication sharedApplication]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kMainScreen         [UIScreen mainScreen]
// 屏幕大小
#define kMainScreenBounds [UIScreen mainScreen].bounds
// 当前屏幕宽
#define LH_ScreenWidth   ([UIScreen mainScreen].bounds.size.width)
// 当前屏幕高
#define LH_ScreenHeight  ([UIScreen mainScreen].bounds.size.height)


#pragma mark - NSString

// int → string
#define kIntToString(_i) [NSString stringWithFormat:@"%d", _i]
// float,double → string
#define kFloatToString(_f) [NSString stringWithFormat:@"%f", _f]
// float,double → string ,,, format
#define kGToString(_g) [NSString stringWithFormat:@"%g", _g]
// object → string
#define kToString(o) [NSString stringWithFormat:@"%@", (o)]


#pragma mark - Weak & Strong

// 使用__block来修饰在Block中实用的对象,仍然会被retain
#define BLOCK_SELF()  __block __typeof(self) blockSelf = self;
// 自身弱引用
#define WEAK_SELF()  __weak __typeof(self) weakSelf = self;
// 自身强引用
#define STRONG_SELF()  __strong __typeof(weakSelf) strongSelf = weakSelf;
// 自身强引用，strongSelf不存在直接返回
#define STRONG_SELF_RETURN() \
__strong __typeof(weakSelf) strongSelf = weakSelf; \
ReturnIfNot(strongSelf)


#pragma mark - IF

#define ContinueIf(expr)            if ((expr))  { continue;     }
#define BreakIf(expr)               if ((expr))  { break;        }
#define ReturnIf(expr)              if ((expr))  { return;       }
#define ReturnValIf(expr, val)      if ((expr))  { return (val); }
#define ContinueIfNot(expr)         if (!(expr)) { continue;     }
#define BreakIfNot(expr)            if (!(expr)) { break;        }
#define ReturnIfNot(expr)           if (!(expr)) { return;       }
#define ReturnValIfNot(expr, val)   if (!(expr)) { return (val); }


#pragma mark - Device

// 当前手机语言
#define kDeviceLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
// 当前系统版本号
#define kDeviceVersion  ([[[UIDevice currentDevice] systemVersion] floatValue])
// 应用当前语言是否为简体中文
#define kIsChinese (([DeviceLanguage isEqualToString:@"zh-Hans"]) ? YES : NO)

// iPhone4s 分辨率320x480，像素640x960，@2x
#define IS480         (([[UIScreen mainScreen] bounds].size.height == 480) ? YES : NO)
// iPhone5、5c、5s 分辨率320x568，像素640x1136，@2x
#define IS568         (([[UIScreen mainScreen] bounds].size.height == 568) ? YES : NO)
// iPhone6 分辨率375x667，像素750x1334，@2x
#define IS667         (([[UIScreen mainScreen] bounds].size.height == 667) ? YES : NO)
// iPhone6 Plus 分辨率414x736，像素1242x2208，@3x
#define IS736         (([[UIScreen mainScreen] bounds].size.height == 736) ? YES : NO)

// iOS6以上
#define IOS_VERSION_6_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)? (YES):(NO))
// iOS7以上
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
// iOS8以上
#define IOS_VERSION_8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

// 获取当前应用版本
#define kAppVersion    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
// Document目录
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#pragma mark - UIColor

#define kBlackColor     [UIColor blackColor]      // 0.0 white
#define kDarkGrayColor  [UIColor darkGrayColor]   // 0.333 white
#define kLightGrayColor [UIColor lightGrayColor]  // 0.667 white
#define kWhiteColor     [UIColor whiteColor]      // 1.0 white
#define kGrayColor      [UIColor grayColor]       // 0.5 white
#define kRedColor       [UIColor redColor]        // 1.0, 0.0, 0.0 RGB
#define kGreenColor     [UIColor greenColor]      // 0.0, 1.0, 0.0 RGB
#define kBlueColor      [UIColor blueColor]       // 0.0, 0.0, 1.0 RGB
#define kCyanColor      [UIColor cyanColor]       // 0.0, 1.0, 1.0 RGB
#define kYellwColor     [UIColor yellowColor]     // 1.0, 1.0, 0.0 RGB
#define kMagentaColor   [UIColor magentaColor]    // 1.0, 0.0, 1.0 RGB
#define kOrangeColor    [UIColor orangeColor]     // 1.0, 0.5, 0.0 RGB
#define kPurpleColor    [UIColor purpleColor]     // 0.5, 0.0, 0.5 RGB
#define kBrownColor     [UIColor brownColor]      // 0.6, 0.4, 0.2 RGB
#define kClearColor     [UIColor clearColor]      // 0.0 white, 0.0 alpha

#define kRGBColorHex(_f) [UIColor colorWithRed:((float)((_f & 0xFF0000) >> 16))/255.0 green:((float)((_f & 0xFF00)>> 8))/255.0 blue:((float) (_f & 0xFF))/255.0 alpha:1.0f]
#define kRGBAColor(_r, _g, _b, _a) [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:_a]
#define kRGBColor(_r, _g, _b) RGBAColor(_r, _g, _b, 1.0f)
// 同样颜色
#define kRGBColorSame(_c) [UIColor colorWithRed:(_c)/255.0 green:(_c)/255.0 blue:(_c)/255.0 alpha:1.0f]

#define kColor50  kRGBColorSame(50)
#define kColor117 kRGBColorSame(117)
#define kColor201 kRGBColorSame(201)
#define kColor214 kRGBColorSame(214)
#define kColor220 kRGBColorSame(220)
#define kColor235 kRGBColorSame(235)
#define kColor238 kRGBColorSame(238)
#define kColor242 kRGBColorSame(242)
#define kColor249 kRGBColorSame(249)
#define kColor250 kRGBColorSame(250)


#pragma mark - UIImage

//----------------------图片相关----------------------------

// 读取本地图片
#define kLoadImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
// 读取本地png图片
#define kLoadPngImage(_file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_file ofType:nil]]
// 定义UIImage对象
#define kImageNamed(_name) [UIImage imageNamed:_name]
// 可拉伸的图片
#define kResizableImage(name,top,left,bottom,right) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right)]
#define kResizableImageWithMode(name,top,left,bottom,right,mode) [[UIImage imageNamed:name] resizableImageWithCapInsets:UIEdgeInsetsMake(top,left,bottom,right) resizingMode:mode]

//----------------------图片相关----------------------------


#pragma mark -  UIFont

// 字体
#define kSystemFont(_size)   [UIFont systemFontOfSize:_size]
// 加粗字体
#define kSystemBoldFont(_size) [UIFont boldSystemFontOfSize:_size]

#define kFont10 kSystemFont(10)
#define kFont12 kSystemFont(12)
#define kFont13 kSystemFont(13)
#define kFont14 kSystemFont(14)
#define kFont15 kSystemFont(15)
#define kFont16 kSystemFont(16)
#define kFont17 kSystemFont(17)
#define kFont18 kSystemFont(18)
#define kFont19 kSystemFont(19)
#define kFont20 kSystemFont(20)
#define kFont22 kSystemFont(22)
#define kFont24 kSystemFont(24)


#pragma mark - UIWebview & JS

// 获取网页html
#define kDocumentHtml @"document.documentElement.innerHTML"
// 获取网页内容文字
#define kDocumentText @"document.documentElement.innerText"
// 获取网页内容文字
//#define kDocumentText @"document.body.innerText"


#pragma mark - NSTimer

#define TICK   NSDate *aStartTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[aStartTime timeIntervalSinceNow])


#pragma mark - Warning

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#pragma mark - Singleton

// 第二种方法，重写 allocWithZone，同时支持 arc 和 非arc
// ## : 连接字符串和参数
#define singleton_h(name) + (instancetype)shared##name;

#if __has_feature(objc_arc)  //如果是ARC
#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}

#else //非ARC
#define singleton_m(name) \
static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (oneway void)lh_release \
{ \
\
} \
\
- (id)lh_autorelease \
{ \
return _instance; \
} \
\
- (id)lh_retain \
{ \
return _instance; \
} \
\
- (NSUInteger)lh_retainCount \
{ \
return 1; \
} \
\
+ (id)copyWithZone:(struct _NSZone *)zone \
{ \
return _instance; \
}
#endif

#endif /* LHMacro_h */
