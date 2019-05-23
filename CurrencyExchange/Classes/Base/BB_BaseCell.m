//
//  BB_BaseCell.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/15.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BB_BaseCell.h"

@implementation BB_BaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super initWithCoder:aDecoder]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)awakeFromNib{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [super awakeFromNib];
}

- (void)setUIModel:(BB_BasicModel *)model{
    
}
@end
