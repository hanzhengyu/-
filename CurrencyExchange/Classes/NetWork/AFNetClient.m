//
//  AFNetClient.m
//  CurrencyExchange
//
//  Created by 123 on 2018/3/27.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "AFNetClient.h"
static NSString * kBaseUrl = BASEURL;
@implementation AFHttpClient
+ (instancetype)sharedClient {
    
    static AFHttpClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        client = [[AFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:kBaseUrl] sessionConfiguration:configuration];
        //接收参数类型
        client.responseSerializer.acceptableContentTypes =
        [NSSet setWithObjects:@"application/json",
                              @"text/html",
                              @"text/json",
                              @"text/javascript",
                              @"text/plain",
                              @"image/gif",
                              @"application/x-www-form-urlencoded", nil];
        //设置超时时间
        client.requestSerializer.timeoutInterval = 30;
        //安全策略
        client.securityPolicy = [AFSecurityPolicy defaultPolicy];
        client.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSString * version = [NSString stringWithFormat:@"vbourse/%@ ios",[NSString curentVersion]];
        [client.requestSerializer setValue:version forHTTPHeaderField:@"User-Agent"];
        [client.requestSerializer setValue:[NSString stringWithUUID] forHTTPHeaderField:@"User-UDID"];
        [client.requestSerializer setValue:[UserManngerTool share].user.token forHTTPHeaderField:@"access_token"];
    });
    
    return client;
}

@end
