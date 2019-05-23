//
//  NSString+HiiUtil.h
//  Hiibook-2.0
//
//  Created by apple on 2017/7/3.
//  Copyright © 2017年 Hiibook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HiiUtil)

#pragma mark - valid

- (BOOL)isValidFileName;
- (BOOL)isValidEmailAddress;
- (BOOL)isValidMobileNumber;
- (BOOL)isURLRegular;

#pragma mark -- nil string
///返回非nil字符串，为nil则返回@""
- (NSString *)nonilString;

///判断是否为nil、NULL、@“”
+ (BOOL)isNil:(NSString *)string;

#pragma mark --- mails

- (NSString *)trimSubjectForMail;

- (NSString *)encrypt:(NSString *)email;

- (BOOL)folderDisplayNameFromDrafts;

- (BOOL)emailSuffixIsExist;

- (BOOL)isPublicMailbox;
+(SecKeyRef)addPublicKey:(NSString *)key;

#pragma mark --- APP沙盒路径
// APP Cache path
+ (NSString *)appDocumentDirectory;
+ (NSString *)appCachesDirectory;
+ (NSString *)appTempDirectory;
/////APP邮箱配置缓存路径
//+ (NSString *)appEmailConfigCachePath;
/////APP邮箱类型缓存路径
//+ (NSString *)appEmailTypeCachePath;

@end
