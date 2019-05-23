//
//  BB_SafeCenterControllerViewController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/21.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_SafeCenterControllerViewController.h"
#import "BB_safeCenterCell.h"
#import "BB_MineModel.h"
#import "BB_EmailOrPhneSucessController.h"
#import "BB_RegisViewController.h"
#import "BB_LoginController.h"
@interface BB_SafeCenterControllerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BB_SafeCenterControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self prepareData];
    [self setUPUI];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_safeCenterCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"BB_safeCenterCell"];
    [mineCell setUIModel:self.dataArray[indexPath.row]];
    return mineCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LRWeakSelf(self)
    BB_BasicViewController *vc;
    BB_MineModel * m = self.dataArray[indexPath.row];
    if ([m.title isEqualToString:@"手机号"]) {
        if (USERMANNGER.user.isBlindmobile) {
            vc = [[BB_EmailOrPhneSucessController alloc] init];
            ((BB_EmailOrPhneSucessController *)vc).text = USERMANNGER.user.mobile;
            ((BB_EmailOrPhneSucessController *)vc).type = SucessTypePhone;
            vc.navigationItem.title = @"手机号";
        }else{
            vc = [[BB_RegisViewController alloc] init];
            ((BB_RegisViewController *)vc).type = ChangeTypeBlindPhone;
            ((BB_RegisViewController *)vc).block = ^{
                [weakself prepareData];
            };
        }
    }else if ([m.title isEqualToString:@"邮箱号"]){
        if (USERMANNGER.user.isBlindEmai) {
            vc = [[BB_EmailOrPhneSucessController alloc] init];
            ((BB_EmailOrPhneSucessController *)vc).text = USERMANNGER.user.email;
            ((BB_EmailOrPhneSucessController *)vc).type = SucessTypeEmail;
        }else{
            vc = [[BB_RegisViewController alloc] init];
            ((BB_RegisViewController *)vc).type = ChangeTypeBlindEmail;
            ((BB_RegisViewController *)vc).block = ^{
                [weakself prepareData];
            };
        }
    }else if ([m.title isEqualToString:@"登录密码"]){
        vc = [[BB_RegisViewController alloc] init];
        ((BB_RegisViewController *)vc).type = ChangeTypeLoginPwd;
    }else if ([m.title isEqualToString:@"支付密码"]){
        vc = [[BB_RegisViewController alloc] init];
        ((BB_RegisViewController *)vc).type = ChangeTypePayPwd;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)prepareData{
    NSArray * titlls = @[@"手机号",@"邮箱号",@"登录密码",@"支付密码"];
    NSString * idEmail = USERMANNGER.user.isBlindEmai ? @"已绑定" : @"未绑定";
    NSString * idMobile = USERMANNGER.user.isBlindmobile ? @"已绑定" : @"未绑定";
    NSArray * subTitles = @[idMobile,idEmail,@"",@""];
    for (int i = 0; i < titlls.count; i++) {
        BB_MineModel * model = [[BB_MineModel alloc] init];
        model.title = titlls[i];
        model.subTitle = subTitles[i];
        [self.dataArray addObject:model];
    }
}
- (void)setUPUI{
    self.navigationItem.title = @"安全中心";
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaHomeBottomHeight);
        make.left.right.mas_equalTo(0);
    }];
}
#pragma mark - set get
- (BB_BasicTableView *)table{
    if (!_table) {
        _table = [STUIKitTools tableDelegate:self dataSource:self];
        _table.backgroundColor = [UIColor whiteColor];
        //1 禁用系统自带的分割线
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.rowHeight = 54;
        [_table registerNib:[UINib nibWithNibName:@"BB_safeCenterCell" bundle:nil] forCellReuseIdentifier:@"BB_safeCenterCell"];
    }
    return _table;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
