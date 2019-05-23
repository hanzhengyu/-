//
//  HUDTools.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/29.
//  Copyright © 2017年 app. All rights reserved.
//

#import "HUDTools.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation HUDTools

SingletonM()
+ (void)showWithStatus:(NSString *)status{
    [SVProgressHUD showWithStatus:status];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
+ (void)showSucess{
    [SVProgressHUD showSuccessWithStatus:@"正在请求"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
+ (void)showError{
    [SVProgressHUD showErrorWithStatus:@"请求失败"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}
+ (void)dismiss{
    [SVProgressHUD dismiss];
}
+ (void)shoInfoWithStatus:(NSString *)info{ // 显示信息
    [SVProgressHUD showInfoWithStatus:info];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:2];
}
@end
