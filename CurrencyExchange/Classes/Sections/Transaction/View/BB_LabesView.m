//
//  BB_LabesView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_LabesView.h"
@interface BB_LabesView()
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSMutableArray * allLabel;
@end
@implementation BB_LabesView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles{
    if ( self == [super initWithFrame:frame]) {
        self.titles = titles;
        self.allLabel = [NSMutableArray array];
        [self addSubviews];
    }
    return self;
}
- (void)addSubviews{
    CGFloat w = self.width / self.titles.count;
    for (int i = 0; i < self.titles.count;i++) {
        UILabel * la = [UILabel new];
        la.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        la.textColor = HexColor(@"999999");
        la.text = self.titles[i];
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(w * i, 0, w, 32);
        [self addSubview:la];
        [self.allLabel addObject:la];
    }
}
- (void)setTextColor:(UIColor *)textColor{
    for (UILabel *la in self.allLabel) {
        la.textColor = textColor;
    }
}
@end
