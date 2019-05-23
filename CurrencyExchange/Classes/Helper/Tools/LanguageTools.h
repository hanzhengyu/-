//
//  LanguageTools.h
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/5.
//  Copyright © 2018年 崔博. All rights reserved.
//
typedef NS_ENUM(NSUInteger, LanguageType) {
    LanguageChineseHans = 0,
    LanguageChineseHant,
    LanguageEnglish,
};

#import <Foundation/Foundation.h>

@interface LanguageTools : NSObject

@property (nonatomic, strong, readonly) NSArray * languageList;
@property (nonatomic, assign) LanguageType languageType;
SingletonH(LanguageTools)

- (NSString *)changeLanguageKey:(NSString *)key;
@end
