//
//  BB_SellAndBuyListModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicModel.h"
#import "BB_SellAndBuyModel.h"
@interface BB_SellAndBuyListModel : BB_BasicModel
@property (nonatomic, strong) NSArray * buyList;
@property (nonatomic, strong) NSArray * sellList;


@property (nonatomic, strong) BB_SellAndBuyModel * buylistTopModel; // 收入最高的列表
@property (nonatomic, strong) BB_SellAndBuyModel * selllistTopModel; // 出售列表
@end
