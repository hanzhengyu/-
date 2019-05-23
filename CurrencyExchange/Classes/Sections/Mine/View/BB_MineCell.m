//
//  BB_MineCell.m
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/8.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_MineCell.h"
#import "BB_MineModel.h"
@interface BB_MineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BB_MineCell


-(void)setUIModel:(BB_BasicModel *)model{
    BB_MineModel *minmodel = (BB_MineModel *)model;
    self.iconImageView.image = [UIImage imageNamed:minmodel.imageName];
    self.titleLabel.text = minmodel.title;
}
@end
