//
//  BB_registerSuccesViewController.m
//  CurrencyExchange
//
//  Created by company on 2018/4/25.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_registerSuccesViewController.h"

@interface BB_registerSuccesViewController ()

@end

@implementation BB_registerSuccesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubView];
}

-(void)addSubView
{
    UILabel *success = [STUIKitTools labelFont:18];
    success.text = @"注册成功";
    success.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:success];
    __weak typeof(self)ws = self;
    [success mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.view).with.offset(SCREEN_HEIGHT/2-80);
        make.size.mas_equalTo(CGSizeMake(145, 50));
        
    }];
    success.textAlignment = NSTextAlignmentCenter;
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
        loginBtn = [UIButton bb_btnNorTitle:@"立即登录"];
  
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn bb_buttonNormalBackImage:@"next" diasbleImage:@"nextc"];
    loginBtn.enabled = YES;
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(success).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
}

-(void)login{
     [USERMANNGER presenLogin];
}



@end
