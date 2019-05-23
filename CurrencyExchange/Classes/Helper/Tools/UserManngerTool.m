//
//  UserManngerTool.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.
//

#import "UserManngerTool.h"
#import "BB_LoginController.h"

#define UserDataFilePath [NSString stringWithFormat:@"%@/Documents/userinfo.data",NSHomeDirectory()]

@implementation UserManngerTool

SingletonM()

- (void)saveUserData
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:@(self.isLogin) forKey:@"isLogin"];
    [user synchronize];
    
    [NSKeyedArchiver archiveRootObject:self.user toFile:UserDataFilePath];
}

- (void)loadUserData
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSNumber *isLogin=[user valueForKey:@"isLogin"];
    self.isLogin=[isLogin boolValue];
    
    id object=[NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
    if (object) {
        self.user=object;
    }else
    {
        //  NSLog(@"以前没有数据");
    }
    
}



//- presentloginViewControllerComlpetion
- (void)presentloginViewControllercomlpetion:(void (^)())block{
    if (!self.isLogin) {
        BB_LoginController * loginvc = [[BB_LoginController alloc] init];
        RTRootNavigationController * nav = [[RTRootNavigationController alloc] initWithRootViewController:loginvc];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        return ;
    }else{
        if (block) {
            block();
        }
    }
}
- (void)presenLogin{
    BB_LoginController * loginvc = [[BB_LoginController alloc] init];
    RTRootNavigationController * nav = [[RTRootNavigationController alloc] initWithRootViewController:loginvc];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (BOOL)isLogin{
    return self.user.token.length;
}
- (void)clear{
    self.user.token = @"";
     [[AFHttpClient sharedClient].requestSerializer setValue:self.user.token forHTTPHeaderField:@"access_token"];
}
- (void)getCurretnCoinRich:(NSString *)coincode sucess:(void(^)(BB_AssetModel *assetModel))sucess{
        [BB_BasicHandle queryUserAssetsInfoSucess:^(id json) {
            for (BB_AssetModel *model in self.allRichArray) {
                if ([model.coincode isEqualToString:coincode]) {
                    sucess(model);
                }
            }
        } fail:^(id json) {
            
        }];
}

@end
