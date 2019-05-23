//
//  BB_BasicHandle.h
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/11.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^Sucess)(id json);
typedef void(^Fail)(id json);
#import <Foundation/Foundation.h>
#import "BB_BannerListModel.h"
#import "BB_RankListModel.h"
#import "BB_PersonAssetsModel.h"
#import "BB_SellAndBuyListModel.h"
#import "BB_EntrustmentRecordModel.h"
#import "BB_EntrustHistoryModel.h"
#import "BB_AssetModel.h"
#import "BB_PersonTotalAsetModel.h"
@interface BB_BasicHandle : NSObject

/**
 验证码登录

 @param phone 手机号
 @param pcode 验证码
 */
+ (void)pcodeTokenPhone:(NSString *)phone
                  pcode:(NSString *)pcode
                 sucess:(Sucess)sucess
                   fail:(Fail)fail;;
/**
 发送登陆注册验证码
 @param phone 手机号
 @param sendType 默认0，发送注册验证码 默认0，发送注册验证码，1发送登录验证码
 */
+ (void)sendVercodePhone:(NSString *)phone
                sendType:(NSString *)sendType
                  sucess:(Sucess)sucess
                    fail:(Fail)fail;


/**
 发送其他手机验证码

 @param phone 手机号
 @param sendType 默认0，更换手机验证码 [1更换登录密码，2更换交易密码，3绑定银行卡，4绑定钱包验证码]
 */
+ (void)secretSendVercode:(NSString *)phone
                sendType:(NSString *)sendType
                  sucess:(Sucess)sucess
                    fail:(Fail)fail;
/**
 注册
 @param phone 手机号
 @param regcode 验证码
 @param pswd 密码
 @param payPswd 支付密码
 */
+ (void)regisUser:(NSString *)phone
          regcode:(NSString *)regcode
              pswd:(NSString *)pswd
             payPswd:(NSString *)payPswd
           sucess:(Sucess)sucess
             fail:(Fail)fail;

/**
 登录
 @param username 用户名
 @param password 密码
 */
+ (void)loginTokenUsername:(NSString *)username
                password:(NSString *)password
                  sucess:(Sucess)sucess
                    fail:(Fail)fail;


/**
 首页轮播
 */
+ (void)homeBannerListSucess:(Sucess)sucess
                        fail:(Fail)fail;
/**
 首页币种
 */
+ (void)marketRankingSucess:(Sucess)sucess
                        fail:(Fail)fail;

/**
 玩家网币种
 
 */
+ (void)allMarketTradeDatasortSucess:(Sucess)sucess
                              fail:(Fail)fail;

/**
 获取全球在本平台上架币种的交易行情
 
 */
+ (void)globalAllMarketTradeData:(Sucess)sucess fail:(Fail)fail;

/**
 获取用户资产信息
 */
+ (void)queryUserAssetsInfoSucess:(Sucess)sucess
                             fail:(Fail)fail;

/**
 更换手机号
 @param phone 新手机号
 @param upcode 原绑定手机验证码
 @param payPswd 支付密码
 */
+ (void)updateMobile:(NSString *)phone
           upcode:(NSString *)upcode
           payPswd:(NSString *)payPswd
             sucess:(Sucess)sucess
               fail:(Fail)fail;

/**
 修改用户Email地址
 @param email  新邮箱地址
 @param ecode 原绑定邮箱验证码
 @param payPswd 支付密码
 */
+ (void)updateEmail:(NSString *)email
             ecode:(NSString *)ecode
            payPswd:(NSString *)payPswd
             sucess:(Sucess)sucess
               fail:(Fail)fail;

/**
 获取邮箱验证码
 @param email  邮箱地址
 @param sendType 发送类型（默认为0，更换邮箱地址）
 */
+ (void)sendEmailVercode:(NSString *)email
              sendType:(NSString *)sendType
             sucess:(Sucess)sucess
               fail:(Fail)fail;

/**
通过绑定手机验证码更改登录密码
 @param password   新密码
 @param repeatPswd 重复密码
 @param upcode 已绑定的手机验证码
 */
+ (void)updateLoginPswd:(NSString *)password
                repeatPswd:(NSString *)repeatPswd
                upcode:(NSString *)upcode
                  sucess:(Sucess)sucess
                    fail:(Fail)fail;

/**
 获取用户登陆日志信息列表
 @param pageNum   当前页数
 @param pageSize  每页条数
 */
+ (void)queryUserLoginLog:(NSString *)pageNum
             pageSize:(NSString *)pageSize
                 sucess:(Sucess)sucess
                   fail:(Fail)fail;

/**
 通过绑定手机验证码以及谷歌验证码更改支付密码
 @param password   新支付密码
 @param repeatPswd 重复密码
 @param upcode 已绑定的手机验证码
 */
+ (void)updatePayPswd:(NSString *)password
                 repeatPswd:(NSString *)repeatPswd
                 upcode:(NSString *)upcode
                   sucess:(Sucess)sucess
                     fail:(Fail)fail;

/**
 我的推荐

 */
+ (void)recommend :(Sucess)sucess
                 fail:(Fail)fail;

/**
 获取本人当前的交易委托
 @param coincode   币种编码
 @param gCoincode  兑换币种

 */
+ (void)queryPeddingEntrust:(NSString *)coincode
           gCoincode:(NSString *)gCoincode
               sucess:(Sucess)sucess
                 fail:(Fail)fail;

/**
 拉取委托历史记录
 @param coincode   币种编码
 @param gCoincode  兑换币种

 
 */
+ (void)queryEntrustHistory:(NSString *)coincode
                  gCoincode:(NSString *)gCoincode
                     sucess:(Sucess)sucess
                       fail:(Fail)fail;

/**
 获取用户的成交历史
 @param coincode   币种编码
 @param gCoincode  兑换币种
 @param lasttlid   最后一条委托记录的ID
 */
+ (void)queryUserTradeHistory:(NSString *)coincode
                  gCoincode:(NSString *)gCoincode
                   lasttlid:(int)lasttlid
                     sucess:(Sucess)sucess
                       fail:(Fail)fail;

/**
 拉取市场成交的历史记录
 @param coincode   币种编码
 @param gCoincode  兑换币种
 */
+ (void)queryTradeHistory:(NSString *)coincode
                    gCoincode:(NSString *)gCoincode
                       sucess:(Sucess)sucess
                         fail:(Fail)fail;

/**
 用户提交相关信息进行交易委托
 @param payPswd   支付密码
 @param coincode  当前币种
 @param gCoincode 兑换币种
 @param price   当前价格
 @param num     数量
 @param type    交易类型（买、卖） 0 买  1卖
 */
+ (void)subEntrust:(NSString *)payPswd
                coincode:(NSString *)coincode
                gCoincode:(NSString *)gCoincode
                price:(NSString *)price
                num:(NSString *)num
                type:(NSString *)type
                   sucess:(Sucess)sucess
                     fail:(Fail)fail;

/**
查询某交易市场最新买卖委托列表
 
 @param coincode  币种编码
 @param gCoincode 兑换币种

 */
+ (void)entrustByMarket:(NSString *)coincode
         gCoincode:(NSString *)gCoincode
            sucess:(Sucess)sucess
              fail:(Fail)fail;

/**
 获取本平台某币种最新的行情数据
 
 @param coincode  币种编码
 @param gCoincode 兑换币种
 
 */
+(void)marketTradeData:(NSString *)coincode
             gCoincode:(NSString *)gCoincode
                sucess:(Sucess)sucess
                  fail:(Fail)fail;

/**
 转入历史纪录
 
 @param coincode  币种编码
 @param pageNum   当前页数
 @param pageSize  每页条数
 */
+(void)coinzrList:(NSString *)coincode
             gCoincode:(int )pageNum
              pageSize:(int )pageSize
                sucess:(Sucess)sucess
                  fail:(Fail)fail;

/**
 转入历史纪录
 
 @param coincode  币种编码
 @param pageNum   当前页数
 @param pageSize  每页条数
 */
+(void)coinzcList:(NSString *)coincode
        gCoincode:(int )pageNum
         pageSize:(int )pageSize
           sucess:(Sucess)sucess
             fail:(Fail)fail;

/**
拉取充值类型列表
 @param cztype  充值类型
 */
+(void)findZctypeList:(NSString *)cztype
           sucess:(Sucess)sucess
             fail:(Fail)fail;

/**
 获取官方公告列表
 @param pageNum   当前页数
 @param pageSize  每页条数
 */
+(void)notifyList:(int )pageNum
         pageSize:(int )pageSize
           sucess:(Sucess)sucess
             fail:(Fail)fail;

/**
 新版更新提醒
 */
+(void)appVersionUpdate:(Sucess)sucess
                 fail:(Fail)fail;

/**
 获取服务端策略信息
 */
+(void)serverStrategy :(Sucess)sucess
                    fail:(Fail)fail;

/**
   提交身份证验证信息
 @param sysUserIdcard  //身份信息认证类
 @param enname   //姓名
 @param idcard  // 身份证号
 @param ximg   //身份证正面照
 @param yimg   //身份证反面照
 @param zimg   //手持照
 */
+(void)subUserIdInfo:(NSString *)sysUserIdcard
         enname:(NSString *)enname
         idcard:(NSString *)idcard
         ximg:(NSString *)ximg
         yimg:(NSString *)yimg
         zimg:(NSString *)zimg
           sucess:(Sucess)sucess
             fail:(Fail)fail;

/**
    绑定银行卡
 @param bank  //银行卡类型
 @param bankcard   //银行卡号
 @param name  // 持卡人姓名
 @param bankaddr   //开户支行
 @param bankcity   //卡所属城市
 @param paypassword   //支付密码
 */
+(void)bindUserBank:(NSString *)bank
              bankcard:(NSString *)bankcard
              name:(NSString *)name
                bankaddr:(NSString *)bankaddr
                bankcity:(NSString *)bankcity
                paypassword:(NSString *)paypassword
              sucess:(Sucess)sucess
                fail:(Fail)fail;

/**
 解绑银行卡
 @param bankid //银行卡id

 */
+(void)ubindUserBank:(NSString *)bankid
             sucess:(Sucess)sucess
               fail:(Fail)fail;
/**
 拉取银行卡列表
 @param bank //银行卡
 
 */
+(void)bankUserList:(NSString *)bank
              sucess:(Sucess)sucess
                fail:(Fail)fail;

/**
绑定用户钱包地址
 @param coincode //币种编码
 @param numaddr //账户地址
 */
+(void)bindUserCoinAddr:(NSString *)coincode
            numaddr:(NSString *)numaddr
              sucess:(Sucess)sucess
                fail:(Fail)fail;

/**
 申请提现
 @param num //数量
 @param bankid //银行卡id
  @param paypassword //支付密码
 */
+(void)applyBankCash:(NSString *)num
                bankid:(NSString *)bankid
         paypassword:(NSString *)paypassword
                 sucess:(Sucess)sucess
                fail:(Fail)fail;


/**
 拉取用户奖励列表
 @param pageNum //当前页面
 @param pageSize //
 */
+(void)invitUserList:(int)pageNum
             pageSize:(int)pageSize
              sucess:(Sucess)sucess
               fail:(Fail)fail;


/**
    检查用户银行卡和支付密码
 
 */
+(void)checkUserPaypwdAndBank:(Sucess)sucess
                fail:(Fail)fail;

/**
  申请数字货币转出
 
 @param num //当前页面
 @param coincode //
 **/
+(void)applyCoinCash:(int)num
            coincode:(NSString *)coincode
              sucess:(Sucess)sucess
                fail:(Fail)fail;

/**
 获取币种详情

 @param coincode 币种编码
 @param gCoincode 兑换币种
 @param type 时间段(1m  3m  5m  10m  15m  30m  1h 2h 4h 6h 12h 1d 7d )
 @param total 拉取条数，默认300条
 */
+ (void)publicShowDate:(NSString *)coincode
             gCoincode:(NSString *)gCoincode
                  type:(NSString *)type
                 total:(int)total
                sucess:(Sucess)sucess
                  fail:(Fail)fail;

/**
 取消委托

 @param tdid 委托主键id

 */
+ (void)cancelEntrustByMarketTdid:(long)tdid
                           sucess:(Sucess)sucess
                             fail:(Fail)fail;

/**
  用户信息
 
 */
+ (void)userInfo:(Sucess)sucess fail:(Fail)fail;
@end
