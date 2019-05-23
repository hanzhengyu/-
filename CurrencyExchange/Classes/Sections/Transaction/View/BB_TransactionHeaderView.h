//
//  BB_TransactionHeaderView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/13.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^TransClickBlock)();
typedef void(^BuyOrSellBlock)(NSInteger index);
#import <UIKit/UIKit.h>
#import "BB_SellAndBuyListModel.h"
#import "BB_RankListModel.h"
#import "BB_AssetModel.h"
@interface BB_TransactionHeaderView : UIView
@property (nonatomic, strong) BB_SellAndBuyListModel *model;
@property (nonatomic, strong) BB_RankListModel * listModel;
@property (nonatomic, strong) BB_AssetModel * assetModel;

@property (nonatomic, copy) TransClickBlock  clickBlock;
@property (nonatomic, copy) BuyOrSellBlock  buyorsellBlock;

@property (nonatomic, copy) NSString  *logTitle;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *price;
// 更新数量
- (void)upDateLineWithTag:(NSInteger)tag;
// 更新按钮
- (void)upDateLoginBtn;

@end
