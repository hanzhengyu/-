//
//  BB_CommitImageController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_CommitImageController.h"
#import "BB_IdeImagePostView.h"
#import <TBActionSheet/TBAlertController.h>

@interface BB_CommitImageController ()
@property (nonatomic, strong) BB_IdeImagePostView * postImageView;
@property (nonatomic, strong) TBAlertController * altercontroller;
@end

@implementation BB_CommitImageController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    [[AFHttpClient sharedClient].requestSerializer setValue:[UserManngerTool share].user.token forHTTPHeaderField:@"access_token"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请上传有效身份证";
    [self.view addSubview:self.postImageView];
    
    [self.postImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.top.mas_equalTo(SafeAreaTopHeight);
        make.bottom.mas_equalTo(-SafeAreaBottomHeight);
    }];
    [self.postImageView.commitBtn addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitBtn
{

    if (self.postImageView.zhengUrl == nil || self.postImageView.fanzhengUrl ==  nil|| self.postImageView.shouchizhengUrl ==  nil) {
        [UIAlertController Alert:self Tip:@"图片上传不全"];
    }
    else {
   NSDictionary *dic = @{@"enname":self.name,@"idcard":self.idCard,@"zimg":self.postImageView.shouchizhengUrl,@"ximg":self.postImageView.zhengUrl,@"yimg":self.postImageView.fanzhengUrl};
        [HttpTool postShowHudWithPath:@"secret/subUserIdInfo" params:dic success:^(id json) {
            NSLog(@"======%@",json[@"message"]);
            NSLog(@"======%@",json);
            [HUDTools dismiss];
           [self.navigationController popToRootViewControllerAnimated:YES];
        } failure:^(NSError *error) {
        }];
    }
}

- (BB_IdeImagePostView *)postImageView{
    if (!_postImageView) {
        _postImageView = [[BB_IdeImagePostView alloc] init];
        _postImageView.nav = self.navigationController;
    }
    return _postImageView;
}

@end
