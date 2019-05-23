//
//  BB_DataEmptyView.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/27.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BB_DataEmptyView.h"
@interface BB_DataEmptyView(){
    UILabel * _titleLabel;
}
@end
@implementation BB_DataEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = BACKGROUNDCOLOR;
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"group23"]];
        UILabel * titleLable = [STUIKitTools lableFont:18 textColor:HexColor(@"666666") text:@"空空如也\n点击右上角”+“创建你的还款计划"];
        titleLable.numberOfLines = 2;
        [titleLable wl_changeColorWithTextColor:HexColor(@"999999") changeText:@"点击右上角”+”创建你的还款计划吧"];
        [titleLable wl_changeFontWithTextFont:[UIFont systemFontOfSize:14] changeText:@"点击右上角”+“创建你的还款计划"];
        [titleLable wl_changeLineSpaceWithTextLineSpace:10];
        titleLable.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel = titleLable;
        [self addSubview:imageView];
        [self addSubview:titleLable];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.mas_equalTo(Ration(120));
        }];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(10);
        }];
    }
    return self;
}

@end
