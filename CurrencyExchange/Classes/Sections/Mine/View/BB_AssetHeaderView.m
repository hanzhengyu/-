//
//  BB_AssetHeaderView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_AssetHeaderView.h"

@interface BB_AssetHeaderView()
{
    UILabel *_moneyLabel;
}
@end

@implementation BB_AssetHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, SCREEN_WIDTH, 1)];
        line.backgroundColor = HexColor(@"DFDFDF");
        [self addSubview:line];
        UIView * backView = [[UIView alloc] init];
        backView.frame = CGRectMake(28, 0, SCREEN_WIDTH - 56, Ration(90));
        backView.backgroundColor = HexColor(@"376BA5");
        backView.layer.cornerRadius = 10;
        [self addSubview:backView];
        
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(24, 6, 200, Ration(80));
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
//        label.text = @"可用资产:---\n预估资产:---";
         label.text = @"可用资产:---";
        [label wl_changeLineSpaceWithTextLineSpace:10];
        label.numberOfLines = 2;
        [backView addSubview:label];
        _moneyLabel = label;
    }
    return self;
}

- (void)setTotalMoney:(NSString *)totoMoney canUseMoney:(NSString *)canUseMoney{
//    _moneyLabel.text = [NSString stringWithFormat:@"可用资产:%@\n预估资产:%@",canUseMoney, totoMoney];
      _moneyLabel.text = [NSString stringWithFormat:@"可用资产: %@",canUseMoney];
    [_moneyLabel wl_changeFontWithTextFont:[UIFont boldSystemFontOfSize:18] changeText:canUseMoney];
    
    [_moneyLabel wl_changeLineSpaceWithTextLineSpace:10];
    _moneyLabel.numberOfLines = 2;
}
@end
