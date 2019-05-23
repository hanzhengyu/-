//
//  BB_ImagePickViewController.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/28.
//  Copyright © 2018年 崔博. All rights reserved.
//

typedef void(^FinshChooseImageBlock)(UIImage *image);
typedef NS_ENUM(NSUInteger, BB_UIImagePickerControllerSourceType) {
    BB_UIImagePickerControllerSourceTypePhotoLibrary, // 本地相册
    BB_UIImagePickerControllerSourceTypeCamera // 相机
};
#import <UIKit/UIKit.h>

@interface BB_ImagePickViewController : UIImagePickerController
@property (nonatomic, assign) BB_UIImagePickerControllerSourceType bb_sourcetype;
@property (nonatomic, copy) FinshChooseImageBlock imageBlock;
@end
