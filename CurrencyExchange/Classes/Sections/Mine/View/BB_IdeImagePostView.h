//
//  BB_IdeImagePostView.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/20.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BB_IdeImagePostView : UIView <UIImagePickerControllerDelegate>
@property(nonatomic,strong)UINavigationController *nav;
@property(nonatomic,strong)NSString *zhengUrl;
@property(nonatomic,strong)NSString *fanzhengUrl;
@property(nonatomic,strong)NSString *shouchizhengUrl;
@property(nonatomic,strong)UIButton *commitBtn;

@end
