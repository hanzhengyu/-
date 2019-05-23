//
//  BB_AssetModel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/4/10.
//  Copyright © 2018年 崔博. All rights reserved.
//

//coincode = act;
//enname = ACT;
//img = "http://vbourseimg.oss-cn-hongkong.aliyuncs.com/152325752913542053.jpg";
//iscc = 0;
//isvirtual = 1;
//num = 0;
//numaddr = "";
//numd = 0;
//status = 1;
//usname = ACT;
//wallettype = eth;
//zcstatus = 0;
//zrstatus = 1;
#import <Foundation/Foundation.h>

@interface BB_AssetModel : NSObject
@property (nonatomic, strong) NSString * coincode;
@property (nonatomic, assign) long num;
@property (nonatomic, assign) long numd;
@property (nonatomic, strong) NSString * numaddr;
@property (nonatomic, strong) NSString * img;
@property (nonatomic, strong) NSString * enname;
@property (nonatomic, strong) NSString * usname;
@end
