//
//  BB_QuoDetailController.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/23.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicViewController.h"
#import "BB_RankListModel.h"
@interface BB_QuoDetailController : BB_BasicViewController
@property (nonatomic, assign) BOOL isTranPush;
@property (nonatomic, strong) BB_RankListModel * listModel;
@property (nonatomic, strong) BB_SellAndBuyListModel *sellBuyModel;
@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * gcode;
@end
