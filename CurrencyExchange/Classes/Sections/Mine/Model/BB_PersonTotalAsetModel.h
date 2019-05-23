//
//  BB_PersonTotalAsetModel.h
//  CurrencyExchange
//
//  Created by 崔博 on 2018/4/16.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BB_AssetModel.h"
@interface BB_PersonTotalAsetModel : NSObject
@property (nonatomic, copy) NSString * numtotal;
@property (nonatomic, copy) NSString * avatotal;
@property (nonatomic, strong) NSArray <BB_AssetModel *>* coinlist;
@end
