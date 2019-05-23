//
//  BB_IdnFailOrWaiteView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_IdnFailOrWaiteView.h"

@implementation BB_IdnFailOrWaiteView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews{
    _labe = [[UILabel alloc] init];
    _labe.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    _labe.textColor = HexColor(@"333333");
    _labe.numberOfLines = 0;
    _labe.textAlignment = NSTextAlignmentCenter;
    _labe.text = @"已提交正在等待审核";
    _loginBtn = [STUIKitTools buttonTitle:@"返回" font:18 action:nil titleColor:HexColor(@"ffffff") target:self];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [self addSubview:_loginBtn];
    [self addSubview:_labe];
    
    
    [_labe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-100);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-100);
        make.width.mas_equalTo(Ration(275));
        make.height.mas_equalTo(Ration(50));
        make.centerX.equalTo(self.mas_centerX);
    }];
}

@end
