//
//  BasiWebViewController.m
//  XinHaoYouNi
//
//  Created by 崔博 on 2017/12/12.
//  Copyright © 2017年 app. All rights reserved.
//

#import "BasiWebViewController.h"


@interface BasiWebViewController ()<UIWebViewDelegate>

@property WebViewJavascriptBridge* bridge;
@end

@implementation BasiWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView * webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
    UIEdgeInsets egge = UIEdgeInsetsMake(SafeAreaTopHeight, 0, -SafeAreaBottomHeight, 0);
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(egge);
    }];
    //初始化  WebViewJavascriptBridge
    if (_bridge) { return; }
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
   
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
   
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
   
}



/**
 JS  调用  OC
 */
-(void)pushDetailVC{
    /*
     含义：JS调用OC
     @param registerHandler 要注册的事件名称(比如这里我们为loginAction)
     @param handel 回调block函数 当后台触发这个事件的时候会执行block里面的代码
     */
    [_bridge registerHandler:@"push" handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
}
@end
