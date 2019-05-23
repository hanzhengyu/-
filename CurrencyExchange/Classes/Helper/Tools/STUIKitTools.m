//
//  STUIKitTools.m
//  CuiBoStore
//
//  Created by 崔博 on 16/11/28.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import "STUIKitTools.h"

@implementation STUIKitTools

+ (UIButton *)buttonTitle:(NSString *)title font:(int)font action:(SEL)action titleColor:(UIColor *)titleColor target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    return btn;
}
+ (UIButton *)buttonImage:(NSString *)image action:(SEL)action target:(id)target{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
+ (UIButton *)buttonImage:(NSString *)image title:(NSString *)title font:(int)font action:(SEL)action titleColor:(UIColor *)titleColor target:(id)target
{
    UIButton *btn = [self buttonTitle:title font:font action:action titleColor:titleColor target:target];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return btn;
}
+ (BB_BasicTableView *)tableCreat
{
    BB_BasicTableView *table = [[BB_BasicTableView alloc] init];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    return table;
}
+ (UILabel *)labelFont:(int)font
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:font];
    return label;
}
+ (UILabel *)lableFont:(int)font textColor:(UIColor *)textColor
{
    UILabel *label = [self labelFont:font];
    label.textColor = textColor;
    return  label;
}

+ (UILabel *)lableFont:(int)font textColor:(UIColor *)textColor text:(NSString *)text
{
    UILabel *label = [self lableFont:font textColor:textColor];
    label.text = text;
    return label;
}

+ (UITextField *)textFileHolder:(NSString *)holder style:(UITextBorderStyle)style
{
    UITextField *text = [[UITextField alloc] init];
    text.borderStyle = style;
    text.placeholder = holder;
    return text;
}

+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource
{
    BB_BasicTableView *table = [[BB_BasicTableView alloc] init];
    table.delegate = delegate;
    table.dataSource = dataSource;
    return table;
}
+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource nibCell:(NSString *)nibCell ider:(NSString *)ider
{
    BB_BasicTableView * table = [self tableDelegate:delegate dataSource:dataSource];
    
    [table registerNib:[UINib nibWithNibName:nibCell bundle:nil] forCellReuseIdentifier:ider];
    return table;
}
+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource classCell:(id)classCell ider:(NSString *)ider
{
    BB_BasicTableView *table = [self tableDelegate:delegate dataSource:dataSource];
    [table registerClass:[classCell class] forCellReuseIdentifier:ider];
    return table;
}
+ (UIImageView *)imageView:(NSString *)image
{
   UIImageView *ima = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    return ima;
}
@end
