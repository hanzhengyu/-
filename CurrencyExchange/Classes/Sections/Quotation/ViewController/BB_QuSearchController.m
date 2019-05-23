//
//  BB_QuSearchController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/16.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_QuSearchController.h"
#import "BB_QuotationFindCell.h"
#import "BB_QuoDetailController.h"
@interface BB_QuSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) NSMutableArray *choseDataArray;
@property (nonatomic, assign) BOOL isFiter;
@end

@implementation BB_QuSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFiter = NO;
    // 设置UI
    [self setUpUI];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isFiter ? self.choseDataArray.count : self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = (self.isFiter ?  self.choseDataArray : self.dataArray)[indexPath.row];
    BB_QuotationFindCell * homecell = [tableView dequeueReusableCellWithIdentifier:@"BB_HomeCell"];
    homecell.listModel = model;
    return homecell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_RankListModel * model = (self.isFiter ?  self.choseDataArray : self.dataArray)[indexPath.row];
    BB_QuoDetailController *detaVC  = [[BB_QuoDetailController alloc] init];
    detaVC.listModel = model;
    detaVC.gcode = model.gCoincode;
    detaVC.code = model.coincode;
    [self.navigationController pushViewController:detaVC animated:YES];
}
- (void)setUpUI{
    CGRect rect = CGRectMake(0, 0, Ration(290), 30);
    UITextField * field = [[UITextField alloc] initWithFrame:rect];
    [field addTarget:self action:@selector(textFileChange:) forControlEvents:UIControlEventEditingChanged];
    field.layer.borderColor = RGBAColor(204, 204, 204, 0.5).CGColor;
    field.layer.cornerRadius = 15;
    field.layer.borderWidth = .5f;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.rightViewMode = UITextFieldViewModeAlways;
    field.clearButtonMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = field;
    
    UIImageView * imageViw = [STUIKitTools imageView:@"search"];
    imageViw.frame = CGRectMake(20, 0, 50, 16);
    imageViw.contentMode = UIViewContentModeScaleAspectFit;
    field.leftView = imageViw;
    
    UILabel * woringLabel = [STUIKitTools lableFont:14 textColor:HexColor(@"333333") text:@"您要找的是不是"];
    woringLabel.frame = CGRectMake(12, SafeAreaTopHeight + 10, 100, 20);
    woringLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self.view addSubview:woringLabel];
    
     [self.view addSubview:self.table];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(woringLabel.mas_bottom);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
}
- (void)textFileChange:(UITextField *)textField{
    self.choseDataArray = [NSMutableArray array];
    self.isFiter = YES;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BB_RankListModel * model = obj;
        if ([model.usname containsString:[textField.text uppercaseString]]) {
         [self.choseDataArray addObject:model];
        }
    }];
    if (!textField.text.length) {
        self.isFiter = NO;
    }
    LRLog(@"%@",self.choseDataArray);
    [self.table reloadData];
}

#pragma mark - get set
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        LRWeakSelf(self)
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.tableType = TableViewTypeRefreshHeader;
        _table.backgroundColor = [UIColor whiteColor];
        _table.emptyText = @"很抱歉，您查找的货币不存在";
        
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 42;
        _table.estimatedRowHeight = 42;
        [_table registerNib:[UINib nibWithNibName:@"BB_HomeCell" bundle:nil] forCellReuseIdentifier:@"BB_HomeCell"];
    }
    return _table;
}

@end
