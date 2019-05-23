//
//  YKTabBarController.h
//  YingKe
//
//  Created by 崔博 on 16/11/19.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKTabBar.h"
@interface YKTabBarController : UITabBarController<YKTabBarDelegate>
@property (nonatomic ,strong) YKTabBar *ykTabbar;

@end
