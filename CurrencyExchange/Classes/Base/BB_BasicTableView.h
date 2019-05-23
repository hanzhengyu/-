//
//  BB_BasicTableView.h
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/11/11.
//  Copyright © 2017年 app. All rights reserved.
//

typedef NS_ENUM(NSUInteger, TableViewType) {
    TableViewTypeStatic, // 静态表格
    TableViewTypeRefreshFooterHeader, // 头尾刷新
    TableViewTypeRefreshHeader, // 头部刷新
};

#import <UIKit/UIKit.h>
typedef void(^Competion)(NSArray *dataArray);
typedef void(^RefresnWithPageBlock)(int page,Competion block);
@interface BB_BasicTableView : UITableView
@property(nonatomic, assign) TableViewType tableType; // table 类型 默认静态
@property(nonatomic, copy) RefresnWithPageBlock pageFooterBlock;
@property(nonatomic, strong) NSMutableArray *dataArray; // 数据源

@property (nonatomic, copy) NSString * emptyImageName;
@property (nonatomic, copy) NSString * emptyText;
@end
