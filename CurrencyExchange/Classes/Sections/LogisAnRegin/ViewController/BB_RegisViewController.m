//
//  BB_RegisViewController.m
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/9.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_RegisViewController.h"
#import "BB_PageView.h"
#import "BB_SeetingTransPwdController.h"
@interface BB_RegisViewController(){
    UIButton *_loginBtn;
}
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *code;
@end

@implementation BB_RegisViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = ChangeTypeRegis;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.account = @"";
    self.pwd = @"";
    self.code = @"";
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)setUpUI{
    LRWeakSelf(self)
    NSString  *title = @"";
    CGRect rect = CGRectMake(0, self.navigationController.navigationBar.height + 36, SCREEN_WIDTH, 90);
    BB_PageView * accountView;
    if (self.type == ChangeTypeRegis) {
        title = @"注册";
        accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"手机号注册"]];
        accountView.placeHoder = @"请输入手机号";
        accountView.codeHidden = NO;
        accountView.codeblock = ^{
            [BB_BasicHandle sendVercodePhone:self.account sendType:@"0"  sucess:^(id json) {
               
            } fail:^(id json) {
                
            }];
        };
        
    }else if (self.type == ChangeTypeLoginPwd){
        title = @"修改登录密码";
        accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"手机号"]];
        accountView.placeHoder = @"请输入手机号码";
        
    }else if (self.type == ChangeTypePayPwd){
        title = @"修改支付密码";
        accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"手机号"]];
        accountView.placeHoder = @"请输入手机号";
        
    }else if (self.type == ChangeTypeBlindEmail){
        title = @"绑定邮箱";
        accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"邮箱"]];
        accountView.placeHoder = @"请输入邮箱";
        accountView.pageType = 0;
        accountView.codeHidden = NO;
        accountView.codeblock = ^{
            if (![self.account isValidateEmail]) {
                [HUDTools shoInfoWithStatus:@"请输入正确的邮箱"];
                return ;
            }
            [BB_BasicHandle sendEmailVercode:self.account sendType:@"0" sucess:^(id json) {
                 [HUDTools shoInfoWithStatus:@"发送成功"];
            } fail:^(id json) {
                
            }];
        };
        
    }else if (self.type == ChangeTypeBlindPhone){
        title = @"绑定手机";
        accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"手机号"]];
        accountView.placeHoder = @"请输入绑定手机号";
    }
    
    accountView.textBlock = ^(NSString *text) {
        self.account = text;
        [self checktLoginBtn];
    };
    [self.view addSubview:accountView];
    self.navigationItem.title = title;
    
//    更换手机验证码 [1更换登录密码，2更换交易密码，3绑定银行卡，4绑定钱包验证码]
    CGRect pwdRect = CGRectMake(0, accountView.maxY + 50, SCREEN_WIDTH, 90);
    BB_PageView * codeView = [[BB_PageView alloc] initWithFrame:pwdRect titles:@[@"验证码"]];;
    if (self.type == ChangeTypeRegis) {
        codeView.placeHoder = @"请输入验证码";
    }else if (self.type == ChangeTypeLoginPwd){
        codeView.placeHoder =@"请输入验证码";
        codeView.codeHidden = NO;
        codeView.textFieldType = TextFileLayerStyleLine;
        codeView.codeblock = ^{
            [BB_BasicHandle secretSendVercode:weakself.account sendType:@"1" sucess:^(id json) {
                
                
            } fail:^(id json) {
                
            }];
        };
    }else if (self.type == ChangeTypePayPwd){
        codeView.placeHoder = @"";
        codeView.codeHidden = NO;
        codeView.textFieldType = TextFileLayerStyleLine;
        codeView.codeblock = ^{
            [BB_BasicHandle secretSendVercode:weakself.account sendType:@"2" sucess:^(id json) {
                
            } fail:^(id json) {
                
            }];
        };
    }else if (self.type == ChangeTypeBlindEmail){
        codeView.placeHoder = @"";
        codeView.codeHidden = YES;
        codeView.textFieldType = TextFileLayerStyleLine;
    }else if (self.type == ChangeTypeBlindPhone){
        codeView.placeHoder = @"";
        codeView.codeHidden = NO;
        codeView.codeblock = ^{
            [BB_BasicHandle secretSendVercode:self.account sendType:@"0" sucess:^(id json) {
                [HUDTools shoInfoWithStatus:@"发送成功"];
            } fail:^(id json) {
                
            }];
        };
    }
    codeView.textFieldType = TextFileLayerStyleLine;
    codeView.textBlock = ^(NSString *text) {
        self.code = text;
        [self checktLoginBtn];
    };
    [self.view addSubview:codeView];
    
    CGRect codeRect = CGRectMake(0, codeView.maxY + 50, SCREEN_WIDTH, 90);
    BB_PageView * pwdView = [[BB_PageView alloc] initWithFrame:codeRect titles:@[@"密码"]];
    pwdView.pageType = 0;
    if (self.type == ChangeTypeRegis) {
        pwdView.placeHoder = @"请输入密码";
        pwdView.isScretBtn = YES;
    }else if (self.type == ChangeTypeLoginPwd){
        pwdView.placeHoder = @"请输入密码";
        pwdView.textFieldType = TextFileLayerStyleLine;
 
    }else if (self.type == ChangeTypePayPwd){
        pwdView.placeHoder = @"";
        pwdView.textFieldType = TextFileLayerStyleLine;
        pwdView.codeblock = ^{
            [BB_BasicHandle secretSendVercode:weakself.account sendType:@"2" sucess:^(id json) {
                
            } fail:^(id json) {
                
            }];
        };
    }else{
        pwdView.placeHoder = @"请输入交易密码";
        pwdView.textFieldType = TextFileLayerStyleLine;
        pwdView.isScretBtn = YES;
    }
    pwdView.textBlock = ^(NSString *text) {
        self.pwd = text;
        [self checktLoginBtn];
    };
    [self.view addSubview:pwdView];
    
    UIButton * loginBtn = [STUIKitTools buttonTitle:@"下一步" font:18 action:@selector(regis) titleColor:HexColor(@"ffffff") target:self];
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    loginBtn.enabled = NO;
    [loginBtn bb_buttonNormalBackImage:@"next" diasbleImage:@"nextc"];
    loginBtn.frame = CGRectMake(50,codeView.maxY + 50+90+40, SCREEN_WIDTH - 100, 50);
    [self.view addSubview:loginBtn];
    _loginBtn = loginBtn;
}
- (void)regis{
    if (self.type == ChangeTypeRegis) {
        [self reigsUser];
    }else if (self.type == ChangeTypeLoginPwd){
        [self loginPwdUser];
    }else if (self.type == ChangeTypePayPwd){
        [self changePayPwd];
    }if (self.type == ChangeTypeBlindEmail){
        // 绑定邮箱
        [self blineEmai];
    }if (self.type == ChangeTypeBlindPhone){
        // 绑定手机号
        [self blindPhone];
    }
}
// 绑定
- (void)blineEmai{
    if (![self.account isValidateEmail]) {
        [HUDTools shoInfoWithStatus:@"请输入正确的邮箱"];
        return ;
    }
    [BB_BasicHandle updateEmail:self.account ecode:self.code payPswd:self.pwd sucess:^(id json) {
        USERMANNGER.user.email = self.account;
        if (self.block) {
            self.block();
        }
        [self pop];
    } fail:^(id json) {
        
    }];
}
- (void)checktLoginBtn{
    _loginBtn.enabled =  self.account.length && self.pwd.length && self.code.length ? YES : NO;
}
- (void)blindPhone{
    if (![self.account validateContactNumber]) {
        [HUDTools shoInfoWithStatus:@"请输入正确的手机号"];
        return ;
    }
    [BB_BasicHandle updateMobile:self.account upcode:self.code payPswd:self.pwd sucess:^(id json) {
         [HUDTools shoInfoWithStatus:@"绑定成功"];
        USERMANNGER.user.mobile = self.account;
        if (self.block) {
            self.block();
        }
        [self pop];
    } fail:^(id json) {
        
    }];
}
- (void)changePayPwd{
    [BB_BasicHandle updatePayPswd:self.pwd repeatPswd:self.pwd upcode:self.code sucess:^(id json) {
        [self pop];
    } fail:^(id json) {
        
    }];
}
//更改登录密码
-(void)loginPwdUser
{
    if (self.pwd.length && self.account.length && self.code.length) {
        BB_SeetingTransPwdController * set = [[BB_SeetingTransPwdController alloc] init];
        set.userInfo = @{C_Account:self.account,
                         C_Code:self.code,
                         C_Pwd:self.pwd
                         };
        [BB_BasicHandle updateLoginPswd:self.pwd repeatPswd:self.pwd upcode:self.code sucess:^(id json) {
            [HUDTools shoInfoWithStatus:@"密码修改成功"];
            [self pop];
        } fail:^(id json) {
            
        }];
    }else{
        [HUDTools shoInfoWithStatus:@"请输入手机号密码"];
    }
}

- (void)reigsUser{
    if (self.pwd.length && self.account.length && self.code.length) {
        BB_SeetingTransPwdController * set = [[BB_SeetingTransPwdController alloc] init];
        set.userInfo = @{C_Account:self.account,
                         C_Code:self.code,
                         C_Pwd:self.pwd
                         };
        [self.navigationController pushViewController:set animated:YES];
    }else{
        [HUDTools shoInfoWithStatus:@"请输入手机号或密码"];
    }
}
@end
