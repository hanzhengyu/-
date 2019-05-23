//
//  BB_MineHeaderView.m
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/8.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_MineHeaderView.h"
#import "BB_LoginController.h"

@interface BB_MineHeaderView()
{
    UIButton *_loginBtn;
}
@end

@implementation BB_MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
- (void)login{
    [USERMANNGER presenLogin];
}
- (void)addSubviews{
    
    UIView * lin = [[UIView alloc] init];
    lin.backgroundColor = HexColor(@"DFDFDF");
    
    UIImageView * headerImageView = [STUIKitTools imageView:@"head"];

    UIButton * loginBtn = [STUIKitTools buttonTitle:@"登录/注册" font:18 action:@selector(login) titleColor:HexColor(@"3C4556") target:self];
    
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:24];
    _loginBtn = loginBtn;
    
    UILabel * lable = [STUIKitTools lableFont:16 textColor:[UIColor blackColor]];
    [self addSubview:headerImageView];
    [self addSubview:loginBtn];
    [self addSubview:lable];

//    [self addSubview:lin];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(120);
        make.width.height.mas_equalTo(30);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerImageView.mas_right).offset(12);
        make.centerY.equalTo(headerImageView.mas_centerY);
        make.height.mas_equalTo(33);
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom);
        make.left.equalTo(loginBtn.mas_left);
        make.height.mas_equalTo(22);
    }];
}
- (void)setIslogin:(BOOL)islogin{
    _islogin = islogin;
    _loginBtn.enabled = !islogin;
    [_loginBtn setTitle:USERMANNGER.user.username forState:UIControlStateDisabled];
}
@end
