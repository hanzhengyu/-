//
//  AppDelegate+ChooseRootDelegate.m
//  XinHaoYouNi
//
//  Created by 康程 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.
//

#import "AppDelegate+ChooseRootDelegate.h"
#import "YKTabBarController.h"

@implementation AppDelegate (ChooseRootDelegate)
- (void)chosetRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[YKTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
    }
}

@end
