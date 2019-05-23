//
//  BB_EntrustHistoryModel.m
//  CurrencyExchange
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_EntrustHistoryModel.h"

@implementation BB_EntrustHistoryModel
- (void)setType:(long)type{
    _type = type;
    if (self.type) {
        self.typeName = @"买入";
        self.typeColor = RGBColor(13, 193, 136);
    }else{
        self.typeName = @"卖出";
        self.typeColor = [UIColor orangeColor];
    }
}
- (void)setStatus:(long)status{
    _status = status;
    if (status == -1) {
        self.statusname = @"取消委托";
    }else if (status == 0){
        self.statusname = @"正在委托";
    }else{
        self.statusname = @"撤销委托";
    }
}
@end
