//
//  LanguageTools.m
//  CurrencyExchange
//
//  Created by 崔博 on 2018/3/5.
//  Copyright © 2018年 崔博. All rights reserved.
//

#import "LanguageTools.h"


@implementation LanguageTools
SingletonM(LanguageTools)
- (NSArray *)languageList{
    return @[ @{@"简体中文":@"zh-Hans"},
              @{@"繁體中文":@"zh-Hant"},
              @{@"English":@"en"}];
}

- (NSString *)changeLanguageKey:(NSString *)key{
    NSDictionary * dic = self.languageList[self.languageType];
    NSString *path = [[NSBundle mainBundle] pathForResource:[dic allValues][0] ofType:@"lproj"];
    NSString *labelString = [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:@"Localizable"];
    return labelString;
};

- (LanguageType)languageType{
    return LanguageChineseHans;
}

@end
