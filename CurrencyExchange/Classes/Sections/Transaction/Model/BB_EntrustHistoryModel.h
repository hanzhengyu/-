//
//  BB_EntrustHistoryModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicModel.h"

@interface BB_EntrustHistoryModel : BB_BasicModel
@property (nonatomic, copy) NSString * coincode;
@property (nonatomic, copy) NSString * gCoincode;
@property (nonatomic, copy) NSString * gettime;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, assign) long tlid;
@property (nonatomic, copy) NSString * totalNum;
@property (nonatomic, copy) NSString * tradetime;
@property (nonatomic, assign) long  type; // 0 买入 1 卖出
@property (nonatomic, assign) long status;
@property (nonatomic, copy) NSString * statusname;

@property (nonatomic, copy) NSString * typeName;
@property (nonatomic, strong) UIColor * typeColor;
@end
