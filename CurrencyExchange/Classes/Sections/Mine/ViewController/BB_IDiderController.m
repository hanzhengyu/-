//
//  BB_IDiderController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_IDiderController.h"
#import "BB_PageView.h"
#import "BB_AssetSucessView.h"
#import "BB_CommitImageController.h"
#import "BB_IdnFailOrWaiteView.h"
@interface BB_IDiderController ()
@property (nonatomic, copy) NSString * accountStr;
@property (nonatomic, copy) NSString * pwdStr;
@property (nonatomic, strong) BB_AssetSucessView * sucessView;
@property (nonatomic, strong) BB_IdnFailOrWaiteView * faiWateView;
@end

@implementation BB_IDiderController
- (instancetype)init{
    if (self == [super init]) {
        self.status = IdenStatusNever;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份认证";
    [self setUpUI];
}
- (void)setUpUI{
    switch (self.status) {
        case IdenStatusNever:
        {
            [self naverId];
        }
            break;
        case IdenStatusSucess:
        {
            [self.view addSubview:self.sucessView];

        }
            break;
        case IdenStatusFail:
        {
            [self addFailWaiteView];
        }
            break;
        case IdenStatusWaite:
        {
            [self.view addSubview:self.faiWateView];
            _faiWateView.labe.text= @"您的信息已提交正在等待审核";
            [_faiWateView.loginBtn setTitle:@"返回" forState:UIControlStateNormal];
            _faiWateView.loginBtn.tag = IdenStatusWaite;
            [_faiWateView.loginBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        default:
            break;
    }

}
- (void)addFailWaiteView{
    [self.view addSubview:self.faiWateView];
    _faiWateView.labe.text= @"您的信息已被驳回，请重新提交";
    [_faiWateView.loginBtn setTitle:@"重新提交" forState:UIControlStateNormal];
    _faiWateView.loginBtn.tag = IdenStatusFail;
    [_faiWateView.loginBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [self.faiWateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
}
- (void)naverId{
    LRWeakSelf(self)
    CGRect rect = CGRectMake(0, self.navigationController.navigationBar.height + 36, SCREEN_WIDTH, 90);
    BB_PageView * accountView = [[BB_PageView alloc] initWithFrame:rect titles:@[@"姓名"]];
    accountView.pageType = PageViewDefault;
    accountView.textFieldType = TextFileLayerStyleLine;
    accountView.textBlock = ^(NSString *account) {
        weakself.accountStr = account;
    };
    [self.view addSubview:accountView];
    
    CGRect pwdRect = CGRectMake(0, accountView.maxY + 50, SCREEN_WIDTH, 90);
    BB_PageView * pwdView = [[BB_PageView alloc] initWithFrame:pwdRect titles:@[@"身份证号"]];
    pwdView.textFieldType = TextFileLayerStyleLine;
    pwdView.textBlock = ^(NSString *pwd) {
        weakself.pwdStr = pwd;
    };
    [self.view addSubview:pwdView];
    UIButton * loginBtn = [STUIKitTools buttonTitle:@"下一步" font:18 action:@selector(nextClick) titleColor:HexColor(@"ffffff") target:self];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(50,SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 157, SCREEN_WIDTH - 100, 50);
    [self.view addSubview:loginBtn];
}
- (void)nextClick{
    if (_accountStr == nil || _pwdStr == nil) {
        [UIAlertController Alert:self Tip:@"信息填写不全"];
    } else {
    BB_CommitImageController *commitVC = [[BB_CommitImageController alloc] init];
    commitVC.name = _accountStr;
    commitVC.idCard = _pwdStr;
    [self.navigationController pushViewController:commitVC animated:YES];
    }
}

- (BB_AssetSucessView *)sucessView{
    if (!_sucessView) {
        CGRect rect = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight);
        _sucessView = [[BB_AssetSucessView alloc] initWithFrame:rect];
    }
    return _sucessView;
}
- (BB_IdnFailOrWaiteView *)faiWateView{
    if (!_faiWateView) {
        CGRect rect = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, self.view.height - SafeAreaTopHeight - SafeAreaBottomHeight);
        _faiWateView = [[BB_IdnFailOrWaiteView alloc] initWithFrame:rect];
    }
    return _faiWateView;
}

-(void)next:(UIButton *)btn
{
    if (btn.tag == IdenStatusWaite) {
        [self pop];
    }
    if (btn.tag == IdenStatusFail) {
        [self.faiWateView removeFromSuperview];
        [self naverId];
    }
}
@end
