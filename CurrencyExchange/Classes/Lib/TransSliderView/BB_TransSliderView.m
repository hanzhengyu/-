//
//  BB_TransSliderView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/15.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_TransSliderView.h"

@interface BB_TransSliderView()
{
    UIView* _v;
    UIView * _pointviw;
}
@property (nonatomic, strong) NSMutableArray * viewsArray;
@property (nonatomic, assign) int currentIndex;
@end
@implementation BB_TransSliderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.progressColor = HexColor(@"09C893");
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        self.viewsArray = [NSMutableArray array];
        self.pointCount = 5;
        CGRect linViewrect = CGRectMake(0, 10, 160, 2);
        UIView * linView = [[UIView alloc] initWithFrame:linViewrect];
        linView.backgroundColor = HexColor(@"EAEAEA");
        [self addSubview:linView];
        // 创建 pointviw
        UIView *pointviw = [UIView new];
        pointviw.backgroundColor = HexColor(@"09C893");
        pointviw.frame = CGRectMake(0, 10, 0, 2);
        pointviw.centerY = self.centerY;
        [self addSubview:pointviw];
        _pointviw = pointviw;
        linView.centerY = pointviw.centerY;
        CGFloat wh = 10;
        for (int i = 0; i < self.pointCount; i++) {
            UIImageView * v = [UIImageView new];
            v.backgroundColor = HexColor(@"EAEAEA");
            v.tag = 1000 + i;
            v.layer.cornerRadius = 5;
            v.userInteractionEnabled = YES;
            v.frame = CGRectMake(160 / 4 * i, 10, wh, wh);
            [self addSubview:v];
            [self.viewsArray addObject:v];
            v.centerY = pointviw.centerY;
        }
        
        CGRect rect = CGRectMake(0, 10, 20, 20);
        UIView * vi = [[UIView alloc] initWithFrame:rect];
        vi.backgroundColor = HexColor(@"09C893");
        UIPanGestureRecognizer *get = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ges:)];
        [vi addGestureRecognizer:get];
        vi.centerY = pointviw.centerY;
        vi.layer.cornerRadius = 10;
        _v = vi;
        [self addSubview:vi];
    }
    return self;
}

- (BOOL)isContanisPoint:(CGPoint)point{
    BOOL isContais = YES;
    for (UIImageView *imgView in self.viewsArray) {
        if (CGRectContainsPoint(imgView.frame, point)) {
            self.currentIndex = imgView.tag;
            isContais = YES;
            break ;
        }else{
            isContais = NO;
        }
    }
    return isContais;
}
- (void)tap:(UIGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self];
    [self updatePoint:point];
}
- (void)updatePoint:(CGPoint)point{
  
    if (point.x > self.width) {
        point.x = self.width;
    }
    if (point.x < 0) {
        point.x = 0;
    }
    _v.centerX = point.x;
    _pointviw.width = point.x;
    if ([self isContanisPoint:point]) {
        // 如果包含这个点
        [self refreshImageViewIndex:self.currentIndex - 1000];
        if (self.block) {
            self.block((self.currentIndex - 1000) * 0.25);
        }
    }else{
        LRLog(@"我不包含---%d",[self coluIndexPoinX:point.x]);
        // 不包含这个点
        [self refreshImageViewIndex:[self coluIndexPoinX:point.x]];
        if (self.block) {
            self.block(point.x / self.width);
        }
    }
}
- (void)ges:(UIGestureRecognizer *)ges{
    CGPoint point = [ges locationInView:self];
    [self updatePoint:point];
}
- (void)refreshImageViewIndex:(NSInteger)index{
    for (int i = 0; i <= index; i++) {
        UIImageView *v = self.viewsArray[i];
        v.backgroundColor = self.progressColor;
    }
    for (int i = self.pointCount - 1; i > index; i--) {
        UIImageView *v = self.viewsArray[i];
        v.backgroundColor = HexColor(@"EAEAEA");
    }
}
- (int)coluIndexPoinX:(CGFloat)pointx{
    return (int)pointx / 50;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    for (UIView * v in self.subviews) {
        v.y = (self.height - v.height) / 2;
    }
}
- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    _pointviw.backgroundColor = progressColor;
    _v.backgroundColor = progressColor;
}
- (void)clear{
    CGPoint point = CGPointMake(0, 0);
    [self updatePoint:point];
}
@end
