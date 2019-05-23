//
//  BB_QuoDetailController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/23.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_QuoDetailController.h"
#import "BB_BuyInOrOutView.h"
#import "BB_QuoDetailHeaderView.h"
#import <MXSegmentedPager/MXSegmentedPager.h>
#import "BB_TransactionController.h"
#import "BB_LabesView.h"
#import "BB_CompleteTranCell.h"
@interface BB_QuoDetailController ()<MXSegmentedPagerDelegate, MXSegmentedPagerDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BB_BuyInOrOutView * outView;
@property (nonatomic, strong) BB_QuoDetailHeaderView * detailHeaderView;
@property (nonatomic, strong) MXSegmentedPager  * segmentedPager;
@property (nonatomic, strong) BB_BasicTableView         * depthTable;
@property (nonatomic, strong) BB_BasicTableView        * dealTabel;

@property (nonatomic, strong) BB_SellAndBuyListModel * depthModel;
@property (nonatomic, strong) NSArray        * dealArray;
@end

@implementation BB_QuoDetailController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isTranPush = NO;
        self.code = @"";
        self.gcode = @"";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.titleView = [STUIKitTools lableFont:22 textColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"%@/%@",[self.code uppercaseString],[self.gcode uppercaseString]]];;
    self.detailHeaderView.gcode = self.gcode;
    self.detailHeaderView.code = self.code;
    self.detailHeaderView.listMoodel = self.listModel;
    [self loadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark <MXSegmentedPagerDelegate>
- (CGFloat)heightForSegmentedControlInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 30.f;
}
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithTitle:(NSString *)title {
    NSLog(@"%@ page selected.", title);
}
- (void)segmentedPager:(MXSegmentedPager *)segmentedPager didScrollWithParallaxHeader:(MXParallaxHeader *)parallaxHeader {
    NSLog(@"progress %f", parallaxHeader.progress);
}
#pragma mark <MXSegmentedPagerDataSource>
- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
    return 1;
}
- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return @[@"成交"][index];
}
- (UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index {
    return @[  self.dealTabel][index];
}
#pragma mark <tableDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView == self.dealTabel ? self.dealArray.count : self.depthModel.buyList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.dealTabel) {
        BB_CompleteTranCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BB_CompleteTranCell"];
        cell.model = self.dealArray[indexPath.row];
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array;
    if (tableView == self.dealTabel) {
        NSString * price = [NSString stringWithFormat:@"价格(%@)",[self.code uppercaseString]];
        NSString * count = [NSString stringWithFormat:@"数量(%@)",[self.gcode uppercaseString]];
        array = @[@"时间",@"方向",price,count];
    }else{
        array = @[@"买盘  数量(ETH)",@"价格(USDF)",@"数量(ETH) 卖盘"];
    }
    BB_LabesView * labelsView = [[BB_LabesView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30) titles:array];
    labelsView.backgroundColor = RGBColor(59, 68, 88);
    return labelsView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - method
- (void)setUpUI{
    self.view.backgroundColor = RGBColor(28, 28, 32);
    [self.view addSubview:self.outView];
    
    [self.outView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
        make.height.mas_equalTo(65);
    }];
    UIButton *btn = [STUIKitTools buttonImage:@"back-black" action:@selector(pop) target:self];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.view addSubview:self.segmentedPager];
    // Parallax Header
    self.segmentedPager.parallaxHeader.view = self.detailHeaderView;
    [self.detailHeaderView layoutIfNeeded];
    self.segmentedPager.parallaxHeader.view = self.detailHeaderView;
    self.segmentedPager.parallaxHeader.mode = MXParallaxHeaderModeBottom;
    self.segmentedPager.parallaxHeader.height = 370;  // 此高度随便给的- -。。有空自己去量火币
    // Segmented Control customization
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.segmentedPager.segmentedControl.backgroundColor = self.view.backgroundColor;
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : RGBColor(87, 107, 137),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentedPager.backgroundColor = RGBColor(28, 28, 32);
    
}
#pragma mark - get set
- (void)loadData{
    // 买卖记录
    [BB_BasicHandle entrustByMarket:self.code gCoincode:self.gcode sucess:^(id json) {
        self.depthModel = json;
        [self.depthTable reloadData];
    } fail:^(id json) {
        
    }];
    
    [BB_BasicHandle queryTradeHistory:self.code gCoincode:self.gcode sucess:^(id json) {
        self.dealArray = json;
        [self.dealTabel reloadData];
    } fail:^(id json) {
        
    }];
}
- (void)setSellBuyModel:(BB_SellAndBuyListModel *)sellBuyModel{
    _sellBuyModel = sellBuyModel;
}
- (BB_BuyInOrOutView *)outView{
    if (!_outView) {
        LRWeakSelf(self)
        _outView = [[BB_BuyInOrOutView alloc] init];
        _outView.block = ^(NSInteger tag){
            if (weakself.isTranPush) {
                [weakself pop];
                return ;
            }
            [weakself.rt_navigationController popToRootViewControllerAnimated:NO complete:^(BOOL finished) {
                YKTabBarController * tabbarVC = ((YKTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController);
              //  LRLog(@"%@",tabbarVC.childViewControllers);
                tabbarVC.ykTabbar.seletedIndex = 3;
                RTRootNavigationController * nav = tabbarVC.childViewControllers[2];
                BB_TransactionController * tranVC = nav.rt_topViewController;
                tranVC.coincode = weakself.code;
                tranVC.listmodel = weakself.listModel;
                tranVC.gCoincode = weakself.gcode;
                [tranVC loadData];
                [tranVC setupdateLeftBtnCouncode:weakself.code gCoincode:weakself.gcode];
                [tranVC updateHeaderView:weakself.listModel];


            }];
        };
    }
    return _outView;
}
- (BB_QuoDetailHeaderView *)detailHeaderView{
    if (!_detailHeaderView) {
        _detailHeaderView = [[BB_QuoDetailHeaderView alloc] init];
    }
    return _detailHeaderView;
}
- (MXSegmentedPager *)segmentedPager {
    if (!_segmentedPager) {
        // Set a segmented pager below the cover
        _segmentedPager = [[MXSegmentedPager alloc] init];
        _segmentedPager.delegate    = self;
        CGRect rect = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight - 65 - SafeAreaBottomHeight);
        _segmentedPager.frame = rect;
        _segmentedPager.backgroundColor = self.view.backgroundColor;
        _segmentedPager.dataSource  = self;
        _segmentedPager.backgroundColor = [UIColor greenColor];
        _segmentedPager.segmentedControl.scorllerBackgroundColor = RGBColor(59, 68, 88);
    }
    return _segmentedPager;
}
- (BB_BasicTableView *)dealTabel{
    if (!_dealTabel) {
        _dealTabel = [STUIKitTools tableDelegate:self dataSource:self];
        _dealTabel.backgroundColor = RGBColor(59, 68, 88);
        [_dealTabel registerNib:[UINib nibWithNibName:@"BB_CompleteTranCell" bundle:nil] forCellReuseIdentifier:@"BB_CompleteTranCell"];
        _dealTabel.rowHeight = 23;
    }
    return _dealTabel;
}
- (BB_BasicTableView *)depthTable{
    if (!_depthTable) {
        _depthTable = [STUIKitTools tableDelegate:self dataSource:self];
        [_depthTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _depthTable.backgroundColor = RGBColor(59, 68, 88);
    }
    return _depthTable;
}
@end
