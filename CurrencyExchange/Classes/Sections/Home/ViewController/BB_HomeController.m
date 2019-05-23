//
//  BB_HomeController.m
//  CurrencyExchange
//
//  Created by 康程 on 2018/3/6.
//  Copyright © 2018年 康程. All rights reserved.
//

#import "BB_HomeController.h"
#import "BB_HomeCell.h"
#import "BB_HomeHeaderView.h"
#import "BB_QuoDetailController.h"

@interface BB_HomeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) BB_HomeHeaderView *headerView;
@property (nonatomic, strong) NSArray * rankModelList;
@end

@implementation BB_HomeController

-(void)injected{
    
    NSLog(@"I've been injected: %@", self);
    
    [self viewDidLoad];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//[self setUPUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBarHidden = YES;
   
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rankModelList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = self.rankModelList[indexPath.row];
    model.ranking = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    BB_HomeCell * homecell = [tableView dequeueReusableCellWithIdentifier:@"BB_HomeCell"];
    homecell.listModel = model;
    return homecell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = self.rankModelList[indexPath.row];
    BB_QuoDetailController *detaVC  = [[BB_QuoDetailController alloc] init];
    detaVC.listModel = model;
    detaVC.gcode = model.gCoincode;
    detaVC.code = model.coincode;
    [self.navigationController pushViewController:detaVC animated:YES];
}
#pragma mark - method
- (void)setUPUI {
    [self.view addSubview:self.table];
 //   [self.view addSubview:serverBtn];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaNavHeight);
        make.bottom.mas_equalTo(-SafeAreaHomeBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
    _table.tableHeaderView = self.headerView;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.mas_equalTo(0);
    }];
    [self.headerView layoutIfNeeded];
    _table.tableHeaderView = self.headerView;
    
//    [serverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.table.mas_top).offset(SafeAreaNavHeight + 23);
//        make.right.mas_equalTo(-12);
//    }];
}
- (void)loadaData{
    [BB_BasicHandle homeBannerListSucess:^(NSArray * bannerList) {
        [self.headerView setImageUrls:bannerList];
        
    } fail:^(id json) {
        
    }];
    [BB_BasicHandle notifyList:1 pageSize:10 sucess:^(id json) {
        
    } fail:^(id json) {
        
    }];
    [BB_BasicHandle marketRankingSucess:^(NSArray * rankModelList) {
        self.rankModelList = rankModelList;
        [self.table reloadData];
    } fail:^(id json) {
        
    }];
    
    
}

//- (void)jumpQQ{
//    LRLog(@"跳QQ");
//}

#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        LRWeakSelf(self)
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.tableType = TableViewTypeRefreshHeader;
        _table.backgroundColor = [UIColor whiteColor];
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 50;
        _table.estimatedRowHeight = 50;
        [_table registerNib:[UINib nibWithNibName:@"BB_HomeCell" bundle:nil] forCellReuseIdentifier:@"BB_HomeCell"];
        _table.pageFooterBlock = ^(int page, Competion block) {
            [weakself loadaData];
        };
    }
    return _table;
}
- (BB_HomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[BB_HomeHeaderView alloc] init];
    }
    return _headerView;
}
@end
