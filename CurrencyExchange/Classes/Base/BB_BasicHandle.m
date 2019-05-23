//
//  BB_BasicHandle.m
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/11.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BasicHandle.h"
#import "MALRSACrypto.h"
#import "NSString+HiiUtil.h"

@implementation BB_BasicHandle
+ (void)regisUser:(NSString *)phone regcode:(NSString *)regcode pswd:(NSString *)pswd payPswd:(NSString *)payPswd sucess:(Sucess)sucess fail:(Fail)fail{
    
   
    [HttpTool postShowHudWithPath:RegUser params:@{@"phone":phone,@"regcode":regcode,@"pswd":pswd,@"payPswd":payPswd} success:^(id json) {
         sucess(json);
    } failure:^(NSError *error) {
       
    }];
}

+ (void)loginTokenUsername:(NSString *)username password:(NSString *)password sucess:(Sucess)sucess fail:(Fail)fail{
    SecKeyRef *key = [NSString addPublicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCEG0FGiZYfO/6HVJGxRxAe/gt281ytXvMgeCdEXX4MoiFz6qA0pwnmfED2x0kEuUapfGq0gLv2D/LcYnWAGS3dqi55qvUu90fCQwMInqCW1AvIJYORGiCv3z2nAqTlkN7wFQzwgShC4TFSZQ5dmRxP/2mw/pv4Xk341NbwONUW0QIDAQAB"];
    
    NSString *string = [NSString stringWithFormat:@"%@%@",password,@"w5giev93ZqQlHvzEahYbnB%RZF5BnI"];
    NSString *psd = [MALRSACrypto encrypt:string withPubKey:key];
   //
    NSString *pass =  [ psd stringByReplacingOccurrencesOfString:@"+" withString:@"moduo"];


    NSDictionary * dic = @{@"username":username,
                           @"password":pass
                           };
    [HttpTool postShowHudWithPath:LoginToken params:dic success:^(id json) {
        [UserManngerTool share].user = [User mj_objectWithKeyValues:json];
        [UserManngerTool share].isLogin = YES;
        [[UserManngerTool share] saveUserData];
        [[AFHttpClient sharedClient].requestSerializer setValue:[UserManngerTool share].user.token forHTTPHeaderField:@"access_token"];
        
        // 发送成功登陆成功
      //  [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCESS object:nil];
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)pcodeTokenPhone:(NSString *)phone pcode:(NSString *)pcode sucess:(Sucess)sucess fail:(Fail)fail{
    NSDictionary * dic = @{@"phone":phone,
                           @"pcode":pcode
                           };
    [HttpTool postShowHudWithPath:PcodeToken params:dic success:^(id json) {
        [UserManngerTool share].user = [User mj_objectWithKeyValues:json];
        [UserManngerTool share].isLogin = YES;
        [[UserManngerTool share] saveUserData];
        [[AFHttpClient sharedClient].requestSerializer setValue:[UserManngerTool share].user.token forHTTPHeaderField:@"access_token"];


        // 发送成功登陆成功
      //  [[NSNotificationCenter defaultCenter] postNotificationName:LOGINSUCESS object:nil];
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}
 
+ (void)sendVercodePhone:(NSString *)phone sendType:(NSString *)sendType sucess:(Sucess)sucess fail:(Fail)fail{
    
    [HUDTools shoInfoWithStatus:@"正在发送"];
    [HttpTool postWithPath:SendRegistVercode params:@{@"phone":phone,@"sendType":sendType} success:^(id json) {
        [HUDTools shoInfoWithStatus:@"发送成功"];

        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)secretSendVercode:(NSString *)phone sendType:(NSString *)sendType sucess:(Sucess)sucess fail:(Fail)fail{
    [HUDTools shoInfoWithStatus:@"正在发送"];
    [HttpTool postWithPath:SecretSendVercode params:@{@"phone":phone,@"sendType":sendType} success:^(id json) {
        [HUDTools shoInfoWithStatus:@"发送成功"];
        
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)homeBannerListSucess:(Sucess)sucess fail:(Fail)fail{
    [HttpTool postWithPath:BannerList params:nil success:^(id json) {
     
        NSArray * data = [BB_BannerListModel mj_objectArrayWithKeyValuesArray:json];
        sucess(data);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)marketRankingSucess:(Sucess)sucess fail:(Fail)fail{
    [HttpTool postWithPath:MarketRanking params:nil success:^(id json) {
        
        NSArray * data = [BB_RankListModel mj_objectArrayWithKeyValuesArray:json];
        sucess(data);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)allMarketTradeDatasortSucess:(Sucess)sucess fail:(Fail)fail{
    [HttpTool postShowHudWithPath:AllMarketTradeData params:@{@"sortFlag":@"true"} success:^(id json) {
        NSArray * data = [BB_RankListModel mj_objectArrayWithKeyValuesArray:json];
        USERMANNGER.allCoinArray = data;
        sucess(data);
    } failure:^(NSError *error) {
        
    }];
}
+ (void)queryUserAssetsInfoSucess:(Sucess)sucess fail:(Fail)fail{
    [HttpTool postShowHudWithPath:QueryUserAssetsInfo params:nil success:^(id json) {
      
        BB_PersonTotalAsetModel *model = [BB_PersonTotalAsetModel mj_objectWithKeyValues:json];
        USERMANNGER.allRichArray = model.coinlist;
        sucess(model);
    } failure:^(NSError *error) {
        
    }];
}


+(void)updateMobile:(NSString *)phone upcode:(NSString *)upcode payPswd:(NSString *)payPswd sucess:(Sucess)sucess fail:(Fail)fail
{
  NSDictionary * dic = @{@"phone":phone,
                        @"upcode":upcode,
                        @"payPswd":payPswd
                           };
    [HttpTool postWithPath:UpdateUserMobile params:dic success:^(id json) {
     
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateEmail:(NSString *)email ecode:(NSString *)ecode payPswd:(NSString *)payPswd sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"email":email,
                           @"ecode":ecode,
                           @"payPswd":payPswd
                           };
    [HttpTool postWithPath:UpdateUserEmail params:dic success:^(id json) {
       sucess(nil);
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)sendEmailVercode:(NSString *)email sendType:(NSString *)sendType sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"email":email,
                           @"sendType":sendType
                           };
    [HttpTool postWithPath:SendEmailVercode params:dic success:^(id json) {
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}

+(void)updateLoginPswd:(NSString *)password repeatPswd:(NSString *)repeatPswd upcode:(NSString *)upcode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"password":password,
                           @"repeatPswd":repeatPswd,
                           @"upcode":upcode
                           };
    [HttpTool postWithPath:UpdateLoginPswd params:dic success:^(id json) {
       
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
    
}

+(void)queryUserLoginLog:(NSString *)pageNum pageSize:(NSString *)pageSize sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"pageNum":pageNum,
                           @"pageSize":pageSize,
                           };
    [HttpTool postWithPath:QueryUserLoginLog params:dic success:^(id json) {
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}

+(void)updatePayPswd:(NSString *)password repeatPswd:(NSString *)repeatPswd upcode:(NSString *)upcode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"password":password,
                           @"repeatPswd":repeatPswd,
                           @"upcode":upcode,
                           };
    [HttpTool postWithPath:UpdatePayPswd params:dic success:^(id json) {
      
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}

+(void)recommend:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:Recommend params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)queryPeddingEntrust:(NSString *)coincode gCoincode:(NSString *)gCoincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"coincode":coincode,
                           @"gCoincode":gCoincode
                           };
    [HttpTool postWithPath:QueryPeddingEntrust params:dic success:^(id json) {
        NSArray * dataArray = [BB_EntrustmentRecordModel mj_objectArrayWithKeyValuesArray:json];
        sucess(dataArray);
    } failure:^(NSError *error) {
        
    }];
}

+(void)queryEntrustHistory:(NSString *)coincode gCoincode:(NSString *)gCoincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"coincode":coincode,
                           @"gCoincode":gCoincode};
    
    [HttpTool postWithPath:QueryEntrustHistory params:dic success:^(id json) {
        NSArray * dataArray = [BB_EntrustmentRecordModel mj_objectArrayWithKeyValuesArray:json[@"t"]];
        sucess(dataArray);
    } failure:^(NSError *error) {
        
    }];
}

+(void)queryUserTradeHistory:(NSString *)coincode gCoincode:(NSString *)gCoincode lasttlid:(int)lasttlid sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"coincode":coincode,
                           @"gCoincode":gCoincode,
                           @"lasttlid":[NSString stringWithFormat:@"%d",lasttlid]
                           };
    
    [HttpTool postWithPath:QueryUserTradeHistory params:dic success:^(id json) {
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];
}

+(void)queryTradeHistory:(NSString *)coincode gCoincode:(NSString *)gCoincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"coincode":coincode,
                           @"gCoincode":gCoincode
                           };
    
    [HttpTool postShowHudWithPath:QueryTradeHistory params:dic success:^(id json) {
        LRLog(@"%@",json);
        NSArray *dataArray = [BB_EntrustHistoryModel mj_objectArrayWithKeyValuesArray:json];
        sucess(dataArray);
    } failure:^(NSError *error) {
        
    }];
}

+(void)subEntrust:(NSString *)payPswd coincode:(NSString *)coincode gCoincode:(NSString *)gCoincode price:(NSString *)price num:(NSString *)num type:(NSString *)type sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{@"payPswd":payPswd,
                           @"coincode":coincode,
                           @"gCoincode":gCoincode,
                           @"price":price,
                           @"num":num,
                           @"type":type
                           };
    
    [HttpTool postWithPath:SubEntrust params:dic success:^(id json) {
        sucess(nil);
    } failure:^(NSError *error) {
        
    }];

}

+(void)entrustByMarket:(NSString *)coincode gCoincode:(NSString *)gCoincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary * dic = @{
                           @"coincode":coincode,
                           @"gCoincode":gCoincode
                           };
    [HttpTool postWithPath:EntrustByMarket params:dic success:^(id json) {
        BB_SellAndBuyListModel * model = [BB_SellAndBuyListModel mj_objectWithKeyValues:json];
        sucess(model);
    } failure:^(NSError *error) {
        
    }];
}

+(void)globalAllMarketTradeData:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:GlobalAllMarketTradeData params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)marketTradeData:(NSString *)coincode gCoincode:(NSString *)gCoincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"coincode":coincode,@"gCoincode":gCoincode};
    [HttpTool postWithPath:MarketTradeData params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)coinzrList:(NSString *)coincode gCoincode:(int)pageNum pageSize:(int)pageSize sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"coincode":coincode,@"pageNum":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    [HttpTool postWithPath:CoinzrList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void)coinzcList:(NSString *)coincode gCoincode:(int)pageNum pageSize:(int)pageSize sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"coincode":coincode,@"pageNum":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    [HttpTool postWithPath:CoinzcList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void)findZctypeList:(NSString *)cztype sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"cztype":cztype};
    [HttpTool postWithPath:FindZctypeList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void)notifyList:(int)pageNum pageSize:(int)pageSize sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"pageNum":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    [HttpTool postWithPath:NotifyList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)appVersionUpdate:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:AppVersionUpdate params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)serverStrategy:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:ServerStrategy params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)subUserIdInfo:(NSString *)sysUserIdcard enname:(NSString *)enname idcard:(NSString *)idcard ximg:(NSString *)ximg yimg:(NSString *)yimg zimg:(NSString *)zimg sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"sysUserIdcard":sysUserIdcard,@"enname":enname
                          ,@"idcard":idcard,@"ximg":ximg,@"yimg":yimg,
                          @"zimg":zimg
                          };
    [HttpTool postWithPath:NotifyList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

+(void)bindUserBank:(NSString *)bank bankcard:(NSString *)bankcard name:(NSString *)name bankaddr:(NSString *)bankaddr bankcity:(NSString *)bankcity paypassword:(NSString *)paypassword sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"bank":bank,@"bankcard":bankcard
                          ,@"name":name,@"bankaddr":bankaddr,@"bankcity":bankcity,
                          @"paypassword":paypassword
                          };
    [HttpTool postWithPath:BindUserBank params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)ubindUserBank:(NSString *)bankid sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"bankid":bankid
                          };
    [HttpTool postWithPath:UbindUserBank params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)bankUserList:(NSString *)bank sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"bank":bank
                          };
    [HttpTool postWithPath:BankUserList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)bindUserCoinAddr:(NSString *)coincode numaddr:(NSString *)numaddr sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"coincode":coincode,@"numaddr":numaddr
                          };
    [HttpTool postWithPath:BindUserCoinAddr params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)applyBankCash:(NSString *)num bankid:(NSString *)bankid paypassword:(NSString *)paypassword sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"num":num,@"bankid":bankid,@"paypassword":paypassword
                          };
    [HttpTool postWithPath:ApplyBankCash params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)invitUserList:(int)pageNum pageSize:(int)pageSize sucess:(Sucess)sucess fail:(Fail)fail{
    NSDictionary *dic = @{@"pageNum":[NSString stringWithFormat:@"%d",pageNum],@"pageSize":[NSString stringWithFormat:@"%d",pageSize]};
    [HttpTool postWithPath:InvitUserList params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)checkUserPaypwdAndBank:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:CheckUserPaypwdAndBank params:nil success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}

+(void)applyCoinCash:(int)num coincode:(NSString *)coincode sucess:(Sucess)sucess fail:(Fail)fail
{
    NSDictionary *dic = @{@"num":[NSString stringWithFormat:@"%d",num],@"coincode":coincode};
    [HttpTool postWithPath:ApplyBankCash params:dic success:^(id json) {
        
    } failure:^(NSError *error) {
        
    }];
}
+ (void)publicShowDate:(NSString *)coincode gCoincode:(NSString *)gCoincode type:(NSString *)type total:(int)total sucess:(Sucess)sucess fail:(Fail)fail{
    NSDictionary *dic = @{@"coincode":coincode,
                          @"gCoincode":gCoincode,
                          @"type":type,
                          @"total":(@300)
                          };
    [HttpTool postWithPath:PublicShowData params:dic success:^(id json) {
        sucess(json);
    } failure:^(NSError *error) {
        
    }];
}

+ (void)cancelEntrustByMarketTdid:(long)tdid sucess:(Sucess)sucess fail:(Fail)fail{
    NSDictionary *dic = @{
                          @"tdid":@(tdid)
                          };
    [HttpTool postWithPath:CancelEntrustByMarket params:dic success:^(id json) {
        [HUDTools shoInfoWithStatus:@"撤回成功"];
        sucess(json);
    } failure:^(NSError *error) {
        [HUDTools shoInfoWithStatus:@"撤回失败"];
    }];
}

+(void)userInfo:(Sucess)sucess fail:(Fail)fail
{
    [HttpTool postWithPath:UserInfo params:nil success:^(id json) {
        sucess(json);
    } failure:^(NSError *error) {
        
    }];
    
    
 
    
}
@end
