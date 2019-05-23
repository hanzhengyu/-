//
//  BB_BasicTextField.m
//  XinHaoYouNi
//
//  Created by 刘春奇 on 2017/11/18.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BB_BasicTextField.h"

@implementation BB_BasicTextField

- (instancetype)init{
    if (self == [super init]) {
        self.background = [UIImage imageNamed:@"textFieldBGImage"];
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 161/2, 90/2)];
        self.leftView = leftView;
        self.leftViewMode=UITextFieldViewModeAlways;
    }
    return self;
}


@end
