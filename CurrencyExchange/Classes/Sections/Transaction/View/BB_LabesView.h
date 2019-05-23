//
//  BB_LabesView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BB_LabesView : UIView
@property (nonatomic, strong) UIColor * textColor;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
@end
