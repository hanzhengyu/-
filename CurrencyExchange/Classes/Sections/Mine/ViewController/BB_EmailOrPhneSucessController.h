//
//  BB_EmailOrPhneSucessController.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/21.
//  Copyright © 2018年 崔博. All rights reserved.
//
typedef NS_ENUM(NSUInteger, SucessType) {
    SucessTypeEmail,
    SucessTypePhone,
};
#import "BB_BasicViewController.h"

@interface BB_EmailOrPhneSucessController : BB_BasicViewController
@property (nonatomic, copy) NSString * text;
@property (nonatomic, assign) SucessType type;
@end
