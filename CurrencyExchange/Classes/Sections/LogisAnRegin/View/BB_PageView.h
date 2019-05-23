//
//  BB_PageView.h
//  CurrencyExchange
//
//  Created by 张了了 on 2018/3/9.
//  Copyright © 2018年 崔博. All rights reserved.
//
typedef void(^TextBlock)(NSString *text);
typedef void(^CodeClickBlock)();

typedef enum : NSUInteger {
    PageViewDefault = 0,
    PageViewPhone,
    PageViewEmail,
    PageViewUserName,
    PageViewPwd,
    PageViewCode,
} PageViewType;

typedef enum : NSUInteger {
    TextFileLayerStyleDefault,
    TextFileLayerStyleCorner,
    TextFileLayerStyleLine,
} TextFileLayerStyle;


#import <UIKit/UIKit.h>
@interface BB_PageView : UIView
@property (nonatomic, copy,readonly) NSString * fieldText;
@property (nonatomic, assign) PageViewType pageType;
@property (nonatomic, assign) TextFileLayerStyle textFieldType;
@property (nonatomic, copy) NSString * placeHoder;
@property (nonatomic, copy) TextBlock textBlock;
@property (nonatomic, copy) CodeClickBlock codeblock;
@property (nonatomic, assign) BOOL codeHidden;
@property (nonatomic, assign) BOOL isScretBtn;

- (instancetype)initWithFrame:(CGRect)fram titles:(NSArray *)titles;
- (void)clear;
@end
