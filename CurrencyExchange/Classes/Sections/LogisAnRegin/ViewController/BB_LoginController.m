//
//  BB_LoginController.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/7.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_LoginController.h"
#import "BB_PageView.h"
#import "BB_RegisViewController.h"
#import "BB_SeetingTransPwdController.h"
@interface BB_LoginController (){
    BB_PageView * _accountView;
    BB_PageView * _pwdView;
    UIButton * _loginBtn;
}
@property (nonatomic, copy) NSString * accountStr;
@property (nonatomic, copy) NSString * pwdStr;
@property (nonatomic, assign) BOOL isCodeLogin; //
@end

@implementation BB_LoginController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.loginType = LoginTypeLogin;
        self.accountStr = @"";
        self.pwdStr = @"";
        self.isCodeLogin = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexColor(@"f2f2f2");
    [self setUpUI];
}
- (void)checktLoginBtn{
    _loginBtn.enabled =  self.accountStr.length && self.pwdStr.length ? YES : NO;
}
- (void)setUpUI{
    LRWeakSelf(self)
    UIButton * loginBtn = [UIButton bb_btnNorTitle:@"登录"];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn bb_buttonNormalBackImage:@"next" diasbleImage:@"nextc"];
    loginBtn.enabled = NO;
    loginBtn.frame = CGRectMake(50,SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 157, SCREEN_WIDTH - 100, 50);
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
    
    BB_PageView * accountView;
    CGRect rect = CGRectMake(0, self.navigationController.navigationBar.height + 36, SCREEN_WIDTH, 90);
    if (self.loginType == LoginTypeLogin) {
        UIButton * btn = [STUIKitTools buttonTitle:@"注册" font:18 action:@selector(regis) titleColor:[UIColor blackColor] target:self];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        accountView =  [[BB_PageView alloc] initWithFrame:rect titles:@[@"用户名"]];
        accountView.pageType = PageViewDefault;
        accountView.placeHoder = @"请输入手机号/邮箱/用户名";
    }
    
    accountView.textBlock = ^(NSString *account) {
        [self checktLoginBtn];
        weakself.accountStr = account;
    };
    [self.view addSubview:accountView];
    _accountView = accountView;
    CGRect pwdRect = CGRectMake(0, accountView.maxY + 50, SCREEN_WIDTH, 90);
    BB_PageView * pwdView ;
    if (self.loginType == LoginTypeLogin) {
        pwdView = [[BB_PageView alloc] initWithFrame:pwdRect titles:@[@"请输入密码"]];
        pwdView.isScretBtn = YES;
        pwdView.pageType = PageViewDefault;
        pwdView.placeHoder = @"请输入密码";
    }
    pwdView.textBlock = ^(NSString *pwd) {
        [self checktLoginBtn];
        weakself.pwdStr = pwd;
    };
    
  
    pwdView.codeblock = ^{
        if ([self.accountStr validateContactNumber]) {
            [BB_BasicHandle sendVercodePhone:self.accountStr sendType:@"1"  sucess:^(id json) {
                // weakself.accountStr
            } fail:^(id json) {
                
            }];
        }else{
            [HUDTools shoInfoWithStatus:@"请输入正确的手机号"];
        }
    };
    [self.view addSubview:pwdView];
    _pwdView = pwdView;
    
    UIButton * otherLoginBtn = [STUIKitTools buttonTitle:@"验证码登录" font:19 action:@selector(changeLogin:) titleColor:HexColor(@"333333") target:self];
    otherLoginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:19];
    otherLoginBtn.frame = CGRectMake(0, loginBtn.maxY + 3, 0, 0);
    LRLog(@"%f",self.view.centerX);
    [otherLoginBtn sizeToFit];
    otherLoginBtn.centerX = self.view.centerX;
    [self.view addSubview:otherLoginBtn];
    
}
- (void)changeLogin:(UIButton *)sender{
    if ([sender.titleLabel.text isEqualToString:@"验证码登录"]) {
        [sender setTitle:@"用户名登录" forState:0];
        _accountView.placeHoder = @"请输入手机号码";
        _pwdView.placeHoder = @"请输入验证码";
        _pwdView.codeHidden = NO;
        _pwdView.isScretBtn = NO;
        self.isCodeLogin = YES;
    }else{
        [sender setTitle:@"验证码登录" forState:0];
        _accountView.placeHoder = @"请输入手机号/邮箱/用户名";
        _pwdView.placeHoder = @"请输入密码";
        _pwdView.codeHidden = YES;
        _pwdView.isScretBtn = YES;
        self.isCodeLogin = NO;
    }
    [_accountView clear];
    [_pwdView clear];
}
- (void)login{
    if (![self.accountStr validateContactNumber]) {
        [HUDTools shoInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    if (self.accountStr.length && self.pwdStr.length) {
        if (!self.isCodeLogin) {
            [BB_BasicHandle loginTokenUsername:self.accountStr password:self.pwdStr sucess:^(id json) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } fail:^(id json) {
                
            }];
            
        }else{
            [BB_BasicHandle pcodeTokenPhone:self.accountStr pcode:self.pwdStr sucess:^(id json) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } fail:^(id json) {
                
            }];
        }
    }else{
        [HUDTools shoInfoWithStatus:@"请输入用户名或者密码"];
    }
}
- (void)regis{
    BB_RegisViewController * regis = [[BB_RegisViewController alloc] init];
    [self.navigationController pushViewController:regis animated:YES];
}
- (void)pop{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
