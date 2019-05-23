//
//  PopOutView.m
//  MJPopToolDemo
//
//  Created by Mengjie.Wang on 2016/06/22.
//  Copyright © 2016年 王梦杰. All rights reserved.
//

#import "PopOutView.h"

@interface PopOutView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *closeButton;




@end

@implementation PopOutView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"red_packge_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
        
        _updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateBtn setBackgroundImage:[UIImage imageNamed:@"fxxbb_icon"] forState:UIControlStateNormal];
        [self addSubview:_updateBtn];
        _versionUpdateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_versionUpdateBtn setBackgroundImage:[UIImage imageNamed:@"lksj_icon"] forState:UIControlStateNormal];
       
        [self addSubview:_versionUpdateBtn];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _imageView.image = [UIImage imageNamed:@"begx_bg"];
    _updateBtn.frame = CGRectMake(40, 170, 64, 20);
    _versionUpdateBtn.frame = CGRectMake(140, 170, 64, 20);

    
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

- (void)close {
    if (_dismissBlock) {
        _dismissBlock(self);
    }
}

@end
