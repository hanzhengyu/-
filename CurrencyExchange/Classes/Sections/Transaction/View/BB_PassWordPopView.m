//
//  BB_PassWordPopView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/4/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_PassWordPopView.h"

@implementation BB_PassWordPopView

+ (instancetype)passWordPopView{
    BB_PassWordPopView * pop = [[BB_PassWordPopView alloc] init];
    pop.backgroundColor = [UIColor redColor];
    return pop;
}
- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [self.superview addSubview:self];
}
- (void)dismiss{
    [self removeFromSuperview];
}
@end
