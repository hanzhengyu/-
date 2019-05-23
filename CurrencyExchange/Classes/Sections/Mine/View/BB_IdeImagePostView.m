//
//  BB_IdeImagePostView.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_IdeImagePostView.h"
#import <TBActionSheet/TBAlertController.h>
#import "BB_ImagePickViewController.h"
#import "BB_CommitImageController.h"
@interface BB_IdeImagePostView()
@property (nonatomic, strong) TBAlertController * zhengAltercontroller;
@property (nonatomic, strong) TBAlertController * fanAltercontroller;
@property (nonatomic, strong) TBAlertController *  shouchiAltercontroller;
@property (nonatomic, strong) BB_ImagePickViewController * zhengPickImageController;
@property (nonatomic, strong) BB_ImagePickViewController * fanPickImageController;
@property (nonatomic, strong) BB_ImagePickViewController * shouchiPickImageController;
@end
@implementation BB_IdeImagePostView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        LRWeakSelf(self)
        
        self.zhengPickImageController = [[BB_ImagePickViewController alloc] init];
        self.zhengPickImageController.imageBlock = ^(UIImage *image) {
            [HttpTool uploadImagePhotos:image success:^(id json) {
                _zhengUrl = json;
            } failure:^(NSError *error) {
                
            } progress:^(CGFloat progress) {
                
            }];
         
        };
        _zhengAltercontroller = [TBAlertController alertControllerWithTitle:@"请选择照片 " message:@"" preferredStyle:TBAlertControllerStyleActionSheet];
        TBAlertAction *clickme = [TBAlertAction actionWithTitle:@"相册" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.zhengPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypePhotoLibrary;
            [weakself.viewController presentViewController:weakself.zhengPickImageController animated:YES completion:nil];
        }];
        TBAlertAction *camera = [TBAlertAction actionWithTitle:@"照相机" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.zhengPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypeCamera;
            [weakself.viewController presentViewController:weakself.zhengPickImageController animated:YES completion:nil];
        }];
        
        TBAlertAction *cancel = [TBAlertAction actionWithTitle:@"取消" style: TBAlertActionStyleCancel handler:^(TBAlertAction * _Nonnull action) {
            
        }];
        
        [_zhengAltercontroller addAction:clickme];
        [_zhengAltercontroller addAction:camera];
        [_zhengAltercontroller addAction:cancel];
        
        self.fanPickImageController = [[BB_ImagePickViewController alloc] init];
        _fanAltercontroller = [TBAlertController alertControllerWithTitle:@"请选择照片 " message:@"" preferredStyle:TBAlertControllerStyleActionSheet];
        TBAlertAction *clickme1 = [TBAlertAction actionWithTitle:@"相册" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.fanPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypePhotoLibrary;
            [weakself.viewController presentViewController:weakself.fanPickImageController animated:YES completion:nil];
        }];
        TBAlertAction *camera1 = [TBAlertAction actionWithTitle:@"照相机" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.fanPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypeCamera;
            [weakself.viewController presentViewController:weakself.fanPickImageController animated:YES completion:nil];
        }];
        
        TBAlertAction *cancel1 = [TBAlertAction actionWithTitle:@"取消" style: TBAlertActionStyleCancel handler:^(TBAlertAction * _Nonnull action) {
            
        }];
        [_fanAltercontroller addAction:clickme1];
        [_fanAltercontroller addAction:camera1];
        [_fanAltercontroller addAction:cancel1];
        
        self.shouchiPickImageController = [[BB_ImagePickViewController alloc] init];
        _shouchiAltercontroller = [TBAlertController alertControllerWithTitle:@"请选择照片 " message:@"" preferredStyle:TBAlertControllerStyleActionSheet];
        TBAlertAction *clickme2 = [TBAlertAction actionWithTitle:@"相册" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.shouchiPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypePhotoLibrary;
            [weakself.viewController presentViewController:weakself.shouchiPickImageController animated:YES completion:nil];
        }];
        TBAlertAction *camera2 = [TBAlertAction actionWithTitle:@"照相机" style: TBAlertActionStyleDefault handler:^(TBAlertAction * _Nonnull action) {
            weakself.shouchiPickImageController.bb_sourcetype = BB_UIImagePickerControllerSourceTypeCamera;
            [weakself.viewController presentViewController:weakself.shouchiPickImageController animated:YES completion:nil];
        }];
        
        TBAlertAction *cancel2 = [TBAlertAction actionWithTitle:@"取消" style: TBAlertActionStyleCancel handler:^(TBAlertAction * _Nonnull action) {
            
        }];
        [_shouchiAltercontroller addAction:clickme2];
        [_shouchiAltercontroller addAction:camera2];
        [_shouchiAltercontroller addAction:cancel2];
        [self addSubviews];
    }
    return self;
}
#pragma mark - method
- (void)chooserImage{
    
}
- (void)addSubviews{
    UILabel *zhengLabel = [self creatLabeTitl:@"正面照"];
    UILabel *fanLabel = [self creatLabeTitl:@"反面照"];
    UILabel *shouchiLabel = [self creatLabeTitl:@"手持照"];
    UIButton *zhengbtn = [self creatBnt:1];
    UIButton *fanbtn = [self creatBnt:2];
    UIButton *shouchibtn = [self creatBnt:3];
    _commitBtn = [STUIKitTools buttonTitle:@"提交" font:18 action:nil titleColor:HexColor(@"ffffff") target:self];
    [_commitBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [self addSubview:zhengbtn];
    [self addSubview:zhengLabel];
    [self addSubview:fanbtn];
    [self addSubview:fanLabel];
     [self addSubview:shouchibtn];
     [self addSubview:shouchiLabel];
    [self addSubview:_commitBtn];
    
    [zhengbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(Ration(240));
        make.height.mas_equalTo(Ration(105));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.zhengPickImageController.imageBlock = ^(UIImage *image) {
        [zhengbtn setBackgroundImage:image forState:UIControlStateNormal];
        [HttpTool uploadImagePhotos:image success:^(id json) {
            _zhengUrl = json;
        } failure:^(NSError *error) {
            
        } progress:^(CGFloat progress) {
            
        }];
    };
    [zhengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhengbtn.mas_bottom).offset(10);
        make.left.equalTo(zhengbtn.mas_left);
    }];
    [fanbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhengLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(Ration(240));
        make.height.mas_equalTo(Ration(105));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.fanPickImageController.imageBlock = ^(UIImage *image) {
        [fanbtn setBackgroundImage:image forState:UIControlStateNormal];
        [HttpTool uploadImagePhotos:image success:^(id json) {
            _fanzhengUrl = json;
        } failure:^(NSError *error) {
            
        } progress:^(CGFloat progress) {
            
        }];
       
    };
    [fanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fanbtn.mas_bottom).offset(10);
        make.left.equalTo(fanbtn.mas_left);
    }];
    
    [shouchibtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fanLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(Ration(240));
        make.height.mas_equalTo(Ration(105));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    self.shouchiPickImageController.imageBlock = ^(UIImage *image) {
        [shouchibtn setBackgroundImage:image forState:UIControlStateNormal];
        [HttpTool uploadImagePhotos:image success:^(id json) {
            _shouchizhengUrl = json;
        } failure:^(NSError *error) {
            
        } progress:^(CGFloat progress) {
            
        }];
     
    };
    [shouchiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouchibtn.mas_bottom).offset(6);
        make.left.equalTo(fanbtn.mas_left);
    }];
    [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouchiLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(Ration(275));
        make.height.mas_equalTo(Ration(50));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}

- (void)postImage:(UIButton *)sender{
    //  [self.viewController presentViewController:_altercontroller animated:YES completion:nil];
    if (sender.tag == 1) {
        [self.viewController presentViewController:_zhengAltercontroller animated:YES completion:nil];
    }
    if (sender.tag == 2) {
        [self.viewController presentViewController:_fanAltercontroller animated:YES completion:nil];
        
    }
    if (sender.tag == 3) {
        [self.viewController presentViewController:_shouchiAltercontroller animated:YES completion:nil];
        
    }
}

- (UILabel *)creatLabeTitl:(NSString *)title{
    UILabel * labe = [[UILabel alloc] init];
    labe.font = [UIFont fontWithName:@"PingFangSC-Light" size:19];
    labe.textColor = HexColor(@"333333");
    labe.text = title;
    return labe;
}

- (UIButton *)creatBnt:(int)tag{
    UIButton *btn = [STUIKitTools buttonImage:@"xiangji" action:@selector(postImage:) target:self];
    btn.layer.borderWidth = 1;
    btn.tag = tag;
    btn.layer.borderColor = [UIColor colorWithRed:239/255.0 green:236/255.0 blue:236/255.0 alpha:0.9].CGColor;
    btn.layer.cornerRadius = 5;
    return btn;
}
@end

