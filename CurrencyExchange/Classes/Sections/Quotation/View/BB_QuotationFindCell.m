//
//  BB_QuotationFindCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/16.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_QuotationFindCell.h"
@interface BB_QuotationFindCell()
@property (weak, nonatomic) IBOutlet UILabel *coinNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation BB_QuotationFindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setListModel:(BB_RankListModel *)listModel{
    _listModel = listModel;
    self.coinNameLabel.text = [NSString stringWithFormat:@"%@%@/%@",[NSString stringWithNull:listModel.ranking],listModel.gCoincode,listModel.coincode];
    self.priceLabel.text = [NSString stringWithFormat:@"%ld",listModel.newPrice];
    self.arrowImageView.image = [UIImage imageNamed:listModel.imageName];
    self.stateLabel.text = [listModel.mchange stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.countLabel.text = listModel.volume;
}
@end
