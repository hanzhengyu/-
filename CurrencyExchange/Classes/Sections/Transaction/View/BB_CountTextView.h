//
//  BB_CountTextView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//
typedef void(^TextBlock)(NSString *text);
#import <UIKit/UIKit.h>

@interface BB_CountTextView : UIView
@property (nonatomic, assign) NSInteger pointCount; // 小数点位数
@property (nonatomic, copy) NSString * placeHolder;
@property (nonatomic, copy) TextBlock textBlock;
@property (nonatomic, copy) NSString * labelText;
@property (nonatomic, assign) BOOL isHiddenLabel;
- (void)setTextFildtext:(NSString *)text;
@end
