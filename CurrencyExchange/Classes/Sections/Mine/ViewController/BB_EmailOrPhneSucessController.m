//
//  BB_EmailOrPhneSucessController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/21.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_EmailOrPhneSucessController.h"

@interface BB_EmailOrPhneSucessController ()
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

@implementation BB_EmailOrPhneSucessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * imageName = self.type == SucessTypePhone ? @"Cellphone" : @"mailbox";
    self.imageView = [STUIKitTools imageView:imageName];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.text;
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    self.titleLabel.textColor = HexColor(@"333333");
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(SafeAreaTopHeight + 50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(25);
    }];
}

@end
