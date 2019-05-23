//
//  NSString+HiiUtil.m
//  Hiibook-2.0
//
//  Created by apple on 2017/7/3.
//  Copyright © 2017年 Hiibook. All rights reserved.
//

#import "NSString+HiiUtil.h"
#import "MALRSACrypto.h"

static NSHashTable *globalHashTable = nil;
static NSHashTable *globalDraftHashTable = nil;
static NSHashTable *suffixEmailHashTable = nil;
static NSHashTable *publicMailboxHashTable = nil;

@implementation NSString (HiiUtil)

#pragma mark - validate file name, email, mobile

- (BOOL)isValidFileName
{
    NSCharacterSet* characterSet = [NSCharacterSet characterSetWithCharactersInString:@"\\/:*?\"<>|"];
    NSRange range = [self rangeOfCharacterFromSet:characterSet];
    return range.location == NSNotFound;
}

- (BOOL)isValidEmailAddress
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailPredicate evaluateWithObject:self];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
- (BOOL)isValidMobileNumber
{
    //手机号以13，14，15，17，18开头，九个 \d 数字字符
    NSString *phoneRegex = @"^((13)|(14)|(15)|(17)|(18))\\d{9}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phonePredicate evaluateWithObject:self];
}
//url
- (BOOL)isURLRegular{
    NSString *urlRegular = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegular];
    return [urlPredicate evaluateWithObject:self];
}

#pragma mark -- nil string
///返回非nil字符串，为nil则返回@""
- (NSString *)nonilString
{
    return self ? self : @"";
}

///判断是否为nil、NULL、@“”
+ (BOOL)isNil:(NSString *)string
{
    BOOL isNil = NO;
    if (!string)
    {
        isNil = YES;
    }
    else if ([string isKindOfClass:[NSString class]] && [string isEqualToString:@""])
    {
        isNil = YES;
    }
    else if ([string isEqual:[NSNull null]])
    {
        isNil = YES;
    }
    
    return isNil;
}

#pragma mark --- mails

- (NSString *)trimSubjectForMail
{
    if (!globalHashTable) {
        NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        [hashTable addObject:@"fw:"];
        [hashTable addObject:@"fw："];
        [hashTable addObject:@"fwd:"];
        [hashTable addObject:@"fwd："];
        [hashTable addObject:@"re:"];
        [hashTable addObject:@"re："];
        [hashTable addObject:@"reply:"];
        [hashTable addObject:@"reply："];
        [hashTable addObject:@"答复:"];
        [hashTable addObject:@"答复："];
        [hashTable addObject:@"答复全部:"];
        [hashTable addObject:@"答复全部："];
        [hashTable addObject:@"回复:"];
        [hashTable addObject:@"回复："];
        [hashTable addObject:@"回复全部:"];
        [hashTable addObject:@"回复全部："];
        [hashTable addObject:@"转发:"];
        [hashTable addObject:@"转发："];
        [hashTable addObject:@"撤回:"];
        [hashTable addObject:@"撤回："];
        [hashTable addObject:@"撤回全部:"];
        [hashTable addObject:@"撤回全部："];
        [hashTable addObject:@"撤消:"];
        [hashTable addObject:@"撤消："];
        [hashTable addObject:@"撤消全部:"];
        [hashTable addObject:@"撤消全部："];
        
        globalHashTable = hashTable;
    }
    //    NSString *themeStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    int start = 0;
    NSUInteger length = self.length;
    for (int index = 0; index < length; index++) {
        NSString *str = [self substringWithRange:NSMakeRange(index, 1)];
        if ([str compare:@":"] == NSOrderedSame || [str compare:@"："] == NSOrderedSame) {
            NSString *temp = [self substringWithRange:NSMakeRange(start, index - start + 1)];
            if ([globalHashTable containsObject:[temp lowercaseString]]) {
                start = index + 1;
            }
        }
    }
    
    if (start > 0 && start < length) {
        return [self substringWithRange:NSMakeRange(start, length - start)];
    } else if (start >= length) {
        return @"";
    }
    return self;
}


- (BOOL)folderDisplayNameFromDrafts
{
    BOOL isDrafts = NO;
    if (!globalDraftHashTable) {
        NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        [hashTable addObject:@"草稿箱"];
        [hashTable addObject:@"本地草稿箱"];
        [hashTable addObject:@"草稿"];
        globalDraftHashTable = hashTable;
    }
    if ([globalDraftHashTable containsObject:self]) {
        isDrafts = YES;
    }
    return isDrafts;
}

- (BOOL)emailSuffixIsExist{
    BOOL isExist = NO;
    if (!suffixEmailHashTable) {
        NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        [hashTable addObject:@"@163.com"];
        [hashTable addObject:@"@hiibook.com"];
        [hashTable addObject:@"@126.com"];
        [hashTable addObject:@"@qq.com"];
        [hashTable addObject:@"@sina.com"];
        [hashTable addObject:@"@139.com"];
        [hashTable addObject:@"@21cn.com"];
        [hashTable addObject:@"@outlook.com"];
        [hashTable addObject:@"@tom.com"];
        suffixEmailHashTable = hashTable;
    }
    if ([suffixEmailHashTable containsObject:self]) {
        isExist = YES;
    }
    return isExist;
}

- (BOOL)isPublicMailbox{
    BOOL isPublicMail = NO;
    if (!publicMailboxHashTable) {
        NSHashTable *hashTable = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
        [hashTable addObject:@"163.com"];
        [hashTable addObject:@"126.com"];
        [hashTable addObject:@"qq.com"];
        [hashTable addObject:@"sina.com"];
        [hashTable addObject:@"139.com"];
        [hashTable addObject:@"21cn.com"];
        [hashTable addObject:@"outlook.com"];
        [hashTable addObject:@"tom.com"];
        [hashTable addObject:@"gmail.com"];
        [hashTable addObject:@"yeah.net"];
        [hashTable addObject:@"yahoo.com"];
        [hashTable addObject:@"foxmail.com"];
        [hashTable addObject:@"icloud.com"];
        [hashTable addObject:@"sina.cn"];
        [hashTable addObject:@"189.cn"];
        [hashTable addObject:@"aliyun.com"];
        [hashTable addObject:@"vip.163.com"];
        [hashTable addObject:@"live.com"];
        [hashTable addObject:@"live.cn"];
        [hashTable addObject:@"service.netease.com"];
        [hashTable addObject:@"wo.cn"];
        [hashTable addObject:@"msn.com"];
        [hashTable addObject:@"188.com"];
        [hashTable addObject:@"263.net"];
        [hashTable addObject:@"me.com"];
        [hashTable addObject:@"msn.cn"];
        [hashTable addObject:@"35.cn"];
        [hashTable addObject:@"163.cn"];
        [hashTable addObject:@"sohu.com"];
        [hashTable addObject:@"hotmail.com"];
        [hashTable addObject:@"facebookmail.com"];
        
        
        
        publicMailboxHashTable = hashTable;
    }
    if ([publicMailboxHashTable containsObject:self]) {
        isPublicMail = YES;
    }
    return isPublicMail;
}


/**
 加密规则，Pwd#!AsQqeTSeN8Pa4=#email
 
 email 要加密的String
 */

- (NSString *)encrypt:(NSString *)email
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"public" ofType:@"pub"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    return [MALRSACrypto encrypt:[self stringByAppendingString:[NSString stringWithFormat:@"#!AsQqeTSeN8Pa4=#%@",email]]
                      withPubKey:[[self class] addPublicKey:content]];
}



+(SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data){
        return nil;
    }
    
    //a tag to read/write keychain storage
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    // Skip ASN.1 public key header
    if (d_key == nil) return(nil);
    
    unsigned long len = [d_key length];
    if (!len) return(nil);
    
    unsigned char *c_key = (unsigned char *)[d_key bytes];
    unsigned int  idx	 = 0;
    
    if (c_key[idx++] != 0x30) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    
    idx += 15;
    
    if (c_key[idx++] != 0x03) return(nil);
    
    if (c_key[idx] > 0x80) idx += c_key[idx] - 0x80 + 1;
    else idx++;
    
    if (c_key[idx++] != '\0') return(nil);
    
    // Now make a new NSData from this buffer
    return([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}


#pragma mark --- APP沙盒路径
///APP Document目录
+ (NSString *)appDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}

///APP Caches目录
+ (NSString *)appCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}

///APP 临时目录
+ (NSString *)appTempDirectory
{
    return NSTemporaryDirectory();
}

///APP邮箱配置缓存路径
//+ (NSString *)appEmailConfigCachePath
//{
//    return [[NSString appDocumentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.plist",kAPPConfigCache,kEmailConfig]];
//}

///APP邮箱类型缓存路径
//+ (NSString *)appEmailTypeCachePath
//{
//    return [[NSString appDocumentDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@.plist",kAPPConfigCache,kEmailTypeConfig]];
//}


@end
