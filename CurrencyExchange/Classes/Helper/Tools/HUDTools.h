//
//  HUDTools.h
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/29.
//  Copyright © 2017年 app. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUDTools : NSObject


+ (void)showSucess; // 显示成功
+ (void)showError;// 显示失败
+ (void)dismiss; // 移除
+ (void)shoInfoWithStatus:(NSString *)info; // 显示信息
+ (void)showWithStatus:(NSString *)status;
@end
