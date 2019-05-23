//
//  BB_BuyInOrOutView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/23.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^ClickBlock)(NSInteger tag);
#import <UIKit/UIKit.h>

@interface BB_BuyInOrOutView : UIView
@property (nonatomic, copy) ClickBlock block;
@end
