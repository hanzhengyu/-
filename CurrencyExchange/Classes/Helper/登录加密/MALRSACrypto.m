//
//  BLRSACrypto.m
//  BLiOSFramework
//
//  Created by hewig on 7/17/14.
//  Copyright (c) 2014 wxw. All rights reserved.
//

#import "MALRSACrypto.h"

@implementation MALRSACrypto

+ (NSString *)encrypt:(NSString *)message withBase64CertString:(NSString *)certString
{
    if (!message || message.length == 0) {
        return nil;
    }
    
    NSData *certData = [[NSData alloc] initWithBase64EncodedString:certString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    SecCertificateRef certificate = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)(certData));
    NSString *result = [[self class] encrypt:message withCertificate:certificate];
//    CFRelease(certificate);
    
    return result;
}

+ (NSString *)encrypt:(NSString *)message withCertificate:(SecCertificateRef)certificate
{
    if (certificate == NULL) {
        return nil;
    }
    
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    OSStatus status = SecTrustCreateWithCertificates(certificate, policy, &trust);
    if (status != noErr) {
        return nil;
    }
    SecTrustResultType trustResult;
    SecTrustEvaluate(trust, &trustResult);
    SecKeyRef pubkey = SecTrustCopyPublicKey(trust);
    
    NSString *result = [self encrypt:message withPubKey:pubkey];
    CFRelease(policy);
    CFRelease(trust);
    CFRelease(pubkey);
    
    return result;
}

+ (NSString *)encrypt:(NSString *)message withPubKey:(SecKeyRef)pubkey
{
    if (pubkey == NULL) {
        return nil;
    }
    
    size_t cipher_buf_size = SecKeyGetBlockSize(pubkey);
    uint8_t *cipher_buffer = malloc(cipher_buf_size * sizeof(uint8_t));
    NSData *message_data = [message dataUsingEncoding:NSUTF8StringEncoding];
    size_t block_size = cipher_buf_size - 11;
    size_t block_count = (size_t)ceil(message_data.length * 1.f / block_size);
    NSMutableData *encryted_data = [NSMutableData new];
    
    for (int i = 0; i < block_count; i++) {
        int buff_size = (int)MIN(block_size, message_data.length - i * block_size);
        NSData *buff_data = [message_data subdataWithRange:NSMakeRange(i * block_size, buff_size)];
        OSStatus status = SecKeyEncrypt(pubkey,
                                        kSecPaddingPKCS1,
                                        (uint8_t *)buff_data.bytes,
                                        buff_data.length,
                                        cipher_buffer,
                                        &cipher_buf_size);
        if (status == noErr) {
            NSData *encrypted_buff_data = [[NSData alloc] initWithBytes:cipher_buffer length:cipher_buf_size];
            [encryted_data appendData:encrypted_buff_data];
        } else {
            free(cipher_buffer);
            return nil;
        }
    }
    free(cipher_buffer);
    
    return [encryted_data base64EncodedStringWithOptions:0];
}

@end
