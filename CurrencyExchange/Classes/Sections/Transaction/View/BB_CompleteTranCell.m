//
//  BB_CompleteTranCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/4/7.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_CompleteTranCell.h"

@interface BB_CompleteTranCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
@implementation BB_CompleteTranCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RGBColor(58, 67, 90);
}

//@param format   String representing the desired date format.
//e.g. @"yyyy-MM-dd HH:mm:ss"
//
//@return NSString representing the formatted date string.
//*/
//- (nullable NSString *)stringWithFormat:(NSString *)format;
- (void)setModel:(BB_EntrustHistoryModel *)model{
    _model = model;
    self.timeLabel.text = [model.gettime getDateStringWithTimeFormatter:@"HH:MM:SS"];
    self.buyLabel.text = model.typeName;
    self.buyLabel.textColor = model.typeColor;
    self.priceLabel.text = model.price;
    self.countLabel.text = model.num;
}
@end
