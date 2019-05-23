//
//  BB_BB_TranEntrustSectionView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/14.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^MoreClickBlock)();
#import <UIKit/UIKit.h>

@interface BB_BB_TranEntrustSectionView : UIView
@property (nonatomic, assign) BOOL isMore;
@property (nonatomic, copy)MoreClickBlock block;
@end
