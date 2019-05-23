//
//  STUIKitTools.h
//  CuiBoStore
//
//  Created by 崔博 on 16/11/28.
//  Copyright © 2016年 崔博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BB_BasicTableView.h"
@interface STUIKitTools : NSObject

// 按钮
+ (UIButton *)buttonTitle:(NSString *)title font:(int)font action:(SEL)action titleColor:(UIColor *)titleColor target:(id)target;
+ (UIButton *)buttonImage:(NSString *)image action:(SEL)action target:(id)target;
+ (UIButton *)buttonImage:(NSString *)image title:(NSString *)title font:(int)font action:(SEL)action titleColor:(UIColor *)titleColor target:(id)target;
// table
+ (UITableView *)tableCreat;

// label
+ (UILabel *)labelFont:(int)font;
+ (UILabel *)lableFont:(int)font textColor:(UIColor *)textColor;
+ (UILabel *)lableFont:(int)font textColor:(UIColor *)textColor text:(NSString *)text;

// textfield
+ (UITextField *)textFileHolder:(NSString *)holder style:(UITextBorderStyle)style;

// talbe
+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource;
+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource nibCell:(NSString *)nibCell ider:(NSString *)ider;
+ (BB_BasicTableView *)tableDelegate:(id)delegate dataSource:(id)dataSource classCell:(id)classCell ider:(NSString *)ider;
// imagevie
+ (UIImageView *)imageView:(NSString *)image;
@end
