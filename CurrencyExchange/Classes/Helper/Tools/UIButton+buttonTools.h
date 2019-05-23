//
//  UIButton+buttonTools.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/24.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (buttonTools)

+ (UIButton *)bb_btn;
+ (UIButton *)bb_btnNorTitle:(NSString *)NormalTitle;
- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage
                   seletedBackImage:(NSString *)seletedBackImage
                              title:(NSString *)title
                    normaltextColor:(UIColor *)normalTextColor
                   seletedtextColor:(UIColor *)seletedTextColor
                               font:(UIFont *)font;

- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage seletedBackImage:(NSString *)seletedBackImage;
- (UIButton *)bb_buttonNormaImage:(NSString *)normalImage seletedImage:(NSString *)seletedImage;
- (UIButton *)bb_buttonNormalTitle:(NSString *)normalTitle seletedTitle:(NSString *)seletedTitle;
- (UIButton *)bb_buttonNormalTitleColor:(UIColor *)normalTitleColor seletedTitleColor:(UIColor *)seletedTitleColor;
- (UIButton *)bb_buttonNormaImage:(NSString *)normalImage disableImage:(NSString *)disableImage;
- (UIButton *)bb_buttonNormalBackImage:(NSString *)normalBackImage diasbleImage:(NSString *)diasbleImage;
@end
