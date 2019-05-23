//
//  BB_MineController.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/6.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_MineController.h"
#import "BB_MineCell.h"
#import "BB_MineModel.h"
#import "BB_MineHeaderView.h"
#import "BB_AssetsController.h"
#import "BB_IDiderController.h"
#import "BB_SafeCenterControllerViewController.h"
#import "BB_NoticeViewController.h"
#import "BasiWebViewController.h"
#import "BB_SettingViewController.h"
@interface BB_MineController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) BB_MineHeaderView * headerView;
@property (nonatomic, assign) NSInteger isral;
@end

@implementation BB_MineController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareData];
    [[AFHttpClient sharedClient].requestSerializer setValue:[UserManngerTool share].user.token forHTTPHeaderField:@"access_token"];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    [BB_BasicHandle userInfo:^(id json) {
        
        _isral =[json[@"isral"] integerValue];
      //  NSLog(@"====json = %ld",(long)_isral);
    } fail:^(id json) {
        
    } ];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
}


#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_MineCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"BB_MineCell"];
    [mineCell setUIModel:self.dataArray[indexPath.row]];
    return mineCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_MineModel * mode = self.dataArray[indexPath.row];
    if ([mode.isLogin isEqualToString:@"1"]) {
        [USERMANNGER presenLogin];
        return ;
    }
    BB_BasicViewController *vc;
    if ([mode.title isEqualToString:@"我的资产"]) {
        vc = [[BB_AssetsController alloc] init];
    }else if ([mode.title isEqualToString:@"身份认证"]){
        USERMANNGER.user.isral;
        vc = [[BB_IDiderController alloc] init];
//        IdenStatusWaite,
//        IdenStatusSucess,
//        IdenStatusFail,
//        IdenStatusNever,
 //      (  0未提交，1等待审核，2审核驳回，3审核通过）)
//        ((BB_IDiderController *)vc).status = USERMANNGER.IdenStatusNever;
        ((BB_IDiderController *)vc).status = _isral;

    }else if ([mode.title isEqualToString:@"安全中心"]){
        vc = [[BB_SafeCenterControllerViewController alloc] init];
    }else if ([mode.title isEqualToString:@"公告通知"]){
        vc = [[BB_NoticeViewController alloc] init];
    }else if ([mode.title isEqualToString:@"帮助中心"]){
        vc = [[BasiWebViewController alloc] init];
         ((BasiWebViewController *)vc).url =  @"http://beenl.helpcenter.store/";
       
        vc.title = @"帮助中心";
    }else if ([mode.title isEqualToString:@"设置"]){
        BB_SettingViewController *setting = [[BB_SettingViewController alloc]init];
         [self.navigationController pushViewController:setting animated:YES];
   
        return ;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - method
// 登陆成功更新页面
- (void)updateHeaderUI{
    [self prepareData];
}
- (void)prepareData{
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    self.headerView.islogin = user.isLogin;
    self.dataArray = [NSMutableArray array];
    NSArray * titleArray;
    NSArray * imageArray;
    NSArray * isLoinArray;
    titleArray = @[@"我的资产",@"安全中心",@"身份认证",@"帮助中心",@"公告通知",@"设置"];
    imageArray = @[@"asset",@"safety",@"identity",@"Help",@"notice",@"Setup"];
    if (!USERMANNGER.isLogin) {
        isLoinArray = @[@"1",@"1",@"1",@"0",@"0",@"0"];
    }else{
        isLoinArray = @[@"0",@"0",@"0",@"0",@"0",@"0"];
    }
    for (int i = 0; i < titleArray.count; i++) {
        BB_MineModel * model = [[BB_MineModel alloc] init];
        model.imageName = imageArray[i];
        model.title = titleArray[i];
        model.isLogin = isLoinArray[i];
        [self.dataArray addObject:model];
    }
    [self.table reloadData];
}
- (void)setUPUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaNavHeight);
        make.bottom.mas_equalTo(-SafeAreaHomeBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
    self.table.tableHeaderView = self.headerView;
}
#pragma mark - get set
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.backgroundColor = [UIColor whiteColor];
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 54;
        _table.tableHeaderView = self.headerView;
        [_table registerNib:[UINib nibWithNibName:@"BB_MineCell" bundle:nil] forCellReuseIdentifier:@"BB_MineCell"];
    }
    return _table;
}
- (BB_MineHeaderView *)headerView{
    if (!_headerView) {
        CGRect rect =  CGRectMake(0, 0, SCREEN_WIDTH, Ration(200));
        _headerView = [[BB_MineHeaderView alloc] initWithFrame:rect];
    }
    return _headerView;
}
@end
