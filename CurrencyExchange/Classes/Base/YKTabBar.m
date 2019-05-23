//
//  YKTabBar.m
//  YingKe
//
//  Created by 崔博 on 16/11/19.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import "YKTabBar.h"
#import "FSCustomButton.h"
@interface YKTabBar ()

@property (nonatomic, strong) UIImageView *tabbarBackImageView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) NSArray *seletedList;

@property (nonatomic, strong) NSArray *nameArray;

@property (nonatomic, strong) UIButton *lastItem;

@end
@implementation YKTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    
        
        // 背景图片
        self.nameArray = @[@"首页",@"行情",@"交易",@"我的"];
        [self addSubview:self.tabbarBackImageView];
        for (int i = 0; i < self.dataList.count; i ++) {
            FSCustomButton *item = [self creatBtnImage:self.dataList[i] seletedImage:self.seletedList[i] action:@selector(itemClick:)];
            item.titleLabel.font = [UIFont systemFontOfSize:12];
            [item setTitle:self.nameArray[i] forState:0];
            item.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
            item.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
            [item setTitleColor:HexColor(@"C6CEDB") forState:0];
            [item setTitleColor:HexColor(@"546DB7") forState:UIControlStateSelected];
            item.tag = YKItemTypeLive + i;
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
            }
            [self addSubview:item];
        }
    }
    return  self;
}

#pragma mark - event
#pragma mark 点击事件
- (void)itemClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(tabbar:seletexIndex:)]) {
        [self.delegate tabbar:self seletexIndex:sender.tag];
    }
    !self.block?:self.block(self,sender.tag);
    
    if (sender.tag == YKItemTypeLaunch) {
        return;
    }
    
    // 改变按钮状态
    self.lastItem.selected = NO;
    sender.selected = YES;
    self.lastItem = sender;
    
//    [UIView animateWithDuration:0.2 animations:^{
//        sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
//    } completion:^(BOOL finished) {
//        // 回复原始状态
//        sender.transform = CGAffineTransformIdentity;
//    }];
}
#pragma mark - method
#pragma mark creatBnt
- (FSCustomButton *)creatBtnImage:(NSString *)iamge seletedImage:(NSString *)seleImage action:(SEL)action
{
    FSCustomButton *btn = [FSCustomButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:iamge] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:seleImage] forState:UIControlStateSelected];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    btn.buttonImagePosition = FSCustomButtonImagePositionTop;
    return btn;
}
// 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width / self.dataList.count;
    self.tabbarBackImageView.frame = self.bounds;
    for (NSInteger i = 0; i < [self subviews].count; i ++) {
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag - YKItemTypeLive) * w, 0, w, self.frame.size.height);
        }
    }
}

#pragma mark - lazy
- (void)setSeletedIndex:(NSInteger)seletedIndex{
    _seletedIndex = seletedIndex;
    [self itemClick:self.subviews[seletedIndex]];
}
- (UIImageView *)tabbarBackImageView
{
    if (!_tabbarBackImageView) {
        _tabbarBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_back"]];
    }
    return _tabbarBackImageView;
}

- (NSArray *)dataList
{
    if (!_dataList) {
        _dataList = @[@"homec",@"marketc",@"businessc",@"Myc"];
    }
    return  _dataList;
}

- (NSArray *)seletedList
{
    if (!_seletedList) {
        _seletedList = @[@"home",@"market",@"business",@"My"];
    }
    return _seletedList;
}
@end
