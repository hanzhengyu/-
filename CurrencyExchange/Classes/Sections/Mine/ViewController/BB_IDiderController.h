//
//  BB_IDiderController.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef NS_ENUM(NSUInteger, IdenStatus) {
    IdenStatusNever,
    IdenStatusWaite,
    IdenStatusFail,
    IdenStatusSucess
};
#import "BB_BasicViewController.h"
@interface BB_IDiderController : BB_BasicViewController

@property (nonatomic, assign) IdenStatus status;
@end
