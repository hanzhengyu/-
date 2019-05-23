//
//  AppDelegate.m
//  CurrencyExchange
//
//  Created by 康程 on 2018/3/1.
//  Copyright © 2018年 康程. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+ChooseRootDelegate.h"
#import <UMCommon/UMCommon.h>
#import "PopOutView.h"
#import "MJPopTool.h"

@interface AppDelegate ()
@property (nonatomic, strong) PopOutView *popOutView;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self chosetRootViewController];
    [self confitUM];
    [self VersonUpdate];
    
#ifdef DEBUG
    
            // for iOS
    
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
        // for tvOS
    
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle"] load];
    
        // for masOS
    
        [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle"] load];
    
#else
    
        
    
#endif
  
    return YES;
}
- (void)confitUM{
    [UMConfigure initWithAppkey:UM_U_APPKEY channel:nil];
}

-(void)VersonUpdate{
    
    [self performSelectorOnMainThread:@selector(receiveData:) withObject:@{@"version":@"0.1.1"} waitUntilDone:NO];
//    //定义的app的地址
//    NSString *urld = [NSString stringWithFormat:@"%@secret/appVersionUpdate",BASEURL];
//    //网络请求app的信息，主要是取得我说需要的Version
//    NSURL *url = [NSURL URLWithString:urld];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval:10];
//    [request setHTTPMethod:@"POST"];
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSMutableDictionary *receiveStatusDic=[[NSMutableDictionary alloc]init];
//        if (data) {
//            //data是有关于App所有的信息
//            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//             // NSLog(@"receiveDic=========%@",receiveDic);
//            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
//
//                [receiveStatusDic setValue:@"1" forKey:@"status"];
//                [receiveStatusDic setValue:[[[receiveDic valueForKey:@"results"] objectAtIndex:0] valueForKey:@"version"]   forKey:@"version"];
//
//                //请求的有数据，进行版本比较
//              //  [self performSelectorOnMainThread:@selector(receiveData:) withObject:receiveStatusDic waitUntilDone:NO];
//            }else{
//
//                [receiveStatusDic setValue:@"-1" forKey:@"status"];
//            }
//        }else{
//            [receiveStatusDic setValue:@"-1" forKey:@"status"];
//        }
//    }];
//    [task resume];
}


-(void)receiveData:(id)sender
{
    //获取APP自身版本号
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    NSArray *localArray = [localVersion componentsSeparatedByString:@"."];
    
    NSArray *versionArray = [sender[@"version"] componentsSeparatedByString:@"."];
    if ((versionArray.count == 3) && (localArray.count == versionArray.count)) {
        
        if ([localArray[0] intValue] <  [versionArray[0] intValue]) {
            [self addPopView];
        }else if ([localArray[0] intValue]  ==  [versionArray[0] intValue]){
            if ([localArray[1] intValue] <  [versionArray[1] intValue]) {
                [self addPopView];
            }else if ([localArray[1] intValue] ==  [versionArray[1] intValue]){
                if ([localArray[2] intValue] <  [versionArray[2] intValue]) {
                    [self addPopView];
                }
            }
        }
    }
}




-(void)addPopView  {
    self.window.alpha = 0.6;
    if (!_popOutView) {
        _popOutView = [[PopOutView alloc] init];
        _popOutView.frame = CGRectMake(0, 0, 250, 213);
        _popOutView.dismissBlock = ^(PopOutView *popOutView) {
            [[MJPopTool sharedInstance] closeAnimated:YES];
        };
    }
    [_popOutView.updateBtn addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
    [_popOutView.versionUpdateBtn addTarget:self action:@selector(updateVersion) forControlEvents:UIControlEventTouchUpInside];
    [[MJPopTool sharedInstance] popView:self.popOutView animated:YES];
}

-(void)updateVersion{
 //  NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E4%B8%80%E5%88%80%E5%8A%A9%E5%8C%BB/id1272004177?mt=8"];
  //  [[UIApplication sharedApplication]openURL:url];
}

@end
