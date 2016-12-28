

//公用Block
typedef void(^voidBlock)();
typedef void(^idBlock)(id obj);
typedef void(^stringBlock)(NSString *result);
typedef void(^stringBlock2)(NSString *result,NSString *description);
typedef void(^boolBlock)(BOOL boolen);
typedef void(^errorBlock)(NSError *error);
typedef void(^numberBlock)(NSNumber *result);
typedef void(^arrayWithErrorBlock)(NSArray *results,NSError *error);
typedef void(^arrayAndDescription)(NSArray *results,NSString *description);
typedef void(^arrayBlock)(NSArray *results);
typedef void(^successBlock)(id resultObj);
//键盘高度
#define configKeyBoardNormalHeight 216.0f

//ios
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)
#define iOSVersion ([[UIDevice currentDevice].systemVersion doubleValue])

#define configPhoneNumberLength 11//11位的手机号
#define configKeyBoardNumber @"12345647890"//手机只有数字

#pragma mark -  log信息
#ifdef DEBUG
#define NSLogs(...)  NSLog(__VA_ARGS__)
#else
#define NSLogs(...)
#endif
#define NSLogClass NSLogs(@"%s",__func__)//输出本类
#define NSLogss(aTxt) NSLogs(@"log信息 %@   ,   %s",aTxt,__func__)//输出本类


//弧度 转 角度 //某处调用 //anim.values=@[@(angleRadian(-45)),@(angleRadian(45)),@(angleRadian(-45))];
#define configAngleRadian(angle) ( (angle) /180.0 * M_PI)

#pragma mark - 屏幕区
#define configScreenWidth [UIScreen mainScreen].bounds.size.width
#define configScreenHeight [UIScreen mainScreen].bounds.size.height
#define  configScreenWidth_2_1 pchScreenWidth*0.5//2分之一的长度
#define configIphone_5 568//5和4 width一样,所以要用heigth的 值
#define  configIphone_6 667
#define configIphone_6p 736

#pragma mark - nav 不同 颜色 top区
#define configNavMainBlue [[UINavigationBar appearance] setBarTintColor:pchColorMainNav]
#define configNavAroundRed [[UINavigationBar appearance] setBarTintColor:pchColorAroundNav]

#pragma mark - 颜色区
// 2.获得RGB颜色
#define configColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//rgba
#define configColor_alpha(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define offsetGroudX 10
#define FONT(x) [UIFont systemFontOfSize:x]
//登录失效通知
#define kNotifation_TokenInvalidate @"kNotifation_TokenInvalidate"









