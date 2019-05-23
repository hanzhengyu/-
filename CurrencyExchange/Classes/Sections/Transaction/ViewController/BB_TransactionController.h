//
//  BB_TransactionController.h
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/6.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicViewController.h"

@interface BB_TransactionController : BB_BasicViewController

@property (nonatomic, assign) BOOL isTranPush;
@property (nonatomic, copy) NSString * coincode;
@property (nonatomic, copy) NSString * gCoincode;
@property (nonatomic, strong) BB_RankListModel * listmodel;

- (void)loadData;
- (void)setupdateLeftBtnCouncode:(NSString *)coincode gCoincode:(NSString *)gCoincode;
- (void)upDateLineWithTag:(NSInteger)tag;
- (void)updateHeaderView:(BB_RankListModel *)model;
@end
