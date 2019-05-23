//
//  BB_SeetingTransPwdController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//
 NSString const * C_Account = @"Account";
 NSString const * C_Pwd = @"pwd";
 NSString const * C_Code = @"code";

#import "BB_SeetingTransPwdController.h"
#import "BB_PageView.h"
#import "BB_registerSuccesViewController.h"
@interface BB_SeetingTransPwdController ()
@property (nonatomic, copy) NSString * transPwd;
@end

@implementation BB_SeetingTransPwdController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transPwd = @"";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}
- (void)setUpUI{
     CGRect rect = CGRectMake(0, self.navigationController.navigationBar.height + 36, SCREEN_WIDTH, 90);
    BB_PageView *tranPwd = [[BB_PageView alloc] initWithFrame:rect titles:@[@"请设置支付密码"]];
    tranPwd.pageType = 0;
    tranPwd.placeHoder = @"6-16位数字或字母";
    tranPwd.textBlock = ^(NSString *text) {
        self.transPwd = text;
    };
    tranPwd.textFieldType = TextFileLayerStyleLine;
    [self.view addSubview:tranPwd];
    
    UIButton * loginBtn = [STUIKitTools buttonTitle:@"提交" font:18 action:@selector(login) titleColor:HexColor(@"ffffff") target:self];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(50,SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 157, SCREEN_WIDTH - 100, 50);
    [self.view addSubview:loginBtn];
}
- (void)login{
    if ((self.transPwd.length < 6)||(self.transPwd.length > 16)) {
        [HUDTools shoInfoWithStatus:@"请输入6-16位数字或字母"];
        return;
    }
    // 设置交易密码
    [BB_BasicHandle regisUser:self.userInfo[C_Account] regcode:self.userInfo[C_Code] pswd:self.userInfo[C_Pwd] payPswd:self.transPwd sucess:^(id json) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^(id json) {
        
    }];
}

@end
