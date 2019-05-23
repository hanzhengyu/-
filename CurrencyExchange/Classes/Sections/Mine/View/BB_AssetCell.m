//
//  BB_AssetCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_AssetCell.h"
@interface BB_AssetCell ()
@property (weak, nonatomic) IBOutlet UILabel *coinName;
@property (weak, nonatomic) IBOutlet UILabel *availableCoin;
@property (weak, nonatomic) IBOutlet UILabel *freezeCoin;

@end
@implementation BB_AssetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setPersonModel:(BB_AssetModel *)personModel
{
    _personModel = personModel;
    self.coinName.text = [NSString stringWithFormat:@"%@",[personModel.coincode uppercaseString]];
    self.availableCoin.text = [NSString stringWithFormat:@"%ld\n可用", personModel.num];
    self.freezeCoin.text = [NSString stringWithFormat:@"%ld\n冻结", personModel.numd];
    [self.freezeCoin wl_changeFontWithTextFont:[UIFont systemFontOfSize:12] changeText:@"冻结"];
    [self.availableCoin wl_changeFontWithTextFont:[UIFont systemFontOfSize:12] changeText:@"可用"];
    [self.freezeCoin wl_changeColorWithTextColor:[UIColor lightGrayColor] changeText:@"冻结"];
    [self.availableCoin wl_changeColorWithTextColor:[UIColor lightGrayColor] changeText:@"可用"];
}


@end
