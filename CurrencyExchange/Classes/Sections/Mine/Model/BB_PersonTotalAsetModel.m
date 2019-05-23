//
//  BB_PersonTotalAsetModel.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/4/16.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_PersonTotalAsetModel.h"

@implementation BB_PersonTotalAsetModel
+ (NSDictionary *)objectClassInArray{
    return @{
             @"coinlist" : @"BB_AssetModel",
             };
}
@end
