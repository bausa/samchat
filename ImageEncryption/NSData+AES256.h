//
//  NSData+AES256.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)AES256EncryptWithKey:(NSString *)key;

@end
