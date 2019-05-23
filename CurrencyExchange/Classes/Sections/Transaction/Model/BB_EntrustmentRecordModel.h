//
//  BB_EntrustmentRecordModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

//coincode = wkb;
//deal = 0;
//dealtime = 0;
//fCoincode = fcny;
//fnum = "0.1";
//gCoincode = fcny;
//gettime = 1523154303826;
//gnum = 1;
//num = 1;
//price = 1;
//statusname = "";
//tdid = 969;
//totalNum = 1;
//tradetime = 1523150789000;
//type = 0;
//typename = "";
#import "BB_BasicModel.h"

@interface BB_EntrustmentRecordModel : BB_BasicModel

@property (nonatomic, copy) NSString *tradetime;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *deal;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *statusname;
@property (nonatomic, assign)long status;
@property (nonatomic, assign) long tdid;
@end
