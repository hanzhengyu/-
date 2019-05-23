//
//  BB_RankListModel.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_RankListModel.h"

@implementation BB_RankListModel



- (NSString *)imageName{
    
    return [_mchange containsString:@"-"] ? @"arrow" : @"arrow-green";
}

- (BOOL)isReduce{
    return [self.mchange containsString:@"-"];
}
@end
