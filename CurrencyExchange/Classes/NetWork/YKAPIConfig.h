//
//  YKAPIConfig.h
//  YingKe
//
//  Created by 崔博 on 16/11/20.
//  Copyright © 2016年 崔博. All rights reserved.

#import <Foundation/Foundation.h>

@interface YKAPIConfig : NSObject

//#define BASEURL            @"http://47.52.170.35:8889/" // 测试服务器
#define BASEURL            @"http://api.moduointerface.com/" // 正式服务器
#define PcodeToken         @"pcodeToken" // 验证码登录
#define LoginToken          @"loginToken"  // 登录
#define SendRegistVercode   @"sendRegVercode" // 发送注册验证码（不用登陆）
#define SecretSendVercode   @"secret/sendVercode"   //发送验证码（用登陆）
#define RegUser             @"regUser" // 注册
#define BannerList          @"public/bannerList" // 首页轮播
#define MarketRanking       @"public/marketRanking" // 首页币种
#define AllMarketTradeData  @"public/allMarketTradeData" // 平台所有币种
#define GlobalAllMarketTradeData @"public/globalAllMarketTradeData" //获取全球在本平台上架币种的交易行情
#define QueryUserAssetsInfo @"secret/queryUserAssetsInfo" // 获取用户资产信息
#define UpdateUserMobile    @"secret/updateUserMobile" // 更新手机号
#define UpdateUserEmail     @"secret/updateUserEmail"//  修改用户Email地址
#define SendEmailVercode    @"secret/sendEmailVercode"//   发送邮箱验证码
#define UpdateLoginPswd     @"secret/updateLoginPswd"  // 更改登录密码
#define QueryUserLoginLog   @"secret/queryUserLoginLog"// 拉取用户登陆日志
#define UpdatePayPswd       @"secret/updatePayPswd"// 更改支付密码
#define Recommend           @"secret/recommend"// 我的推荐
#define QueryPeddingEntrust @"secret/queryPeddingEntrust"//     拉取等待交易的委托记录
#define QueryEntrustHistory @"secret/queryEntrustHistory"//   拉取委托历史记录
#define QueryUserTradeHistory @"secret/queryUserTradeHistory"// 拉取用户成交历史
#define QueryTradeHistory  @"public/queryTradeHistory" //   拉取市场成交历史记录
#define SubEntrust         @"secret/subEntrust"   //用户提交相关信息进行交易委托
#define EntrustByMarket    @"public/entrustByMarket"//   查询某交易市场最新买卖委托列表
#define MarketTradeData    @"public/marketTradeData"//  拉取平台某币种最新行情数据
#define PublicShowData    @"public/marketChartData"//  拉取平台某币种最新行情数据
#define CoinzrList         @"secret/coinzrList"  //转入历史纪录 
#define CoinzcList         @"secret/coinzcList"   //转出历史纪录
#define FindZctypeList     @"secret/findZctypeList"   //拉取充值类型列表
#define NotifyList         @"public/notifyList"   //获取官方公告列表
#define AppVersionUpdate   @"secret/appVersionUpdate" //新版更新提醒
#define ServerStrategy     @"secret/serverStrategy"  //获取服务端策略信息（可用于切换客户端拉取策略，socket推送或http等方式）
#define SubUserIdInfo      @"secret/subUserIdInfo"  //   提交身份证验证信息
#define BindUserBank       @"secret/bindUserBank"  //     绑定银行卡
#define UbindUserBank      @"secret/ubindUserBank" //      解绑银行卡
#define BankUserList       @"secret/bankUserList" //  拉取银行卡列表
#define BindUserCoinAddr   @"secret/bindUserCoinAddr" // 绑定用户钱包地址
#define ApplyBankCash      @"secret/applyBankCash" // 申请提现
#define InvitUserList      @"secret/invitUserList" //拉取用户奖励列表
#define CheckUserPaypwdAndBank @"secret/checkUserPaypwdAndBank"  //   检查用户银行卡和支付密码
#define ApplyCoinCash      @"secret/applyCoinCash"  //    申请数字货币转出
#define CancelEntrustByMarket @"secret/cancelEntrustByMarket" // 取消委托
#define UserInfo            @"secret/queryUserInfo"   //用户信息

@end
