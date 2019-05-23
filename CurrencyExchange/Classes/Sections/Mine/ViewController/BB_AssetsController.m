//
//  BB_AssetsController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_AssetsController.h"
#import "BB_AssetCell.h"
#import "BB_AssetHeaderView.h"
@interface BB_AssetsController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) BB_AssetHeaderView *assetHeaderView;
@property(nonatomic,strong) NSArray *assetArray;
@end
@implementation BB_AssetsController



- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUPUI];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.assetArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_AssetCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"BB_AssetCell"];
    BB_AssetModel *model = self.assetArray[indexPath.row];
    mineCell.personModel = model;
    return mineCell;
}
- (void)setUPUI{
    self.title = @"我的资产";
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
}

- (void)loadaData{
    [BB_BasicHandle queryUserAssetsInfoSucess:^(BB_PersonTotalAsetModel * model) {
        self.assetArray = model.coinlist;
        [self.table reloadData];
        [self updateHeaderViewTotalMoney:[NSString stringWithFormat:@"%@",model.numtotal] canUseMoney:[NSString stringWithFormat:@"%@",model.avatotal]];
    } fail:^(id json) {
        
    }];
}

- (void)updateHeaderViewTotalMoney:(NSString *)totalMoney canUseMoney:(NSString *)money{
    [self.assetHeaderView setTotalMoney:totalMoney canUseMoney:money];
}
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        LRWeakSelf(self)
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.backgroundColor = [UIColor whiteColor];
        _table.tableType = TableViewTypeRefreshHeader;
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 50;
        [_table registerNib:[UINib nibWithNibName:@"BB_AssetCell" bundle:nil] forCellReuseIdentifier:@"BB_AssetCell"];
        _table.tableHeaderView = self.assetHeaderView;
        
        _table.pageFooterBlock = ^(int page, Competion block) {
            [weakself loadaData];
        };
        
    }
    return _table;
}
- (BB_AssetHeaderView *)assetHeaderView{
    if (!_assetHeaderView) {
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, Ration(100));
        _assetHeaderView = [[BB_AssetHeaderView alloc] initWithFrame:rect];
    }
    return _assetHeaderView;
}
@end
