//
//  Macro.h
//  DirectSelling
//
//  Created by app on 2017/5/23.
//  Copyright © 2017年 app. All rights reserved.
//


#define NSLocalizedString(key, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]

#define NSLocalizedStringFromTable(key, tbl, comment) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:(tbl)]

#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
[bundle localizedStringForKey:(key) value:@"" table:(tbl)]

#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
[bundle localizedStringForKey:(key) value:(val) table:(tbl)]

#define NULLSTRING(S) [NSString stringWithNull:S]
 #define SafeAreaTopHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define SafeAreaNavHeight (SCREEN_HEIGHT == 812.0 ? 44 : 0)
/// 底部宏，
#define SafeAreaBottomHeight (SCREEN_HEIGHT == 812.0 ? 34 : 0)
#define SafeAreaHomeBottomHeight (SCREEN_HEIGHT == 812.0 ? 83 : 49)
//判断是否是iphone4
#define SCREEN_IPHONE_4     (([[UIScreen mainScreen] bounds].size.height) == 480)
//判断是否是iphone5
#define SCREEN_IPHONE_5     (([[UIScreen mainScreen] bounds].size.height) == 568)
//判断是否为iphone6
#define SCREEN_IPHONE_6     (([[UIScreen mainScreen] bounds].size.height) == 667)
//判断是否为iphone6P
#define SCREEN_IPHONE_6PLUS (([[UIScreen mainScreen] bounds].size.height) == 736)
#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0
#define iOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define iOS10 [[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0
#define iOS11 [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0
// 屏幕宽高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
// 通知
#define LRNotificationCenter [NSNotificationCenter defaultCenter]
// 比例
#define Ration(H) (SCREEN_WIDTH / 375) * H
// 调试
#ifdef DEBUG
#define LRLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LRLog(...)

#endif

#define M_FIX_NULL_STRING(_value,_default)  ([_value isEqual:[NSNull null]]||_value==nil)?_default:_value

// 强弱引用
#define LRWeakSelf(type)  __weak typeof(type) weak##type = type;
#define LRStrongSelf(type)  __strong typeof(type) type = weak##type;
#define TOKEN [UserManngerTool share].token
#define USERMANNGER [UserManngerTool share]
// 颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define kRandomColor KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
#define BACKGROUNDCOLOR RGBColor(246,246,246)
#define MainColor RGBColor(55, 130, 246)
#define LRClearColor [UIColor clearColor]
#define HexColor(H) [UIColor colorWithHexString:H]
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
// .h文件
#define SingletonH(name) +(instancetype)share##name;
// .m文件
#define SingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)share##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

// 偏好设置
// 存
#define KUserDefadultSave(Object,Key) [[NSUserDefaults standardUserDefaults] setObject:Object forKey:Key]
#define KUserDefadultGet(Key) [[NSUserDefaults standardUserDefaults] objectForKey:Key]
