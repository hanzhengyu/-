//
//  BB_HomeHeaderView.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/7.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_HomeHeaderView.h"
#import <JhtMarquee/JhtVerticalMarquee.h>
#import <JhtMarquee/JhtHorizontalMarquee.h>
#import "BB_BannerListModel.h"
#import "BB_NoticeViewController.h"
@interface BB_HomeHeaderView()<SDCycleScrollViewDelegate>{
    // 水平滚动的跑马灯
    JhtHorizontalMarquee *_horizontalMarquee;
}
@property (nonatomic, strong) SDCycleScrollView * sdCycleView;
@property (nonatomic, strong) NSMutableArray * imagesList;
@property (nonatomic, strong) NSArray <BB_BannerListModel *>* modelsArray;
@end
@implementation BB_HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}
#pragma mark - delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    BasiWebViewController *web = [[BasiWebViewController alloc] init];
    web.url = self.modelsArray[index].href;
    [self.viewController.navigationController pushViewController:web animated:YES];
}
#pragma mark - method
//- (void)leftImage{
//    // 回去
//    [self.sdCycleView makeScrollViewScrollToIndex:1];
//}
//- (void)rightImage{
//    // 回去
//    [self.sdCycleView makeScrollViewScrollToIndex:0];
//}
- (void)addSubviews{
//    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftbtn setBackgroundImage:[UIImage imageNamed:@"back-black"] forState:0];
//    [leftbtn addTarget:self action:@selector(leftImage) forControlEvents:UIControlEventTouchUpInside];
//    UIButton * righbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [righbtn setBackgroundImage:[UIImage imageNamed:@"back-black"] forState:0];
//    [righbtn addTarget:self action:@selector(rightImage) forControlEvents:UIControlEventTouchUpInside];
//    righbtn.transform = CGAffineTransformMakeRotation(M_PI);
    
    UIImageView * hornImageView = [STUIKitTools imageView:@"laba"];
    UILabel * label = [STUIKitTools lableFont:18 textColor:HexColor(@"333333")];
    label.text = @"排行榜";
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    
    [self addSubview:self.sdCycleView];
//    [self addSubview:leftbtn];
//    [self addSubview:righbtn];
    [self addSubview:hornImageView];
    [self addSubview:label];
    
    [self.sdCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(0);
        make.height.mas_equalTo(Ration(165));
    }];
//    [leftbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.sdCycleView.mas_centerY);
//        make.left.mas_equalTo(12);
//        make.width.mas_equalTo(17);
//        make.height.mas_equalTo(30);
//    }];
//
//    [righbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.sdCycleView.mas_centerY);
//        make.right.mas_equalTo(-12);
//        make.width.mas_equalTo(17);
//        make.height.mas_equalTo(30);
//    }];
//
    [hornImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(14);
        make.top.equalTo(self.sdCycleView.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sdCycleView.mas_bottom).offset(32);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.bottom.equalTo(self.mas_bottom).offset(0).priority(750);
    }];
    
    [self layoutIfNeeded];
    CGRect rect = CGRectMake(hornImageView.maxX + 5, 0, SCREEN_WIDTH - hornImageView.maxX - 11, 20);
    _horizontalMarquee = [[JhtHorizontalMarquee alloc]  initWithFrame:rect withSingleScrollDuration:5];
    _horizontalMarquee.centerY = hornImageView.centerY;
    _horizontalMarquee.text = @"玩家网公告中心";
    _horizontalMarquee.textColor = HexColor(@"666666");
    _horizontalMarquee.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [self addSubview:_horizontalMarquee];
    
    UITapGestureRecognizer *htap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalMarqueeTapGes:)];
    [_horizontalMarquee addGestureRecognizer:htap];
}
- (void)horizontalMarqueeTapGes:(UITapGestureRecognizer *)ges{
    BB_NoticeViewController * vc = [[BB_NoticeViewController alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}
- (void)setImageUrls:(NSArray *)imagesUrls{
    self.modelsArray = imagesUrls;
    _imagesList = [NSMutableArray array];
    [imagesUrls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BB_BannerListModel * mode = obj;
        
        [_imagesList addObject:mode.imgurl];
    }];
    self.sdCycleView.imageURLStringsGroup = _imagesList;
}
- (SDCycleScrollView *)sdCycleView{
    if (!_sdCycleView) {
        _sdCycleView = [[SDCycleScrollView alloc] init];
        _sdCycleView.localizationImageNamesGroup = @[@"Personal",@"Personal",@"Personal"];
        _sdCycleView.autoScrollTimeInterval = 3;
        _sdCycleView.showPageControl = NO;
        _sdCycleView.delegate = self;
    }
    return _sdCycleView;
}
@end
