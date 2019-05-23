//
//  BB_BannerListModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicModel.h"

@interface BB_BannerListModel : BB_BasicModel

@property (nonatomic, assign) NSInteger bannerid;
@property (nonatomic, strong) NSString * imgurl;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * href;
@end
