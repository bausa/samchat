//
//  S3Manager.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "S3Manager.h"

@implementation S3Manager
@synthesize accessKey;
@synthesize secretKey;

-(NSS3Bucket *)bucketWithName:(NSString *)name {
    NSS3Bucket *bucket = [[NSS3Bucket alloc] init];
    [bucket setManager:self];
    [bucket setBucketName:name];
    
    return bucket;
}
@end
