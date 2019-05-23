//
//  BB_TransactionController.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/6.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_TransactionController.h"
#import "SLSlideMenu.h"
#import "BB_HomeCell.h"
#import "BB_HomenUIModel.h"
#import "BB_TransactionHeaderView.h"
#import "BB_BB_TranEntrustSectionView.h"
#import "BB_TransEntrustCell.h"
#import "BB_QuoDetailController.h"
#import "BB_PassWordPopView.h"
#import "BB_EntrustmentRecordController.h"
@interface BB_TransactionController ()<SLSlideMenuProtocol,UITableViewDelegate,UITableViewDataSource>{
    UIButton *_letfBtn;
}
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) BB_TransactionHeaderView * headerView;
@property (nonatomic, strong) BB_BasicTableView * backTableView;
@property (nonatomic, strong) NSArray <BB_EntrustmentRecordModel *>* dataArray;
@property (nonatomic, copy) NSString * logintTitle;

@property (nonatomic, copy) NSString * tranPwd;
@end

@implementation BB_TransactionController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadAllCoins];
    _tranPwd = @"";
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateHeaderUI) name:LOGINSUCESS object:nil];
}

//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.backTableView) {
        return self.dataArray ? self.dataArray.count : 1;
    }else{
        return USERMANNGER.allCoinArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.backTableView) {
        LRWeakSelf(self)
        BB_TransEntrustCell * entrustCell = [tableView dequeueReusableCellWithIdentifier:@"BB_TransEntrustCell"];
        USERMANNGER.isLogin ? (entrustCell.recodeModel = self.dataArray[indexPath.row]) : [entrustCell updaEmpty];
        entrustCell.block = ^{
            [BB_BasicHandle cancelEntrustByMarketTdid:weakself.dataArray[indexPath.row].tdid sucess:^(id json) {
                [weakself loadData];
            } fail:^(id json) {
                
            }];
        };
        return entrustCell;
    }else{
        BB_HomeCell * homecell = [tableView dequeueReusableCellWithIdentifier:@"BB_HomeCell"];
        BB_RankListModel *model = USERMANNGER.allCoinArray[indexPath.row];
        model.ranking = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        homecell.selectionStyle = UITableViewCellSelectionStyleGray;
        homecell.listModel = model;
        return homecell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.backTableView) {
        if (USERMANNGER.isLogin) {
            LRWeakSelf(self)
            CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 50);
            BB_BB_TranEntrustSectionView *tranView = [[BB_BB_TranEntrustSectionView alloc] initWithFrame:rect];
            tranView.backgroundColor = [UIColor whiteColor];
            tranView.isMore = USERMANNGER.isLogin;
            tranView.block = ^{
                BB_EntrustmentRecordController *envc = [[BB_EntrustmentRecordController alloc] init];
                envc.coincode = self.coincode;
                envc.gcoincode = self.gCoincode;
                [weakself.navigationController pushViewController:envc animated:YES];
            };
            CGRect linerect = CGRectMake(0, 0, SCREEN_WIDTH, 10);
            UIView * line = [[UIView alloc] initWithFrame:linerect];
            line.backgroundColor = HexColor(@"f3f3f3");
            [tranView addSubview:line];
            return tranView;
        }else{
            CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 30);
            BB_BB_TranEntrustSectionView *tranView = [[BB_BB_TranEntrustSectionView alloc] initWithFrame:rect];
            tranView.backgroundColor = [UIColor whiteColor];
            tranView.isMore = USERMANNGER.isLogin;
            tranView.clipsToBounds = YES;
            CGRect linerect = CGRectMake(0, 0, SCREEN_WIDTH, 10);
            UIView * line = [[UIView alloc] initWithFrame:linerect];
            line.backgroundColor = HexColor(@"f3f3f3");
            [tranView addSubview:line];
            return tranView;
        }
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.backTableView) {
        if (USERMANNGER.isLogin) {
            return 105;
        }else{
            return 50;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.backTableView) {
        return  USERMANNGER.isLogin ? 23 : 70;
    }else{
        return 42;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.backTableView) {
        
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        BB_RankListModel * model = USERMANNGER.allCoinArray[indexPath.row];
        self.headerView.model = nil;
        self.coincode = model.coincode;
        self.gCoincode = model.gCoincode;
        [self loadData];
        [self popMenue];
        [self setupdateLeftBtnCouncode:self.coincode gCoincode:self.gCoincode];
        [self updateHeaderView:model];
        self.listmodel = model;
    }
}
- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView {
    NSLog(@"identifier:%@",slideMenu.identifier);
    if (slideMenu.direction == SLSlideMenuDirectionLeft) {
        UILabel * coinLabel = [STUIKitTools lableFont:16 textColor:HexColor(@"505E87") text:@"玩家网"];
        coinLabel.frame = CGRectMake(15, 22 + (SafeAreaNavHeight), SCREEN_WIDTH - 36, 17);
        coinLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        [menuView addSubview:coinLabel];
        
        UIButton * btn = [STUIKitTools buttonImage:@"Three" action:@selector(popMenue) target:self];
        btn.frame = CGRectMake(SCREEN_WIDTH - 36 - 46, 22, 36, 32);
        btn.centerY = coinLabel.centerY;
        [menuView addSubview:btn];
        if (USERMANNGER.allCoinArray.count) {
            BB_BasicTableView * table = [self creatTabele];
            table.frame = CGRectMake(0, coinLabel.maxY + 10, SCREEN_WIDTH - 36, SCREEN_HEIGHT - coinLabel.maxY - 10);
            [menuView addSubview:table];
        }else{
            [BB_BasicHandle allMarketTradeDatasortSucess:^(id json) {
                BB_BasicTableView * table = [self creatTabele];
                table.frame = CGRectMake(0, coinLabel.maxY + 10, SCREEN_WIDTH - 36, SCREEN_HEIGHT - coinLabel.maxY - 10);
                [table reloadData];
            } fail:^(id json) {
                
            }];
        }
    }
}
#pragma mark - method
// 登陆成功更新UI
- (void)updateHeaderUI{
    LRLog(@"我是通知");
    [self loadData];
    [self.headerView upDateLoginBtn];
}
- (void)updateHeaderView:(BB_RankListModel *)model{
    self.headerView.listModel = model;
}
- (void)loadAllCoins{
        [BB_BasicHandle allMarketTradeDatasortSucess:^(NSArray <BB_RankListModel *>* json) {
            self.coincode = USERMANNGER.allCoinArray[0].coincode;
            self.gCoincode = USERMANNGER.allCoinArray[0].gCoincode;
            self.listmodel = USERMANNGER.allCoinArray[0];
            [self setupdateLeftBtnCouncode:self.coincode gCoincode:self.gCoincode];
            [self updateHeaderView:json[0]];
            [self loadData];
        } fail:^(id json) {
            
        }];
}
- (void)setupdateLeftBtnCouncode:(NSString *)coincode gCoincode:(NSString *)gCoincode{
    NSString * title = [NSString stringWithFormat:@" %@/%@",[coincode uppercaseString],[gCoincode uppercaseString]];
    [_letfBtn setTitle:title forState:UIControlStateNormal];
    [_letfBtn sizeToFit];
}
- (void)upDateLineWithTag:(NSInteger)tag{
    [self.headerView upDateLineWithTag:tag];
}
- (BB_BasicTableView *)creatTabele{
    BB_BasicTableView * table = [STUIKitTools tableDelegate:self dataSource:self];
    [table registerNib:[UINib nibWithNibName:@"BB_HomeCell" bundle:nil] forCellReuseIdentifier:@"BB_HomeCell"];
    table.backgroundColor = [UIColor whiteColor];
    return table;
}
- (void)setUpUI{
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"Buttons"] forState:0];
    [leftBtn setTitle:@"  --/--" forState:0];
    leftBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:21];
    [leftBtn setTitleColor:HexColor(@"505187") forState:0];
    [leftBtn addTarget:self action:@selector(leftSliderMenue) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    _letfBtn = leftBtn;
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"Quotes"] forState:0];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    NSDictionary *dic = @{@"key":@"test"};
    _dic = dic;
    
   [self.view addSubview:self.backTableView];
    [self.backTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.left.right.bottom.equalTo(self.view);
        make.bottom.mas_equalTo( -SafeAreaHomeBottomHeight);
    }];
    self.backTableView.tableHeaderView = self.headerView;
}

- (void)leftSliderMenue{
     [SLSlideMenu slideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuDirectionLeft slideOffset:SCREEN_WIDTH - 36 allowSwipeCloseMenu:YES aboveNav:YES identifier:@"bottom1" object:_dic];
}
- (void)rightClick{
    BB_QuoDetailController *detail = [[BB_QuoDetailController alloc] init];
    detail.isTranPush = YES;
    detail.listModel = self.listmodel;
    detail.code = self.coincode;
    detail.gcode = self.gCoincode;
    detail.sellBuyModel = self.headerView.model;
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)popMenue{
     [SLSlideMenu dismiss];
}
- (void)loadData{
    [BB_BasicHandle entrustByMarket:self.coincode gCoincode:self.gCoincode sucess:^(id json) {
        self.headerView.model = json;
    } fail:^(id json) {
        
    }];
    
    [BB_BasicHandle queryPeddingEntrust:self.coincode gCoincode:self.gCoincode sucess:^(id json) {
        self.dataArray = json;
        [self.backTableView reloadData];
    } fail:^(id json) {
        
    }];
    [self loadPersonRichCode:self.coincode];// 获取个人财产
}
// 获取个人财产
- (void)loadPersonRichCode:(NSString *)code{
    [USERMANNGER getCurretnCoinRich:code sucess:^(BB_AssetModel *model) {
        self.headerView.assetModel = model;
    }];
}
#pragma mark- get set
- (BB_TransactionHeaderView *)headerView{
    if (!_headerView) {
        LRWeakSelf(self)
        _headerView = [[BB_TransactionHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 350);
        _headerView.backgroundColor = [UIColor whiteColor];
        _headerView.buyorsellBlock = ^(NSInteger index) {
            if (index == 100) {
                [weakself loadPersonRichCode:weakself.coincode];
            }else{
                [weakself loadPersonRichCode:weakself.gCoincode];
            }
        };
        _headerView.clickBlock = ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入支付密码" preferredStyle:UIAlertControllerStyleAlert];
            //增加取消按钮
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            //增加确定按钮；
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //获取第1个输入框；
                UITextField *userNameTextField = alertController.textFields.firstObject;
                _tranPwd = userNameTextField.text;

                [BB_BasicHandle subEntrust:weakself.tranPwd coincode:weakself.coincode gCoincode:weakself.gCoincode price:weakself.headerView.price num:weakself.headerView.num type:weakself.headerView.type sucess:^(id json) {
                    [HUDTools shoInfoWithStatus:@"提交成功"];
                    [weakself loadData];
                } fail:^(id json) {
                    
                }];
            }]];
            //定义第一个输入框；
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"请输入交易";
                textField.secureTextEntry = YES;
            }];
            [weakself presentViewController:alertController animated:true completion:nil];
        };
    }
    return _headerView;
}
- (BB_BasicTableView *)backTableView{
    if (!_backTableView) {
        LRWeakSelf(self)
        _backTableView = [STUIKitTools tableDelegate:self dataSource:self];
        [_backTableView registerNib:[UINib nibWithNibName:@"BB_TransEntrustCell" bundle:nil] forCellReuseIdentifier:@"BB_TransEntrustCell"];
        _backTableView.tableType = TableViewTypeRefreshHeader;
        _backTableView.backgroundColor = [UIColor whiteColor];
        _backTableView.pageFooterBlock = ^(int page, Competion block) {
            [weakself loadAllCoins];
        };
        
    }
    return _backTableView;
}
@end
