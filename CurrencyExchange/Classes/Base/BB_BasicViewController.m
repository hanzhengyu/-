//
//  BB_BasicViewController.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BB_BasicViewController.h"
#import "BB_DataEmptyView.h"
#import "BB_LoginController.h"
#import "BB_RegisViewController.h"
@interface BB_BasicViewController ()
@property(nonatomic, strong) BB_DataEmptyView * emptyView;
@end

@implementation BB_BasicViewController

#pragma mark - view  cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    LRLog(@"---%@",[self class]);
    [self setUPLeftItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]}];
    if(iOS11) {
        LRLog(@"我是11");
    }else{
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    // 隐藏tabbar
    if (self.rt_navigationController.childViewControllers.count > 1 || [[self class] isKindOfClass:[BB_LoginController class]] || [[self class] isKindOfClass:[BB_RegisViewController class]]) {
        self.tabBarController.tabBar.hidden = YES;
    }
    else
    {
        // 显示tabar
        self.tabBarController.tabBar.hidden = NO;
    }
    [super viewWillAppear:animated];
}

- (void)loadEmptyView{
    self.emptyView = [[BB_DataEmptyView alloc] init];
    [self.view addSubview:self.emptyView];
    UIEdgeInsets edg = UIEdgeInsetsMake(SafeAreaTopHeight, 0, -SafeAreaBottomHeight, 0);
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edg);
    }];
}
- (void)hideEmptyView{
    self.emptyView.hidden = YES;
}

#pragma private method

- (void)setUPLeftItem{

    if (self.rt_navigationController.childViewControllers.count > 1 || [self isKindOfClass:[BB_LoginController class]]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_black_new"] style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
    }
}

- (void)pop{
    [HUDTools dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
