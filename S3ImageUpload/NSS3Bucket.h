//
//  S3Bucket.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSS3Bucket : NSObject
@property (nonatomic, retain) NSString *bucketName;
@property (nonatomic, retain) id manager;

-(void)upload:(NSData *)dataToUpload forKey:(NSString*)key;
-(NSURL *)urlForKey:(NSString *)key;
-(NSData *)objectAtKey:(NSString *)key;

@end
