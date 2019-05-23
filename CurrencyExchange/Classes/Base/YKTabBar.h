//
//  YKTabBar.h
//  YingKe
//
//  Created by 崔博 on 16/11/19.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YKTabBar;

typedef NS_ENUM(NSUInteger, YKItemType) {
    
    YKItemTypeLaunch = 10,
    YKItemTypeLive =  100,// 展示直播
    YKItemTypeMe,
    
};
typedef void(^TabBlock)(YKTabBar *tab,YKItemType inde);

@protocol YKTabBarDelegate <NSObject>

- (void)tabbar:(YKTabBar *)tabbar seletexIndex:(YKItemType)index;

@end

@interface YKTabBar : UIView
@property (nonatomic, weak) id<YKTabBarDelegate>delegate;
@property (nonatomic, copy) TabBlock block;
@property (nonatomic, assign) NSInteger seletedIndex;
@end
