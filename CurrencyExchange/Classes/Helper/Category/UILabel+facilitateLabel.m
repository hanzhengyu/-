//
//  UILabel+facilitateLabel.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/24.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "UILabel+facilitateLabel.h"

@implementation UILabel (facilitateLabel)

+ (UILabel *)label{
    UILabel * lael = [[UILabel alloc] init];
    return lael;
}
- (UILabel *)label:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor{
    self.font = font;
    self.text = text;
    self.textColor = textColor;
    return self;
}
- (UILabel *)label:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    [self label:font text:text textColor:textColor textAlignment:textAlignment];
    return self;
}
@end
