//
//  UILabel+facilitateLabel.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/24.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (facilitateLabel)

+ (UILabel *)label;
- (UILabel *)label:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;
- (UILabel *)label:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
@end
