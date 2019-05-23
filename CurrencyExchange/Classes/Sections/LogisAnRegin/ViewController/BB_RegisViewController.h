//
//  BB_RegisViewController.h
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/9.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^BindBlock)();
typedef NS_ENUM(NSUInteger, ChangeType) {
    ChangeTypeRegis = 0,
    ChangeTypeLoginPwd,
    ChangeTypePayPwd,
    
    ChangeTypeBlindEmail,
    ChangeTypeBlindPhone,
};
#import <UIKit/UIKit.h>

@interface BB_RegisViewController : BB_BasicViewController

@property (nonatomic, assign) ChangeType type;
@property (nonatomic, copy) BindBlock block;
@end
