//
//  BB_CountTextView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_CountTextView.h"
#import "MoneyTextField.h"

@interface BB_CountTextView()<UITextFieldDelegate>
@property (nonatomic, strong) MoneyTextField * textField;
@property (nonatomic, strong) UIButton * addButton; // 加
@property (nonatomic, strong) UIButton * divButton; // 减
@property (nonatomic, strong) UILabel *coinNameLabel;
@end
@implementation BB_CountTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.pointCount = 5;
        [self addSubviews];
        self.textField.delegate = self;
    }
    return self;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (!USERMANNGER.isLogin) {
        [USERMANNGER presenLogin];
    }
    return  USERMANNGER.isLogin;
}
- (void)addSubviews{
    UIView * lin = [[UIView alloc] init];
    lin.backgroundColor = HexColor(@"999999");
    
    UIView * lin1 = [[UIView alloc] init];
    lin1.backgroundColor = HexColor(@"999999");
    
    UIView * lin2 = [[UIView alloc] init];
    lin2.backgroundColor = HexColor(@"999999");
    
    [self addSubview:self.textField];
    [self addSubview:lin];
    [self addSubview:lin1];
    [self addSubview:lin2];
    [self addSubview:self.addButton];
    [self addSubview:self.divButton];
    [self addSubview:self.coinNameLabel];
    
    CGFloat w = (Ration(190) - 118) / 2;
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(100);
        make.centerY.equalTo(self);
    }];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField.mas_right);
        make.width.mas_equalTo(.5f);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(self.textField.mas_right).offset(1);
        make.width.mas_equalTo(w);
    }];
    
    
    [self.divButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.equalTo(self.mas_right).offset(-1);
        make.width.mas_equalTo(w);
    }];
    
    [lin2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.equalTo(self.addButton.mas_right).offset(3);
        make.width.mas_equalTo(.5f);
    }];
    [lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.right.equalTo(self.divButton.mas_right).offset(1);
        make.bottom.mas_equalTo(-2);
        make.width.mas_equalTo(.5f);
    }];
    [self.coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.left.equalTo(self.textField.mas_right);
    }];
}
- (void)add:(UIButton *)sender{
    NSString * pointCount =  @"1".div([NSString stringWithFormat:@"%f",pow(10, self.pointCount)]);
    self.textField.text = self.textField.text.add(pointCount);
    self.textBlock(self.textField.text);
}
- (void)div:(UIButton *)sender{
    LRLog(@"我减");
    if ([self.textField.text isEqualToString:@"0"]) {
        [HUDTools shoInfoWithStatus:@"已经是最低价格"];
        return ;
    }
    NSString * pointCount =  @"1".div([NSString stringWithFormat:@"%f",pow(10, self.pointCount)]);
    self.textField.text = self.textField.text.sub(pointCount);
    self.textBlock(self.textField.text);
}

- (void)setTextFildtext:(NSString *)text{
    _textField.text = text;
}
- (void)textEddting:(UITextField *)textField{
    if (self.textBlock) {
        self.textBlock(textField.text);
    }
}
#pragma mark - get set
- (void)setPointCount:(NSInteger)pointCount{
    _pointCount = pointCount;
    self.textField.conunt = pointCount;
}
- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.textField.placeholder = placeHolder;
}
- (void)setIsHiddenLabel:(BOOL)isHiddenLabel{
    _isHiddenLabel = isHiddenLabel;
    self.coinNameLabel.hidden = isHiddenLabel;
}
- (void)setLabelText:(NSString *)labelText{
    _labelText = labelText;
    self.coinNameLabel.text = labelText;
    self.addButton.hidden = YES;
    self.divButton.hidden = YES;
}
-  (MoneyTextField *)textField{
    if (!_textField) {
        _textField = [[MoneyTextField alloc]init];
        _textField.font = [UIFont fontWithName:@"PingFangSC-bold" size:18];
        _textField.conunt = self.pointCount;
        [_textField addTarget:self action:@selector(textEddting:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}
- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [STUIKitTools buttonTitle:@"+" font:30 action:@selector(add:) titleColor:HexColor(@"c9c9c9") target:self];
        _addButton.showsTouchWhenHighlighted = YES;
    }
    return _addButton;
}
- (UIButton *)divButton{
    if (!_divButton) {
        _divButton = [STUIKitTools buttonTitle:@"-" font:30 action:@selector(div:) titleColor:HexColor(@"c9c9c9") target:self];
        _divButton.showsTouchWhenHighlighted = YES;
    }
    return _divButton;
}
- (UILabel *)coinNameLabel{
    if (!_coinNameLabel) {
        _coinNameLabel = [[UILabel alloc] init];
        _coinNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:17];
        _coinNameLabel.textColor = HexColor(@"666666");
        _coinNameLabel.backgroundColor = [UIColor whiteColor];
        _coinNameLabel.text = @"";
        _coinNameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _coinNameLabel;
}
@end
