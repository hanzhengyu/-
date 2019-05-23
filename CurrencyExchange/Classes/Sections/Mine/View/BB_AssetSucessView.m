//
//  BB_AssetSucessView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_AssetSucessView.h"

@interface BB_AssetSucessView()

@end

@implementation BB_AssetSucessView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {

        UILabel *nameLabel = [self creatLabeltext:@"username\n123455"];
        nameLabel.frame = CGRectMake(40, 17, SCREEN_WIDTH, 60);
        
        UILabel *idCardLabel = [self creatLabeltext:@"idCard\n1235"];
        idCardLabel.frame = CGRectMake(40, nameLabel.maxY + 25, SCREEN_WIDTH, 70);
        [BB_BasicHandle userInfo:^(id json) {
            nameLabel.text = [NSString stringWithFormat:@"username\n%@", json[@"username"]];
            idCardLabel.text = [NSString stringWithFormat:@"idcard\n%@", [json[@"idcard"]isEqualToString:@""] ? @"暂无":json[@"idcard"]] ;
            [self configLabel:nameLabel];
            [self configLabel:idCardLabel];
        } fail:^(id json) {

        }];
//        UILabel *idCardLabel = [self creatLabeltext:@"UID\n123456"];
//        idCardLabel.frame = CGRectMake(40, nameLabel.maxY + 45, SCREEN_WIDTH, 80);
        
       // [self addSubview:uidLabel];
        [self addSubview:nameLabel];
        [self addSubview:idCardLabel];
        
       // [self configLabel:uidLabel];
        
  
    }
    return self;
}

- (UILabel *)creatLabeltext:(NSString *)text{
    UILabel * label = [[UILabel alloc] init];
    label.text = text;
    label.numberOfLines = 2;
    return label;
}
- (void)configLabel:(UILabel *)label{
    NSArray * textArray = [label getLinesArrayOfStringInLabel];
    
        [label wl_changeFontWithTextFont:[UIFont fontWithName:@"PingFangSC-Light" size:19] changeText:textArray[0]];
        [label wl_changeFontWithTextFont:[UIFont fontWithName:@"PingFangSC-Medium" size:20] changeText:textArray[1]];

   
    [label wl_changeLineSpaceWithTextLineSpace:5];
    label.textAlignment = NSTextAlignmentLeft;
}
@end
