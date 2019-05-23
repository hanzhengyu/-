//
//  BB_SettingViewController.m
//  CurrencyExchange
//
//  Created by company on 2018/4/19.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_SettingViewController.h"
#import "BB_settingCell.h"



@interface BB_SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BasicTableView *table;


@end

@implementation BB_SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
    [self addBtn];
}


-(void)addBtn {
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (user.isLogin) {
         loginBtn = [UIButton bb_btnNorTitle:@"退出登录"];
        loginBtn.hidden = NO;
    } else {
        loginBtn.hidden = YES;
    }
    loginBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn bb_buttonNormalBackImage:@"next" diasbleImage:@"nextc"];
    loginBtn.enabled = YES;
    loginBtn.frame = CGRectMake(50,SCREEN_HEIGHT - SafeAreaBottomHeight - 50 - 157, SCREEN_WIDTH - 100, 50);
    [self.view addSubview:loginBtn];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BB_settingCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"BB_settingCell"];
      mineCell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    
    mineCell.version.text = localVersion;
    return mineCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

-(void)login:(UIButton *)btn
{
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
 
    if (user.isLogin == 1) {
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        user.isLogin = NO;
        user.user.token = @"";
        [user saveUserData];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
     [USERMANNGER presenLogin];
    }

}

- (void)setUPUI{
    self.title = @"设置";
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.height.mas_equalTo(100);
        make.left.right.mas_equalTo(0);
    }];
    
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
        [_table registerNib:[UINib nibWithNibName:@"BB_settingCell" bundle:nil] forCellReuseIdentifier:@"BB_settingCell"];
    }
    return _table;
}



@end
