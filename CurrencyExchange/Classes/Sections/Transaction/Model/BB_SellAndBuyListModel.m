//
//  BB_SellAndBuyListModel.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_SellAndBuyListModel.h"

@implementation BB_SellAndBuyListModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"buyList" : @"BB_SellAndBuyModel",
             @"sellList" : @"BB_SellAndBuyModel"
             };
}
- (void)setBuyList:(NSArray *)buyList{
    _buyList = buyList;
    if (buyList.count) {
       self.buylistTopModel = buyList[0];
    }
    
}
- (void)setSellList:(NSArray *)sellList{
    _sellList = sellList;
    if (sellList.count) {
       self.selllistTopModel = sellList[0];
    }
    
}
@end
