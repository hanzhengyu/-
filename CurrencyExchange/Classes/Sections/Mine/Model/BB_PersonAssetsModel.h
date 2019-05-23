//
//  BB_PersonAssetsModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/22.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicModel.h"

@interface BB_PersonAssetsModel : BB_BasicModel
//@property (nonatomic, copy) NSString * coincode; // 币种编码
//@property (nonatomic, copy) NSString * numaddr; // 账户地址
//@property (nonatomic, copy) NSString * usname; //
//@property (nonatomic, copy) NSString * enname;
//@property (nonatomic, copy) NSString * img;
//@property (nonatomic, copy) NSString * eth;
//@property (nonatomic, assign) NSInteger  num;
//@property (nonatomic, assign) NSInteger  numd;
//@property (nonatomic, assign) NSInteger  zrstatus;
//@property (nonatomic, assign) NSInteger  zcstatus;
//@property (nonatomic, assign) NSInteger  status;
//@property (nonatomic, assign) NSInteger  isvirtual;
//@property (nonatomic, assign) NSInteger  iscc;

@property (nonatomic,strong) NSNumber *round;
@property (nonatomic,copy) NSString *coinImg;
@property (nonatomic,strong) NSNumber *volume;
@property (nonatomic,strong) NSNumber *closePrice;
@property (nonatomic,strong) NSNumber *feeSell;
@property (nonatomic,strong) NSNumber *minPrice;
@property (nonatomic,strong) NSNumber *sellPrice;
@property (nonatomic,copy) NSString *usname;
@property (nonatomic,copy) NSString *coincode;
@property (nonatomic,copy) NSString *gCoincode;
@property (nonatomic,strong) NSNumber *feeBuy;
@property (nonatomic,copy) NSString *ename;
@property (nonatomic,strong) NSNumber *buyPrice;
@property (nonatomic,copy) NSString *fCoincode;
@property (nonatomic,strong) NSNumber *mchange;
@property (nonatomic,strong) NSNumber *newprice;
@property (nonatomic,copy) NSString *marketId;
@property (nonatomic,strong) NSNumber *maxPrice;
@property (nonatomic,assign) long num;
@end
