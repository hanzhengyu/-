//
//  BLRSACrypto.h
//  BLiOSFramework
//
//  Created by hewig on 7/17/14.
//  Copyright (c) 2014 wxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MALRSACrypto : NSObject

/**
 *  do RSA encrypt with default pubkey (lenght 1024)
 *
 *  @param message encrypt
 *  @return base64 NSString or nil if failed
 */
+ (NSString *)encrypt:(NSString *)message withBase64CertString:(NSString *)certString;

+ (NSString *)encrypt:(NSString *)message withCertificate:(SecCertificateRef)certificate;
+ (NSString *)encrypt:(NSString *)message withPubKey:(SecKeyRef)pubkey;

@end
