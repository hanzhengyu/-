//
//  User.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/2.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "User.h"

@implementation User

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.userid forKey:@"userid"];
     [aCoder encodeObject:self.version forKey:@"version"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.creditlevel forKey:@"creditlevel"];
    [aCoder encodeInteger:self.isral forKey:@"isral"];
    [aCoder encodeObject:self.invitecode forKey:@"invitecode"];
    
    [aCoder encodeInteger:self.exp forKey:@"exp"];
    [aCoder encodeObject:self.token forKey:@"token"];
    
    [aCoder encodeObject:self.csrf forKey:@"csrf"];
    [aCoder encodeObject:self.idcard forKey:@"idcard"];
    [aCoder encodeObject:self.truename forKey:@"truename"];
    
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        self.userid =[aDecoder decodeIntegerForKey:@"userid"];
        self.version =[aDecoder decodeObjectForKey:@"version"];
        self.username =[aDecoder decodeObjectForKey:@"username"];
        self.mobile =[aDecoder decodeObjectForKey:@"mobile"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.creditlevel =[aDecoder decodeObjectForKey:@"creditlevel"];
        self.isral =[aDecoder decodeIntegerForKey:@"isral"];
        self.invitecode=[aDecoder decodeObjectForKey:@"invitecode"];
        self.exp=[aDecoder decodeIntegerForKey:@"exp"];
        
        self.token=[aDecoder decodeObjectForKey:@"token"];
        self.csrf=[aDecoder decodeObjectForKey:@"csrf"];
        
        self.idcard =[aDecoder decodeObjectForKey:@"idcard"];
        
        self.truename = [aDecoder decodeObjectForKey:@"truename"];
    }
    
    return self;
    
}



- (BOOL)isBlindEmai{
    return self.email.length ? YES : NO;
}
- (BOOL)isBlindmobile{
    return self.mobile.length ? YES : NO;
}
@end
