//
//  BB_QuoDetailHeaderView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/24.
//  Copyright © 2018年 崔博. All rights reserved.
//

#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#import "BB_QuoDetailHeaderView.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "Y_StockChartView.h"
#import "Y_KLineGroupModel.h"
#import "UIColor+Y_StockChart.h"

@interface BB_QuoDetailHeaderView()<Y_StockChartViewDataSource>{
    UILabel * _priceLabel;
    UILabel * _countLabel;
    FSCustomButton * _uplowBtn;
}
@property (nonatomic, strong) Y_StockChartView *stockChartView;
@property (nonatomic, strong) Y_KLineGroupModel *groupModel;
@property (nonatomic, copy) NSMutableDictionary <NSString*, Y_KLineGroupModel*> *modelsDict;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) HMSegmentedControl * segmentControl;
@end
@implementation BB_QuoDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.gcode = @"";
        self.code = @"";
        self.currentIndex = -1;
        self.type = @"1m";
        [self addSubviews];
    }
    return self;
}
#pragma mark - method
- (void)addSubviews{
    FSCustomButton * btn = [FSCustomButton buttonWithType:UIButtonTypeCustom];
    btn.buttonImagePosition = FSCustomButtonImagePositionRight;
    [btn setTitle:@"--" forState:0];
    [btn bb_buttonNormaImage:@"arrow" seletedImage:@"arrow-green"];
    [btn setTitleColor:HexColor(@"F5F5F5") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:21];
    [self addSubview:btn];
    _uplowBtn = btn;
    UILabel * priceLabel = [self creatLabel];
  //  priceLabel.text = @"高：---\n低：---";
    [priceLabel wl_changeLineSpaceWithTextLineSpace:12];
    [self addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(10);
    }];
    _priceLabel = priceLabel;
    UILabel * countLabel = [self creatLabel];
    countLabel.text = @"幅：---\n量：---";
    [countLabel wl_changeLineSpaceWithTextLineSpace:12];
    [self addSubview:countLabel];
    _countLabel = countLabel;
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(61);
        make.centerY.equalTo(_priceLabel.mas_centerY);
    }];
    
//    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(priceLabel.mas_bottom).offset(10).priority(800);
//        make.left.mas_equalTo(0);
//        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(SCREEN_WIDTH / 7 * 5);
//    }];
    UIButton *minuteBtn = [self creeatBtnTitle:@"1分"];
    UIButton *indexBtn = [self creeatBtnTitle:@"指标"];
    [self addSubview:minuteBtn];
    [self addSubview:indexBtn];
    
    [self initKLintView];
}
- (void)initKLintView{
    [self addSubview:self.stockChartView];
}
-(id)stockDatasWithIndex:(NSInteger)index
{
    if (!(self.code.length && self.gcode.length)) {
        
        return nil;
    }
//    @param type 时间段(1m  3m  5m  10m  15m  30m  1h 2h 4h 6h 12h 1d 7d )
    NSString *type;
    switch (index) {
        case 0:
        {
            type = @"1m";
        }
            break;
        case 1:
        {
            type = @"1m";
        }
            break;
        case 2:
        {
            type = @"1m";
        }
            break;
        case 3:
        {
            type = @"3m";
        }
            break;
        case 4:
        {
            type = @"5m";
        }
            break;
        case 5:
        {
            type = @"10m";
        }
            break;
        case 6:
        {
            type = @"1h";
        }
            break;
        case 7:
        {
            type = @"4h";
        }
            break;
        case 8:
        {
            type = @"1d";
        }
            break;
        case 9:
        {
            type = @"7d";
        }
            break;
            
        default:
            break;
    }
    
    self.currentIndex = index;
    self.type = type;
    if(![self.modelsDict objectForKey:type])
    {
        [self reloadData];
    } else {
        return [self.modelsDict objectForKey:type].models;
    }
    return nil;
}

- (void)reloadData
{
    if (!(self.gcode.length && self.code.length)) {
        return ;
    }
    [BB_BasicHandle publicShowDate:self.code gCoincode:self.gcode type:self.type total:300 sucess:^(id json) {
        NSMutableArray *array = [NSMutableArray array];
       // NSLog(@"json===%@",json);
        [array addObjectsFromArray:json];
        if (array.count < 8) {
            return ;
        }
        LRLog(@"%@",array);
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:array];
        self.groupModel = groupModel;
        [self.modelsDict setObject:groupModel forKey:self.type];
        [self.stockChartView reloadData];
    } fail:^(id json) {
        
    }];
}
- (UILabel *)creatLabel{
    UILabel * label = [UILabel label];
    [label label:[UIFont fontWithName:@"PingFangSC-Light" size:13] text:@"" textColor:[UIColor whiteColor]];
    label.numberOfLines = 0;
    return label;
}
- (UIButton *)creeatBtnTitle:(NSString *)title{
    UIButton * btn = [UIButton bb_btn];
    UIFont * font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
    [btn bb_buttonNormalBackImage:@""
                  seletedBackImage:@""
                             title:title
                   normaltextColor:RGBColor(87, 107, 137)
                  seletedtextColor:HexColor(@"FFFFFF")
                              font:font];
    return btn;
}
#pragma mark - get set
- (Y_StockChartView *)stockChartView
{
    
//    时间段(1m  3m  5m  10m  15m  30m  1h 2h 4h 6h 12h 1d 7d )
    if(!_stockChartView) {
        _stockChartView = [Y_StockChartView new];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"3分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"5分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"10分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1h" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"4h" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周线" type:Y_StockChartcenterViewTypeKline]];
        _stockChartView.backgroundColor = RGBColor(21, 24, 28);
        _stockChartView.dataSource = self;
        [self addSubview:_stockChartView];
        [_stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.left.equalTo(self);
            make.top.equalTo(_priceLabel.mas_bottom);
        }];
    }
    return _stockChartView;
}
- (NSMutableDictionary<NSString *,Y_KLineGroupModel *> *)modelsDict
{
    if (!_modelsDict) {
        _modelsDict = @{}.mutableCopy;
    }
    return _modelsDict;
}
- (void)setListMoodel:(BB_RankListModel *)listMoodel{

    _listMoodel = listMoodel;
    [_uplowBtn bb_buttonNormaImage:listMoodel.imageName seletedImage:@""];
    
    float i = [listMoodel.mchange floatValue];
    NSString *str = [NSString stringWithFormat:@"%.0f", i*100];
    NSString * title = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [_uplowBtn setTitle:[NSString stringWithFormat:@"%@%%",title] forState:UIControlStateNormal];
    UIColor * upLowColor = listMoodel.isReduce ? RGBColor(247, 106, 66) : RGBColor(13, 193, 136);
    [_uplowBtn setTitleColor:upLowColor forState:0];
    _priceLabel.text = [NSString stringWithFormat:@"最高价：%@\n最低价：%@",[NSString stringWithNull:listMoodel.maxPrice],[NSString stringWithNull:listMoodel.minPrice]];
   // NSLog(@"==price==%@",listMoodel.maxPrice);
    [_priceLabel wl_changeLineSpaceWithTextLineSpace:12];
    _countLabel.text = [NSString stringWithFormat:@"幅：%@%%\n量：%@",[NSString stringWithNull:title],[NSString stringWithNull:listMoodel.volume]];
    [_countLabel wl_changeLineSpaceWithTextLineSpace:12];
    if (self.gcode.length && self.code.length) {
        [self reloadData];
    }
}
@end
