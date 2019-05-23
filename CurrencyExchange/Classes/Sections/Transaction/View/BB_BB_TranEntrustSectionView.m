//
//  BB_BB_TranEntrustSectionView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_BB_TranEntrustSectionView.h"
#import "BB_LabesView.h"
#import "BB_EntrustmentRecordController.h"
@interface BB_BB_TranEntrustSectionView(){
    
    UIButton *_moreBnt;
    UIView *_line;
}

@end
@implementation BB_BB_TranEntrustSectionView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        line.backgroundColor = HexColor(@"F3F3F3");
        [self addSubview:line];
        _line = line;
        UILabel * la = [[UILabel alloc] init];
        la.frame = CGRectMake(22, 15, 92, 33);
        la.font = [UIFont fontWithName:@"PingFangSC-Medium" size:23];
        la.text = @"当前委托";
        la.textColor = HexColor(@"505187");
        [self addSubview:la];
        
        CGRect rect = CGRectMake(0, la.maxY + 10, SCREEN_WIDTH, 32);
        NSArray * titles = @[@"时间",@"交易类型",@"价格",@"数量",@"操作"];
        BB_LabesView * labsView  = [[BB_LabesView alloc] initWithFrame:rect titles:titles];
        [self addSubview:labsView];
        
        UIButton * btn = [STUIKitTools buttonImage:@"Buttons" action:@selector(more) target:self];
        btn.frame = CGRectMake(self.maxX - 40, 0, 25, 15);
        btn.centerY = la.centerY;
        [self addSubview:btn];
        _moreBnt = btn;
    }
    return self;
}
- (void)more{
    if (self.block) {
        self.block();
    }
}
- (void)setIsMore:(BOOL)isMore{
    _isMore = isMore;
    _moreBnt.hidden = !isMore;
    _line.hidden = YES;
}
@end
