//
//  BB_EntrustmentRecordController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/22.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_EntrustmentRecordController.h"
#import "BB_BB_TranEntrustSectionView.h"
#import "BB_TransEntrustCell.h"
@interface BB_EntrustmentRecordController ()
@property (nonatomic, strong) BB_BasicTableView * backTableView;
@property (nonatomic, strong) NSArray * dataArray;
@end

@implementation BB_EntrustmentRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LRWeakSelf(self)
    BB_EntrustHistoryModel * model = self.dataArray[indexPath.row];
    BB_TransEntrustCell * homecell = [tableView dequeueReusableCellWithIdentifier:@"BB_TransEntrustCell"];
    homecell.historyModel = model;
    homecell.block = ^{
        [BB_BasicHandle cancelEntrustByMarketTdid:model.tlid sucess:^(id json) {
            model.status = -1;
            [weakself.backTableView reloadData];
        } fail:^(id json) {
            
        }];
    };
    return homecell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    BB_BB_TranEntrustSectionView *tranView = [[BB_BB_TranEntrustSectionView alloc] initWithFrame:rect];
    tranView.backgroundColor = [UIColor whiteColor];
    tranView.isMore = NO;
    return tranView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 80;
}
#pragma mark - method
- (void)loadData{
    [BB_BasicHandle queryEntrustHistory:self.coincode gCoincode:self.gcoincode sucess:^(id json) {
        self.dataArray = json;
        [self.backTableView reloadData];
    } fail:^(id json) {
        
    }];
}
- (void)setUpUI{
    [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
}
- (BB_BasicTableView *)backTableView{
    if (!_backTableView) {
        LRWeakSelf(self)
        _backTableView = [STUIKitTools tableDelegate:self dataSource:self];
        [_backTableView registerNib:[UINib nibWithNibName:@"BB_TransEntrustCell" bundle:nil] forCellReuseIdentifier:@"BB_TransEntrustCell"];
        _backTableView.backgroundColor = [UIColor whiteColor];
        _backTableView.emptyText = @"暂无记录....";
        _backTableView.rowHeight = 33;
        _backTableView.tableType = TableViewTypeRefreshFooterHeader;
        _backTableView.pageFooterBlock = ^(int page, Competion block) {
            [weakself loadData];
        };
    }
    return _backTableView;
}
@end
