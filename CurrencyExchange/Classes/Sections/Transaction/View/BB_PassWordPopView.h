//
//  BB_PassWordPopView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^TextBlock)(NSString *text);
#import <UIKit/UIKit.h>

@interface BB_PassWordPopView : UIView
@property (nonatomic, copy) TextBlock block;
+ (instancetype)passWordPopView;
- (void)show;
- (void)dismiss;
@end
