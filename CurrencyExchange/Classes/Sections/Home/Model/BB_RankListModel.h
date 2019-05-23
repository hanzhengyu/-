//
//  BB_RankListModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicModel.h"
//usname": "btc coin",
//"ename": "比特币",
//"coinImg": "http://p13.qhimg.com/t01c63ac204076bff4b.jpg",
//"coincode": "btc",
//"gCoincode": "wc",
//"newPrice": 2,
//"fCoincode": "",
//"mchange": -0.6,
//"buyPrice": 5,
//"sellPrice": 2,
//"volume": 1,
//"minPrice": 0,
//"maxPrice": 0,
//"round": 0,
//"closePrice": 0
@interface BB_RankListModel : BB_BasicModel
@property (nonatomic, copy) NSString * usname;
@property (nonatomic, copy) NSString * ename;
@property (nonatomic, copy) NSString * coinImg;
@property (nonatomic, copy) NSString * coincode;
@property (nonatomic, copy) NSString * gCoincode;
@property (nonatomic, copy) NSString * fCoincode;
@property (nonatomic, copy) NSString * mchange;
@property (nonatomic, copy) NSString * buyPrice;
@property (nonatomic, copy) NSString * sellPrice;
@property (nonatomic, copy) NSString * volume;
@property (nonatomic, copy) NSString * minPrice;
@property (nonatomic, copy) NSString * maxPrice;
@property (nonatomic, copy) NSString * round;
@property (nonatomic, copy) NSString * closePrice;
@property (nonatomic, assign) NSInteger newPrice;

// 买卖费率
@property (nonatomic, copy) NSString * feeBuy;
@property (nonatomic, copy) NSString * feeSell;

// 排行榜
@property (nonatomic, copy) NSString * ranking;
@property (nonatomic, copy) NSString * imageName;
@property (nonatomic, assign) BOOL isReduce; // 是否是降价
@end
