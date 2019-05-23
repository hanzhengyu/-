//
//  BB_NoticeCell.m
//  CurrencyExchange
//
//  Created by company on 2018/4/3.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_NoticeCell.h"

@implementation BB_NoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
    
        _title = [[UILabel alloc]init];
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(-10);
            make.left.mas_equalTo(30);
            make.right.mas_equalTo(-40);
        }];
        _title.font = [UIFont systemFontOfSize:15];
        _title.alpha = 0.7;
        _title.text = @"";
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"Switching"];
        [self.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(_title.mas_right).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(11, 20));
        }];
    }
    return self;
    
}

@end
