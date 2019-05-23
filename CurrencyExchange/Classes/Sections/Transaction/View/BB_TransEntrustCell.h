//
//  BB_TransEntrustCell.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^CancelBlock)();
#import "BB_BaseCell.h"
#import "BB_EntrustHistoryModel.h"
#import "BB_EntrustmentRecordModel.h"
@interface BB_TransEntrustCell : BB_BaseCell
@property (nonatomic, strong) BB_EntrustHistoryModel * historyModel;
@property (nonatomic, strong) BB_EntrustmentRecordModel * recodeModel;
@property (nonatomic, copy) CancelBlock block;
- (void)updaEmpty;
@end
