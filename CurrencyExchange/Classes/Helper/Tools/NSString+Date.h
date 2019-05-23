//
//  NSString+Date.h
//  CurrencyExchange
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)
+(NSString *)cStringFromTimestamp:(NSString *)timestamp;
//字符串转时间戳 如：2017-4-10 17:15:10
- (NSString *)getTimeStrWithString;;
// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTime;

- (NSString *)getDateStringWithTimeFormatter:(NSString *)formatter;
@end
