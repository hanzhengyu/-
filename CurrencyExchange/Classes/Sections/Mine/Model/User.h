//
//  User.h
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * creditlevel;
@property (nonatomic, assign) NSInteger isral; // 0未提交，1等待审核，2审核驳回，3审核通过）
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, copy) NSString * invitecode;
@property (nonatomic, assign) NSInteger exp;
@property (nonatomic, copy) NSString * token;
@property (nonatomic, copy) NSString * csrf;
@property (nonatomic, copy) NSString * idcard;
@property (nonatomic, copy) NSString * truename;
@property (nonatomic, copy) NSString * version;


@property (nonatomic, assign) BOOL isBlindEmai; // 是否验证邮箱
@property (nonatomic, assign) BOOL isBlindmobile; // 是否验证手机号
@end
