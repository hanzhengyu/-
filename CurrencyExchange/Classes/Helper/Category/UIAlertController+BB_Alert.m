//
//  UIAlertController+BB_Alert.m
//  CurrencyExchange
//
//  Created by company on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "UIAlertController+BB_Alert.h"

@implementation UIAlertController (BB_Alert)
+(void)Alert:(BB_BasicViewController *)nav Tip:(NSString *)str
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
    }]];
    
    [nav presentViewController:alert animated:YES completion:nil];
}

@end
