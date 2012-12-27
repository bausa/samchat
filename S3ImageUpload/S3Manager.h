//
//  S3Manager.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSS3Bucket.h"

@interface S3Manager : NSObject
@property (nonatomic, retain) NSString *accessKey;
@property (nonatomic, retain) NSString *secretKey;

-(NSS3Bucket *)bucketWithName:(NSString *)name;
@end
