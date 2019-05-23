//
//  BB_TransHeaderCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_TransHeaderCell.h"
#import "BB_HomenUIModel.h"
@interface BB_TransHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *pankouLabel;

@property (weak, nonatomic) IBOutlet UILabel *pricelLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation BB_TransHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pankouLabel.text = @"5";
    self.pricelLabel.text = @"6.21";
    self.countLabel.text = @"100";
}
- (void)setUIModel:(BB_BasicModel *)model{
    BB_HomenUIModel * m =(BB_HomenUIModel *)model;
    self.pankouLabel.textColor = m.textColor;
    self.pricelLabel.textColor = m.textColor;
    self.countLabel.textColor = m.textColor;
}
- (void)setSellModel:(BB_SellAndBuyModel *)sellModel{
    _sellModel = sellModel;
    _pankouLabel.text = @"";
    float price = [sellModel.price floatValue];
    _pricelLabel.text =[NSString stringWithFormat:@"%.2lf", price];
    _countLabel.text = sellModel.num;
    _pankouLabel.text = sellModel.index;
}
@end
