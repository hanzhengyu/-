//
//  BB_LoginController.h
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/7.
//  Copyright © 2018年 崔博. All rights reserved.
//
typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeLogin = 0,
    LoginTypeBindPhone,
    LoginTypeBingEmail,

};

#import "BB_BasicViewController.h"

@interface BB_LoginController : BB_BasicViewController

@property (nonatomic, assign) LoginType loginType;
@end
