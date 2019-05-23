//
//  UIButton+buttonTools.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/24.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "UIButton+buttonTools.h"

@implementation UIButton (buttonTools)
+ (UIButton *)bb_btn{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    return btn;
}
+ (UIButton *)bb_btnNorTitle:(NSString *)NormalTitle{
    UIButton * btn = [UIButton bb_btn];
    [btn setTitle:NormalTitle forState:UIControlStateNormal];
    return btn;
}
- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage
                   seletedBackImage:(NSString *)seletedBackImage
                              title:(NSString *)title
                    normaltextColor:(UIColor *)normalTextColor
                   seletedtextColor:(UIColor *)seletedtextColor
                               font:(UIFont *)font{
    [self bb_buttonNormalBackImage:normalBackImage seletedBackImage:seletedBackImage];
    [self bb_buttonNormalTitle:title seletedTitle:title];
    [self bb_buttonNormalTitleColor:normalTextColor seletedTitleColor:seletedtextColor];
    self.titleLabel.font = font;
    return self;
}
- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage seletedBackImage:(NSString *)seletedBackImage{
    [self setBackgroundImage:[UIImage imageNamed:normalBackImage] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:seletedBackImage] forState:UIControlStateSelected];
    return self;
}
- (UIButton *)bb_buttonNormaImage:(NSString *)normalImage seletedImage:(NSString *)seletedImage{
    [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:seletedImage] forState:UIControlStateSelected];
    return self;
}
- (UIButton *)bb_buttonNormaImage:(NSString *)normalImage disableImage:(NSString *)disableImage{
    [self setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    return self;
}

- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage diasbleImage:(NSString *)diasbleImage{
    [self setBackgroundImage:[UIImage imageNamed:normalBackImage] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:diasbleImage] forState:UIControlStateDisabled];
    return self;
}
- (UIButton *)bb_buttonNormalTitle:(NSString *)normalTitle seletedTitle:(NSString *)seletedTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:normalTitle forState:UIControlStateSelected];
    return self;
}
- (UIButton *)bb_buttonNormalTitleColor:(UIColor *)normalTitleColor seletedTitleColor:(UIColor *)seletedTitleColor{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:seletedTitleColor forState:UIControlStateSelected];
    return self;
}
@end
