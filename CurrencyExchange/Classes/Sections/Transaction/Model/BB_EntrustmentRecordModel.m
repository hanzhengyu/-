//
//  BB_EntrustmentRecordModel.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_EntrustmentRecordModel.h"

@implementation BB_EntrustmentRecordModel
- (void)setType:(long)type{
    _type = type;
    if (self.type) {
        self.typeName = @"买入";
    }else{
        self.typeName = @"卖出";
    }
}

@end
