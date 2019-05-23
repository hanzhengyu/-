//
//  BB_PageView.m
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/9.
//  Copyright © 2018年 崔博. All rights reserved.
//
#define LabelWidth 15
#define BtnH 27
#define Marigin 38
#import "BB_PageView.h"
#import "JKCountDownButton.h"
@interface BB_PageView(){
    UIView *_linView;
}
@property (nonatomic,assign) BOOL countDownIsHidden;
@property (nonatomic,copy) NSString * textFieldPlaceHolder;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,assign) NSInteger tempW;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic,strong) JKCountDownButton * countDownBtn;
@property (nonatomic, strong) UIButton * secertBtn;

@end
@implementation BB_PageView

- (instancetype)initWithFrame:(CGRect)fram titles:(NSArray *)titles{
    if (self == [super initWithFrame:fram]) {
        self.countDownIsHidden = YES;
        self.textFieldPlaceHolder = @"";
        self.titles = titles;
        [self creatBtn];
        [self addSubview:self.textField];
        self.pageType = PageViewPhone;
        self.textFieldType = TextFileLayerStyleCorner;
        [self addSubview:self.countDownBtn];
        [self addSubview:self.secertBtn];
        [self titleBtnClick:[self viewWithTag:100]];
    }
    return self;
}
#pragma mark - method
- (void)creatBtn{
    int i = 0;
    NSString * text = self.titles[0];
    CGFloat w = [text widthForFont:[UIFont fontWithName:@"PingFangSC-Light" size:18]];
    [self creatLabelWithWidth:w];
    for (NSString *title in self.titles) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(i * w + (i * LabelWidth) + Marigin, 0, w, 27);
        [btn setTitle:title forState:UIControlStateNormal];
        btn.tag = 100 + i;
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
        btn.contentMode = UIViewContentModeCenter;
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [btn setTitleColor:HexColor(@"000000") forState:UIControlStateNormal];
        [btn setTitleColor:HexColor(@"56C5EF") forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        i++;
    }
}
- (void)creatLabelWithWidth:(CGFloat)width{
    if (self.titles.count == 1) {
        return ;
    }
    for (int i = 1; i < self.titles.count ;i++) {
        UILabel * lable = [UILabel new];
        lable.text = @"/";
        lable.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
        CGRect rect = CGRectMake(width * i + (i - 1) * LabelWidth + Marigin, 0, LabelWidth, 27);
        lable.frame = rect;
        lable.tag = 200 + i;
        [self addSubview:lable];
    };
}
-(void)titleBtnClick:(UIButton *)btn
{
    if (self.titles.count == 1) {
        return ;
    }
    if (btn == self.selectedBtn) {
        return ;
    }
    if (btn!= self.selectedBtn) {
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn = btn;
    }else{
        self.selectedBtn.selected = YES;
    }
    // 切换
    // 临时补救
    if (self.titles.count == 3) {
       [self setPageType:btn.tag - 100];
    }else{
        [self setPageType:(btn.tag - 100) + 3];
    }
    [self endEditing:YES];
}

#pragma mark - get set
- (void)setTextFieldType:(TextFileLayerStyle)textFieldType{
    _textFieldType = textFieldType;
    switch (textFieldType) {
        case TextFileLayerStyleCorner:
            self.textField.layer.borderColor = HexColor(@"333333").CGColor;
            self.textField.layer.borderWidth = .5f;
            self.textField.layer.cornerRadius = 20;
            self.textField.layer.borderColor = RGBAColor(51, 51, 51, .3f).CGColor;
            break;
        case TextFileLayerStyleLine:
            self.textField.layer.borderColor = [UIColor clearColor].CGColor;
        {
            CGRect rect = CGRectMake(Marigin, self.height - 1, self.width - 2 * Marigin, .5f);
            UIView * lineView = [[UIView alloc] initWithFrame:rect];
            lineView.backgroundColor = RGBAColor(51, 51, 51, .3f);
            [self addSubview:lineView];
            _linView = lineView;
        }
            break;
        default:
            break;
    }
}
- (void)setPlaceHoder:(NSString *)placeHoder{
    _placeHoder = placeHoder;
    self.textField.placeholder = placeHoder;
    [self.textField setValue:RGBAColor(51, 51, 51, .3f) forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont fontWithName:@"PingFangSC-light" size:13] forKeyPath:@"_placeholderLabel.font"];
}
- (void)setCodeHidden:(BOOL)codeHidden{
    _codeHidden = codeHidden;
    self.countDownBtn.hidden = codeHidden;
}
-(void)clear{
    self.textField.text = @"";
    if (self.textBlock) {
        self.textBlock(@"");
    }
}
- (void)setPageType:(PageViewType)pageType{
    _pageType = pageType;
    switch (pageType) {
        case PageViewPhone:
            self.countDownIsHidden = YES;
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        case PageViewEmail:
            self.countDownIsHidden = YES;
            break;
        case PageViewUserName:
            self.countDownIsHidden = YES;
            break;
        case PageViewPwd:

            self.countDownIsHidden = YES;
            break;
        case PageViewCode:
            // 倒计时按钮出现
            self.countDownIsHidden = NO;
            break;
        case PageViewDefault:
            // 倒计时按钮出现
            self.countDownIsHidden = YES;
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;

        default:
            break;
    }
    [self confiCountBtn];
}
- (void)confiCountBtn{
    self.countDownBtn.hidden = self.countDownIsHidden;
    self.textField.placeholder = self.textFieldPlaceHolder;
}
- (void)textFieldChange:(UITextField *)textField{
    if (self.textBlock) {
        self.textBlock(textField.text);
    }
}
- (void)secretClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.textField.secureTextEntry = sender.selected;
}
- (void)setIsScretBtn:(BOOL)isScretBtn{
    _isScretBtn = isScretBtn;
    self.secertBtn.hidden = !isScretBtn;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        CGRect rect = CGRectMake(Marigin,BtnH + 23 , SCREEN_WIDTH - 2 * Marigin, 40);
        _textField.frame = rect;
        CGRect leftRect = CGRectMake(0, 0, 20, 1);
        _textField.leftView = [[UIView alloc] initWithFrame:leftRect];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        
        CGRect righttRect = CGRectMake(0, 0, 80, 1);
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.rightView = [[UIView alloc] initWithFrame:righttRect];
        [_textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.placeholder = self.textFieldPlaceHolder;
    }
    return _textField;
};
- (JKCountDownButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        _countDownBtn.frame = CGRectMake(self.textField.maxX - 90, _textField.y, 80, 30);
        [_countDownBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_countDownBtn setTitleColor:[UIColor blackColor] forState:0];
        [_countDownBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _countDownBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _countDownBtn.centerY = self.textField.centerY;
        _countDownBtn.layer.borderColor = RGBAColor(51, 51, 51, .3f).CGColor;
        _countDownBtn.layer.borderWidth = .5f;
        _countDownBtn.clipsToBounds = self.countDownIsHidden;
        _countDownBtn.layer.cornerRadius = 15;
        _countDownBtn.hidden = YES;
       
        [_countDownBtn countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
//            if (self.pageType == PageViewPhone) {
//                if ([self.textField.text validateContactNumber]) {
//
//                    [HUDTools shoInfoWithStatus:@"请输入正确的手机号"];
//                    return ;
//                }
//            }else{
//
//            }
            if (self.codeblock) {
                self.codeblock();
            }
            sender.enabled = NO;
            [sender startCountDownWithSecond:60];
            [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                return @"重新获取";
            }];
        }];
    }
    return _countDownBtn;
}
- (UIButton *)secertBtn{
    if (!_secertBtn) {
        _secertBtn = [STUIKitTools buttonImage:@"Blinkeye" action:@selector(secretClick:) target:self];
        [_secertBtn setImage:[UIImage imageNamed:@"closeeye"] forState:UIControlStateSelected];
        _secertBtn.frame = CGRectMake(self.textField.maxX - 50, _textField.y, 40, 45);
        _secertBtn.centerY = self.textField.centerY;
        _secertBtn.hidden = YES;
    }
    return _secertBtn;
}
- (NSString *)fieldText{
    return self.textField.text;
}
@end
