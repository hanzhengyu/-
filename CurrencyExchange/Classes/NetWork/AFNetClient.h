//
//  AFNetClient.h
//  CurrencyExchange
//
//  Created by 123 on 2018/3/27.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHttpClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
