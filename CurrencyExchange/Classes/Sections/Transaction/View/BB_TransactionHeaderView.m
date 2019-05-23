//
//  BB_TransactionHeaderView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/13.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_TransactionHeaderView.h"
#import "BB_TransHeaderCell.h"
#import "BB_HomenUIModel.h"
#import "BB_LabesView.h"
#import "BB_TransSliderView.h"
#import "BB_CountTextView.h"
@interface BB_TransactionHeaderView()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel *_canUseLabel;
    UILabel *_choseCoinLabel;
    UILabel *_transLabel;
    UIButton * _transBtn;
    BB_TransSliderView * _sliderView;
    BB_CountTextView * _priceTextViw;
    BB_CountTextView * _countTextViw;
}
@property (nonatomic, strong) UIView *linView;
@property (nonatomic, assign) BOOL isBuyin;
@property (nonatomic, strong) BB_BasicTableView *tableView;
@end
@implementation BB_TransactionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.type = @"0";
        [self addSubviews];
        self.isBuyin = YES;
        self.num = @"0.00";
        self.price = @"0.0000";
    }
    return self;
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger sellCount = self.model.sellList.count > 5 ? 5 : self.model.sellList.count;
    NSInteger buyCount = self.model.buyList.count > 5 ? 5 : self.model.buyList.count;
    return section == 0 ? sellCount : buyCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_HomenUIModel * model = [[BB_HomenUIModel alloc] init];
    model.textColor = indexPath.section == 0 ? HexColor(@"F76A42") : HexColor(@"09C893");
    
    NSArray * dataArray = indexPath.section == 0 ? self.model.sellList : self.model.buyList;
    BB_SellAndBuyModel * listModel = dataArray[indexPath.row];
    NSInteger index;
    if (indexPath.section == 0) {
        index = dataArray.count > 5 ? (5 - indexPath.row) : dataArray.count - indexPath.row;
    }else{
        index = indexPath.row + 1;
    }
    listModel.index = [NSString stringWithFormat:@"%ld",index];
    
    BB_TransHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BB_TransHeaderCell"];
    [cell setUIModel:model];
    [cell setSellModel:listModel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * dataArray = indexPath.section == 0 ? self.model.sellList : self.model.buyList;
    BB_SellAndBuyModel * listModel = dataArray[indexPath.row];
    [self upDateAccount:listModel.price];
}
- (void)upDateAccount:(NSString *)text{
    [_priceTextViw setTextFildtext:text];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGRect rect = CGRectMake(0, 0, 180, 32);
        BB_LabesView * labelView = [[BB_LabesView alloc] initWithFrame:rect titles:@[@"盘口",@"价格",@"数量"]];
        labelView.backgroundColor = [UIColor whiteColor];
        return labelView;
    }else{
        UILabel * label = [UILabel new];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        label.textColor = HexColor(@"09C893");
        label.text = @"   CNY"; // 六个空格
        label.backgroundColor = HexColor(@"ffffff");
        return label;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat h;
    switch (section) {
        case 0:
            h = 32;
            break;
        case 1:
            h = 25;
            break;
        default:
            break;
    }
    return h;
}
#pragma mark - method
- (void)addSubviews{
    LRWeakSelf(self)
    BB_CountTextView * priceTextViw = [[BB_CountTextView alloc] init];
    priceTextViw.layer.borderWidth = .5f;
    priceTextViw.layer.borderColor = HexColor(@"999999").CGColor;
    priceTextViw.isHiddenLabel = YES;
    priceTextViw.placeHolder = @"价格";
    priceTextViw.textBlock = ^(NSString *text) {
        self.price = text;
        [weakself culMoney];
    };
    _priceTextViw = priceTextViw;
    
    BB_CountTextView * countTextViw = [[BB_CountTextView alloc] init];
    countTextViw.layer.borderWidth = .5f;
    countTextViw.layer.borderColor = HexColor(@"999999").CGColor;
    countTextViw.placeHolder = @"数量";
    countTextViw.labelText = @"--";
    countTextViw.textBlock = ^(NSString *text) {
        self.num = text;
        [weakself culMoney];
    };
    countTextViw.pointCount = 4;
    _countTextViw = countTextViw;
    
    BB_TransSliderView * sliderView = [[BB_TransSliderView alloc] init];
    sliderView.block = ^(CGFloat progress) {
        LRLog(@"%f",progress);
        weakself.num = [NSString stringWithFormat:@"%4f",progress];
        weakself.num = weakself.num.mul([NSString stringWithFormat:@"%ld",weakself.assetModel.num]);
        [countTextViw setTextFildtext:weakself.num];
        [weakself culMoney];
    };
    UILabel * canUserLabel = [UILabel new];
    canUserLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    canUserLabel.textColor = HexColor(@"666666");
    canUserLabel.textAlignment = NSTextAlignmentRight;
    canUserLabel.text = @"可用：----";
    _sliderView = sliderView;
    _canUseLabel = canUserLabel;
    
    UILabel * choseCoinLabel = [UILabel new];
    choseCoinLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
    choseCoinLabel.textColor = HexColor(@"666666");
    choseCoinLabel.textAlignment = NSTextAlignmentRight;
    choseCoinLabel.text = @"----";
    _choseCoinLabel = choseCoinLabel;
    
    UILabel * transLabel = [UILabel new];
    transLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:13];
    transLabel.textColor = HexColor(@"666666");
    transLabel.text = @"交易额：----";
    _transLabel = transLabel;
    
    UIButton * buyin = [self creatBtnTitle:@"买入" action:@selector(upDateLine:) titleColor:HexColor(@"09C893")];
    buyin.tag = 100;
    UIButton * buyout = [self creatBtnTitle:@"卖出" action:@selector(upDateLine:) titleColor:HexColor(@"F76A42")];
    buyout.tag = 101;
    UIButton * transBnt = [STUIKitTools buttonTitle:@"登录" font:15 action:@selector(buy:) titleColor:HexColor(@"FFFFFF") target:self];
    transBnt.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    transBnt.backgroundColor = HexColor(@"09C893");
    _transBtn = transBnt;
    
    [self addSubview:buyin];
    [self addSubview:buyout];
    [self addSubview:self.linView];
    [self addSubview:priceTextViw];
    [self addSubview:countTextViw];
    [self addSubview:canUserLabel];
    [self addSubview:sliderView];
    [self addSubview:choseCoinLabel];
    [self addSubview:transLabel];
    [self addSubview:transBnt];
    [self addSubview:self.tableView];
    
    [buyin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(34);
    }];
    
    [buyout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(70);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(34);
    }];
    
    [self.linView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(buyin.mas_centerX);
        make.top.equalTo(buyin.mas_bottom).offset(5);
    }];
    
    [priceTextViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.linView.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Ration(190));
        make.height.mas_equalTo(Ration(50));
    }];
    
    [countTextViw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTextViw.mas_bottom).offset(15);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Ration(190));
        make.height.mas_equalTo(Ration(50));
    }];
    
    [canUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countTextViw.mas_bottom).offset(5);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(Ration(18));
    }];
    
    [sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(canUserLabel.mas_bottom).offset(18);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(Ration(160));
    }];

    [choseCoinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sliderView.mas_bottom).offset(5);
        make.right.equalTo(sliderView.mas_right);
    }];
    
    [transLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(choseCoinLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
    }];
    
    [transBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(Ration(40));
        make.width.mas_equalTo(Ration(190));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceTextViw.mas_right);
        make.bottom.right.mas_equalTo(0);
        make.top.mas_equalTo(SafeAreaNavHeight);
    }];
}
- (void)upDateLoginBtn{
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    if (!user.isLogin) {
        [_transBtn setTitle:@"登录" forState:0];
        return ;
    }
    NSString * title ;
    if (self.isBuyin) {
        title = @"买入";
    }else{
        title = @"卖出";
    }
    title = [title stringByAppendingString:[self.listModel.coincode uppercaseString]];
    [_transBtn setTitle:title forState:0];
}
// 计算费率
- (void)culMoney{
    NSString * fee;
    if (self.isBuyin) {
        fee = self.listModel.feeBuy;
    }else{
        fee = self.listModel.feeSell;
    }
    _transLabel.text = [NSString stringWithFormat:@"费用:%@", self.price.mul(self.num).mul(fee).roundDown([self.listModel.round integerValue])];
}
- (void)upDateLineWithTag:(NSInteger)tag{
    [self upDateLine:[self viewWithTag:tag]];
}
- (void)upDateLine:(UIButton *)sender{
    self.linView.backgroundColor = sender.titleLabel.textColor;
    _transBtn.backgroundColor = sender.titleLabel.textColor;
    _sliderView.progressColor = sender.titleLabel.textColor;
    [_sliderView clear];
    [self.linView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(3);
        make.centerX.mas_equalTo(sender.mas_centerX);
        make.top.equalTo(sender.mas_bottom).offset(5);
    }];
    NSString * price;
    if (sender.tag == 100) {
        price = self.model.buylistTopModel.price.length ? self.model.buylistTopModel.price : @"0";
        self.type = @"0";
        self.isBuyin = YES;
    }else{
        price = self.model.selllistTopModel.price.length ? self.model.selllistTopModel.price : @"0";
        self.type = @"1";
        self.isBuyin = NO;
    }
    if (self.buyorsellBlock) {
        self.buyorsellBlock(sender.tag);
    }
    [self upDateLoginBtn];
    [_priceTextViw setTextFildtext:price];
}
- (void)buy:(UIButton *)sender{
    if (!USERMANNGER.isLogin) {
        [USERMANNGER presenLogin];
        return ;
    }
    if (self.clickBlock) {
        self.clickBlock();
    }
}
- (void)setLogTitle:(NSString *)logTitle{
    if (!USERMANNGER.isLogin) {
        logTitle = @"登录";
    }else{
        logTitle = [NSString stringWithFormat:@"%@",[logTitle uppercaseString]];
    }
    [_transBtn setTitle:[logTitle uppercaseString] forState:UIControlStateNormal];
    _countTextViw.labelText = [logTitle uppercaseString];
}
- (UIButton *)creatBtnTitle:(NSString *)title action:(SEL)action titleColor:(UIColor *)titleColor{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:titleColor forState:0];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:17];
    return btn;
}

#pragma mark - get set
- (void)setListModel:(BB_RankListModel *)listModel{
    _listModel = listModel;
    _priceTextViw.pointCount  = [listModel.round integerValue];
    _countTextViw.labelText = [listModel.coincode uppercaseString];
}
- (void)setModel:(BB_SellAndBuyListModel *)model{
    _model = model;
    [self.tableView reloadData];
    [self upDateLine:[self viewWithTag:100]];
}
- (void)setAssetModel:(BB_AssetModel *)assetModel{
    _assetModel = assetModel;
    _canUseLabel.text = [NSString stringWithFormat:@"可用：%ld",assetModel.num];
    _choseCoinLabel.text = [NSString stringWithFormat:@"可用：%ld%@",assetModel.num,[_listModel.coincode uppercaseString]];
    LRLog(@"%@",_canUseLabel);
}
- (UIView *)linView{
    if (!_linView) {
        _linView = [[UIView alloc] init];
        _linView.backgroundColor = HexColor(@"09C893");
    }
    return _linView;
}
- (BB_BasicTableView *)tableView{
    if (!_tableView) {
        _tableView = [STUIKitTools tableDelegate:self dataSource:self];
        [_tableView registerNib:[UINib nibWithNibName:@"BB_TransHeaderCell" bundle:nil] forCellReuseIdentifier:@"BB_TransHeaderCell"];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = HexColor(@"ffffff");
        _tableView.rowHeight = 25;
    }
    return _tableView;
}

@end
