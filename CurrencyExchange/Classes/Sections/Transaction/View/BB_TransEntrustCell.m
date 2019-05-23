//
//  BB_TransEntrustCell.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_TransEntrustCell.h"

@interface BB_TransEntrustCell()
@property (weak, nonatomic) IBOutlet UIImageView *empytImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLavel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
@implementation BB_TransEntrustCell

- (void)awakeFromNib {
    [super awakeFromNib];

}


- (IBAction)cancel:(UIButton *)sender {
    LRLog(@"我点击了");
    if (self.block) {
        self.block();
    }
}
- (void)setHistoryModel:(BB_EntrustHistoryModel *)historyModel{
    self.timeLabel.text = [historyModel.tradetime getDateStringWithTimeFormatter:@"yy:M:d HH:MM"];
    self.priceLavel.text = historyModel.price;
    self.typeLabel.text = historyModel.typeName;
    self.countLabel.text = historyModel.num;
    [self.cancelBtn bb_buttonNormalTitle:historyModel.statusname seletedTitle:@""];
    self.cancelBtn.enabled = historyModel.status = 0 ?  YES : NO;
    
}
- (void)setRecodeModel:(BB_EntrustmentRecordModel *)recodeModel{
    self.timeLabel.text = [recodeModel.tradetime getDateStringWithTimeFormatter:@"YY:MM:DD"];
    self.priceLavel.text = recodeModel.price;
    self.countLabel.text = recodeModel.num;
    [self.cancelBtn bb_buttonNormalTitle:@"撤销" seletedTitle:@"1"];
     self.empytImageView.hidden = USERMANNGER.isLogin;
}
- (void)updaEmpty{
    self.empytImageView.hidden = USERMANNGER.isLogin;
}
@end
