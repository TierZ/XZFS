//
//  XZConfig.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 iPad Air {{0, 0}, {768, 1024}}
 iphone4s {{0, 0}, {320, 480}}     960*640
 iphone5 5s {{0, 0}, {320, 568}}      1136*640
 iphone6 6s {{0, 0}, {375, 667}}     1334*750
 iphone6Plus 6sPlus {{0, 0}, {414, 736}}  1920*1080
 Apple Watch 1.65英寸 320*640
 */


#ifndef XZConfig_h
#define XZConfig_h

#define JMESSAGE_APPKEY @"7c8666f2ef5f47318e23f87f"
#define WEIBO_APPKEY @"1823207424"
#define WEIBO_Secret @"2191e9f59de27f12fe2ab59288e07aa5"
#define kSinaRedirectURI    @"https://api.weibo.com/oauth2/default.html"
#define AppScheme @"XianZhiFengShui"
#define kWeixinAppId    @"wxe208d293e5353bf4"
#define kWeixinAppSecret @"6dd9fc61162f7ae9573f1b8aa412a340"

#define DEBUG_SWITH 1// 控制 log日志的输出 0为不打印log日志 1为打印log日志
#define TEST_LINE 1// 控制 正式线和测试线 1为测试线 0为正式线

#define XZBASEURL @"http://api.xianzhifengshui.com"



#define MYTEST_LINE TEST_LINE

#if MYTEST_LINE
#define IsProduction NO //判断是否为生产环节
#else
#define IsProduction YES
#endif

#pragma mark chart
#define kBADGE @"badge"

//userDefault

#define GETUserdefault(key)  [[NSUserDefaults standardUserDefaults]objectForKey:key]

#define SETUserdefault(obj,key)  {[[NSUserDefaults standardUserDefaults]setObject:obj forKey:key];\
[[NSUserDefaults standardUserDefaults] synchronize];}

#define XZUserDefault [NSUserDefaults standardUserDefaults]
// 判断字典是否为空
#define KISDictionaryHaveKey(dict,key) [[dict allKeys] containsObject:key] && ([dict objectForKey:key] != (NSString*)[NSNull null]) ? [dict objectForKey:key] : @""
#define SafeGetStringValue(object) (object!=nil && ![object isKindOfClass:[NSNull class]])?([object isKindOfClass:[NSString class]]?object:[object stringValue]):@""
#endif



//文本为数字
#define XZFS_TextNUMBERS @"0123456789\n"
//文本为字母或数字
#define XZFS_TextAlphaOrNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"


/** 系统控件的默认高度 */
#define SCREENBOUNDS [[UIScreen mainScreen] bounds]
#define SCREENWIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define XZFS_D_TIME_BAR_H   (20.f)
#define XZFS_D_TOP_BAR_H      (44.f)
#define XZFS_STATUS_BAR_H (64.0)
#define XZFS_Bottom_H (49.0)
#define XZFS_MainView_H (SCREENHEIGHT-XZFS_STATUS_BAR_H)

/** 字体大小 */
#define LABElFONT @"FZLanTingHeiS-L-GB"

#define XZFS_FONT(NAME,FONTSIZE) [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define XZFS_S_FONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define XZFS_S_BOLD_FONT(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]

#define RandomColor(a) [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:a]

/** 颜色(RGB) */
#define XZFS_RGB(r,g,b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1];
#define XZFS_RGBA(r,g,b,a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/** 颜色(0xFFFFFF) */
#define XZFS_HEX_RGB(rgbValue) [StringToColor hexStringToColor:rgbValue]
//#define SGLC_HEX_RGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define XZFS_HEX_RGBA(rgbValue,a) [StringToColor hexStringToColor:rgbValue alpha:a] // add by lf

/** 颜色*/
#define XZFS_NAVICOLOR   XZFS_HEX_RGB(@"#FAF9FA")//导航条颜色
#define XZFS_NAVITITLECOLOR XZFS_HEX_RGB(@"#000000")//导航条标题颜色
#define XZFS_TEXTORANGECOLOR XZFS_HEX_RGB(@"#EB6000")//橙色颜色
#define XZFS_TEXTGRAYCOLOR XZFS_HEX_RGB(@"#9F9FA0")//灰色颜色
#define XZFS_TEXTLIGHTGRAYCOLOR XZFS_HEX_RGB(@"#C9CACA")//浅灰色颜色
#define XZFS_TEXTBLACKCOLOR XZFS_HEX_RGB(@"#000000")//黑色颜色

/** 视图字体适配系数 add by lf */
#define XZFS_VIEW_SCALE      (SGLC_IS_IPHONE_PLUS?1.2:1.0)
#define XZFS_FONT_SCALE      (SGLC_IS_IPHONE_PLUS?1.2:1.0)

/** px 值的转换 */
#define XZFS_FONT_PX(pxValue)  ((pxValue)/2.0)
#define XZFS_VIEW_PX(pxValue)  ((pxValue)/2.0)




/** 资源路径 */
#define XZFS_PNG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define XZFS_JPG_PATH(NAME) [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define XZFS_PATH(NAME,EXT) [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

/** 加载图片 */
#define XZFS_PNG_IMAGE_FILE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define XZFS_JPG_IMAGE_FILE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define XZFS_IMAGE_FILE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define XZFS_IMAGE_NAMED(NAME)       [UIImage imageNamed:NAME]

//ios 版本
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define XZFS_IS_IOS6 (SYSTEM_VERSION >= 6.0 && SYSTEM_VERSION < 7)
#define XZFS_IS_IOS7 (SYSTEM_VERSION >= 7.0 )
#define XZFS_IS_IOS8 (SYSTEM_VERSION >= 8.0 )
#define XZFS_IS_IOS9 (SYSTEM_VERSION >= 9.0 )

/** 设备判断 */
#define XZFS_IS_IPHONE [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define XZFS_IS_PAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** iPhone的型号 */
#define XZFS_IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define XZFS_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define XZFS_IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define XZFS_IS_IPHONE6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736)

/** 系统的版本号 */
#define XZFS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/** APP版本号 */
#define XZFS_APP_VERSION   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** APP BUILD 版本号 */
#define XZFS_APP_BUILD_VERSION  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/** APP名字 */
#define XZFS_APP_DISPLAY_NAME  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

/** 当前语言 */
#define XZFS_LOCAL_LANGUAGE [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]

/** 当前国家 */
#define XZFS_LOCAL_COUNTRY [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]



/** 判断设备室真机还是模拟器 */
#if TARGET_OS_IPHONE
#endif

#if TARGET_IPHONE_SIMULATOR
#endif





// 是否打开log日志输出
#define MYDEBUG DEBUG_SWITH

#if MYDEBUG
#undef NSLog
//#define NSLog(...) NSLog(__VA_ARGS__)
#define NSLog(FORMAT, ...) fprintf(stderr,"%s [%-s\t] [%.4d] %s\n\n", [[NSDate date] stringWithFormat:@"HH:mm:ss"].UTF8String, [[NSString stringWithUTF8String:__FILE__] lastPathComponent].UTF8String, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#undef NSLog
#define NSLog(...) do{}while(0)
#endif /* XZConfig_h */
