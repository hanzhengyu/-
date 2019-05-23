//
//  BB_QuotationController.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/6.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_QuotationController.h"
#import "BB_HomeCell.h"
#import "BB_QuSearchController.h"
#import "BB_QuoDetailController.h"
#import "XHChatQQ.h"
@interface BB_QuotationController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation BB_QuotationController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setTitleViewAndItem];
    [self setuUpUI];
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = self.dataArray[indexPath.row];
    model.ranking = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    BB_HomeCell * homecell = [tableView dequeueReusableCellWithIdentifier:@"BB_HomeCell"];
    homecell.listModel = model;
    return homecell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = self.dataArray[indexPath.row];
    BB_QuoDetailController *detaVC  = [[BB_QuoDetailController alloc] init];
    detaVC.listModel = model;
    detaVC.gcode = model.gCoincode;
    detaVC.code = model.coincode;
    [self.navigationController pushViewController:detaVC animated:YES];
}
#pragma mark - method
- (void)search{
    LRLog(@"搜索页面");
    BB_QuSearchController * search = [[BB_QuSearchController alloc] init];
    search.dataArray = self.dataArray;
    [self.navigationController pushViewController:search animated:YES];
}
- (void)setTitleViewAndItem{
    self.navigationItem.title = @"玩家网";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"kefu"] style:UIBarButtonItemStylePlain target:self action:@selector(kefu)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
}

//客服
//-(void)kefu {
//    //  LRLog(@"跳QQ");
//    //是否安装QQ
//    if([XHChatQQ haveQQ])
//    {
//        //传入用来接收临时消息的QQ号码
//        //调用QQ客户端,发起QQ临时会话
//        [XHChatQQ chatWithQQ:@"1546579637"];
//    } else {
//        [UIAlertController Alert:self Tip:@"您的手机还未安装QQ"];
//    }
//}
- (void)setuUpUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaHomeBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
}
- (void)loadData{
    [BB_BasicHandle allMarketTradeDatasortSucess:^(id json) {
        self.dataArray = json;
        [self.table reloadData];
    } fail:^(id json) {
        
    }];
}
#pragma mark - get set
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        LRWeakSelf(self)
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.tableType = TableViewTypeRefreshHeader;
        _table.backgroundColor = [UIColor whiteColor];
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 42;
        _table.estimatedRowHeight = 42;
        
        [_table registerNib:[UINib nibWithNibName:@"BB_HomeCell" bundle:nil] forCellReuseIdentifier:@"BB_HomeCell"];
        _table.pageFooterBlock = ^(int page, Competion block) {
            [weakself loadData];
        };
    }
    return _table;
}
@end
