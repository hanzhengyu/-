//
//  BB_TransSliderView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/15.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^ProgressBlock)(CGFloat progress);
#import <UIKit/UIKit.h>

@interface BB_TransSliderView : UIControl
@property (nonatomic, assign) int pointCount;
@property (nonatomic, strong) UIColor * progressColor;
@property (nonatomic, copy) ProgressBlock block;
- (void)clear;
@end
