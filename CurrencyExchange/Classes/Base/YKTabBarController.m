//
//  YKTabBarController.m
//  YingKe
//
//  Created by 崔博 on 16/11/19.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import "YKTabBarController.h"
#import "AppDelegate.h"
#import "AppDelegate+ChooseRootDelegate.h"
@interface YKTabBarController ()
@end

@implementation YKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // 配置控制器
    [self configViewControllers];
    // 加载tabbar
    [self.tabBar addSubview:self.ykTabbar];
//    // 解决tabbar的阴影线
//    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    self.tabBar.layer.shadowOpacity = 1;
    self.tabBar.layer.shadowColor = RGBAColor(0, 0, 0, .1f).CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(1,1);
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
    

}
#pragma mark - delegate
#pragma mark tabbarDelegate
- (void)tabbar:(YKTabBar *)tabbar seletexIndex:(YKItemType)index
{
    if (index != YKItemTypeLaunch) {
        self.selectedIndex = index - YKItemTypeLive;
        return;
    }
   
}
#pragma mark - event
#pragma mark  configViewControllers
- (void)configViewControllers
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"BB_HomeController",@"BB_QuotationController",@"BB_TransactionController",@"BB_MineController"]];
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString *vcName = array[i];
        BB_BasicViewController *vc = [[NSClassFromString(vcName) alloc] init];
        RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
    };
    self.viewControllers = array;
}

#pragma mark - lazy
- (YKTabBar *)ykTabbar
{
    if (!_ykTabbar) {
        _ykTabbar = [[YKTabBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49)];
        _ykTabbar.delegate = self;
    }
    return _ykTabbar;
}

@end
