//
//  BB_safeCenterCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/21.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_safeCenterCell.h"
#import "BB_MineModel.h"
@interface BB_safeCenterCell()
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTiitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end
@implementation BB_safeCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
  //  self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
}
- (void)setUIModel:(BB_MineModel *)model{
    self.titileLabel.text = model.title;
    self.subTiitleLabel.text = [NSString stringWithNull:model.subTitle];
}
@end
