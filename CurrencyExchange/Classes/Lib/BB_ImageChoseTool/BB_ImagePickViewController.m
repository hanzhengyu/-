//
//  BB_ImagePickViewController.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "BB_ImagePickViewController.h"

@interface BB_ImagePickViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation BB_ImagePickViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bb_sourcetype = BB_UIImagePickerControllerSourceTypePhotoLibrary;
        self.delegate = self;
    };
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (self.imageBlock) {
         UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        self.imageBlock(image);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
// 选择类型
- (void)setBb_sourcetype:(BB_UIImagePickerControllerSourceType)bb_sourcetype{
    switch (bb_sourcetype) {
        case BB_UIImagePickerControllerSourceTypeCamera:
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case BB_UIImagePickerControllerSourceTypePhotoLibrary:
            self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
}
@end
