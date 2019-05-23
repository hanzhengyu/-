//
//  NSString+Tools.h
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/30.
//  Copyright © 2017年 app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)
- (BOOL)validateContactNumber;// 手机号验证
+ (NSString *)stringWithNull:(id)string;
- (NSString *)insteadText:(NSRange)rang; // 用**代替
- (NSString *)insteadTextWithX; // 用**代替
+ (NSString *)curentVersion;


- (BOOL)isValidateEmail;
@end
