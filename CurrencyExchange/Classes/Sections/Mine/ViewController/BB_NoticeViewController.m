//
//  BB_NoticeViewController.m
//  CurrencyExchange
//
//  Created by company on 2018/4/3.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_NoticeViewController.h"
#import "BB_NoticeCell.h"
#import "BasiWebViewController.h"
@interface BB_NoticeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;

@property(nonatomic,strong) NSArray *assetArray;

@end

@implementation BB_NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.table.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_NoticeCell * noticeCell = [tableView dequeueReusableCellWithIdentifier:@"BB_NoticeCell"];
    noticeCell.title.text = self.table.dataArray[indexPath.row][@"title"];
    return noticeCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BasiWebViewController *webvc = [[BasiWebViewController alloc] init];
    webvc.url =  self.table.dataArray[indexPath.row][@"url"];
    [self.navigationController pushViewController:webvc animated:YES];
}
- (void)setUPUI{
    self.title = @"公告通知";
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaHomeBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)loadaData{
   
}
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
       // LRWeakSelf(self)
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.backgroundColor = [UIColor whiteColor];
        _table.tableType = TableViewTypeRefreshHeader;
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 50;
        [_table registerClass:[BB_NoticeCell class] forCellReuseIdentifier:@"BB_NoticeCell"];
      
       // _table.tableHeaderView = self.assetHeaderView;
        
        _table.pageFooterBlock = ^(int page, Competion block) {
            [[AFHttpClient sharedClient] POST:@"http://beenl.helpcenter.store:80?json=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject[@"posts"]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        };
        
    }
    return _table;
}

@end
