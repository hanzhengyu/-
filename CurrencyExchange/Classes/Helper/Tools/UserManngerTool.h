//
//  UserManngerTool.h
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.


#import <Foundation/Foundation.h>
#import "User.h"
#import "BB_RankListModel.h"
#import "BB_PersonAssetsModel.h"
#import "BB_AssetModel.h"
@interface UserManngerTool : NSObject
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, strong) User * user;

@property (nonatomic, strong) NSArray <BB_RankListModel *>* allCoinArray; // 所有的币种
@property (nonatomic, strong) NSArray <BB_AssetModel *>* allRichArray; // 所有的的资产
@property (nonatomic, strong) NSDictionary * infoDic;

+ (instancetype)share;
- (void)presentloginViewControllercomlpetion:(void(^)())block;
- (void)presenLogin;
- (void)clear; // 清除本地数据

- (void)getCurretnCoinRich:(NSString *)coincode sucess:(void(^)(BB_AssetModel *model))sucess;

- (void)saveUserData;

- (void)loadUserData;
@end
