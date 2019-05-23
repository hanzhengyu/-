//
//  BB_BuyInOrOutView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/23.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BuyInOrOutView.h"

@implementation BB_BuyInOrOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexColor(@"3C4556");
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    UIButton * buyIn = [self creatBtnTitle:@"卖出" hex:@"F76A42"];
    buyIn.tag = 100;
    UIButton * buyOut = [self creatBtnTitle:@"买入" hex:@"0CC188"];
    buyOut.tag = 101;
    [self addSubview:buyIn];
    [self addSubview:buyOut];
    
    [buyIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(21);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(30);
        make.right.equalTo(self.mas_centerX).offset(-21);
    }];
    
    [buyOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-21);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.mas_centerX).offset(21);
    }];
}
- (void)pop:(UIButton *)sender{
    if (self.block) {
        self.block(sender.tag);
    }
}
- (UIButton *)creatBtnTitle:(NSString *)title hex:(NSString *)hex{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [btn setTitle:title forState:0];
    btn.backgroundColor = HexColor(hex);
    [btn setTitleColor:HexColor(@"F5F5F5") forState:0];
    [btn addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
