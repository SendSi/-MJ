/** *   一、接口基础模块 */

#ifdef DEBUG
// 服务器地址
#define API_HOST @"http://nebor.cn/milkTreasure-web"
//图片地址
#define API_IMAGE_HOST @"http://nebor.cn/milkTreasure/"
#else
// 服务器地址
#define API_HOST @"http://nebor.cn/milkTreasure-web"
//图片地址
#define API_IMAGE_HOST @"http://nebor.cn/milkTreasure/"

#endif

#define APP_key @""
//MD5加密（APP_key+””）
#define APP_scode @""

#define API_APP_BASE_URL @""
//#define API_APP_BASE_URL @"milkTreasure-web"

#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]
#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

// 接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

// 图片
#define kAPIImageFromUrl2(url) [[NSString stringWithFormat:@"%@%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
#pragma mark - 注意图片 特殊字符
/** 图片字符串 要经过 替换 ,后台返回的字符有特殊字符,要替换 */
#define kAPIImageFromUrl(url) [kAPIImageFromUrl2(url) stringByReplacingOccurrencesOfString:@"%5C" withString:@"/"]


//开始接口名
#define API_GET_PHRASE_LIST API_SUB_URL(@"appOpen/getPhraseList.do")




