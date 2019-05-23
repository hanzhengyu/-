//
//  BB_HomeCell.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/6.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_HomeCell.h"
#import "BB_HomenUIModel.h"
@interface BB_HomeCell()
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end
@implementation BB_HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setListModel:(BB_RankListModel *)listModel{
    _listModel = listModel;
    self.coinNameLabel.text = [NSString stringWithFormat:@"%@/%@",[listModel.coincode uppercaseString],[listModel.gCoincode uppercaseString]];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld WCNY",listModel.newPrice];
    [self.priceLabel wl_changeFontWithTextFont:[UIFont fontWithName:@"PingFangSC-Medium" size:10] changeText:@"WCNY"];
    [self.priceLabel wl_changeColorWithTextColor:HexColor(@"666666") changeText:@"WCNY"];
    float i = [listModel.mchange floatValue];
    NSString *str = [NSString stringWithFormat:@"%.0f", i*100];
    self.stateLabel.text = [NSString stringWithFormat:@"%@%%",str];
    self.stateLabel.backgroundColor  = listModel.isReduce ? HexColor(@"F76A42") : HexColor(@"09C893");
    self.indexLabel.text = listModel.ranking;
}
- (void)layoutSubviews{
    [super layoutSubviews];
}
@end
