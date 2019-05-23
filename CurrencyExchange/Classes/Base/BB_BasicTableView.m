//
//  BB_BasicTableView.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BB_BasicTableView.h"

@interface BB_BasicTableView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, assign) int page;

@property (nonatomic, assign) BOOL isPull;


@end
@implementation BB_BasicTableView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        self.tableType = TableViewTypeStatic;
        self.page = 0;
        self.isPull = YES;
        [self configRefresh]; // 设置刷新
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.backgroundColor = BACKGROUNDCOLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.emptyText = @"";
       
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedRowHeight = 0;
    };
    return self;
}
#pragma mark - delegate datasouce
#pragma mark empty
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"arrow.png"];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = self.emptyText;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:18],
                                 NSForegroundColorAttributeName:HexColor(@"666666"),
                                 NSParagraphStyleAttributeName:paragraph
                                 };
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    
    return  -100;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}
#pragma mark - privateMethod
// 设置个人刷新
- (void)configRefresh{
    switch (self.tableType) {
        case TableViewTypeStatic:
            break;
        case TableViewTypeRefreshFooterHeader:
            self.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
            self.emptyDataSetSource = self;
            self.emptyDataSetDelegate = self;
            [self.mj_header beginRefreshing];
            break;
        case TableViewTypeRefreshHeader:
            self.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
            [self.mj_header beginRefreshing];
            break;
        default:
            break;
    }
}
- (void)loadNewData{
    self.isPull = YES;
    self.page = 0;
    [self loadDataPage];
}
- (void)loadMoreData{
    self.isPull = NO;
    self.page++;
    [self loadDataPage];
};
- (void)loadDataPage{
    LRWeakSelf(self)
        if (self.pageFooterBlock) {
            self.pageFooterBlock(self.page, ^(NSArray *dataArray) {
                if (weakself.isPull) {
                    [self.dataArray removeAllObjects];
                }else if(!weakself.isPull &&
                         dataArray.count == 0){
                    // 3.GCD
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        [weakself.mj_footer endRefreshingWithNoMoreData];
                    });
                }
                [self.dataArray addObjectsFromArray:dataArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    [weakself reloadData];
                });
            });
        };
    [self endRefresh];
}
- (void)endRefresh{
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
#pragma mark - get set
- (void)setTableType:(TableViewType)tableType{
    _tableType = tableType;
    [self configRefresh];
};
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
