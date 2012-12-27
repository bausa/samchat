//
//  S3Bucket.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "NSS3Bucket.h"
#import <AWSiOSSDK/S3/AmazonS3Client.h>

@implementation NSS3Bucket
@synthesize bucketName;
@synthesize manager;

-(void)upload:(NSData*)dataToUpload forKey:(NSString*)key{
    @try {
        AmazonS3Client *s3;
        S3CreateBucketRequest *cbr;
        S3PutObjectRequest *por;
        
        s3 = [[AmazonS3Client alloc] initWithAccessKey:[manager accessKey] withSecretKey:[manager secretKey]];
        cbr = [[S3CreateBucketRequest alloc] initWithName:bucketName];
        por = [[S3PutObjectRequest alloc] initWithKey:key inBucket:bucketName];
        
        [s3 createBucket:cbr];
        
        [por setContentLength:[dataToUpload length]];
        [por setData:dataToUpload];
        
        [s3 putObject:por];
    }
    @catch ( AmazonServiceException *exception ) {
        NSLog( @"Upload Failed, Reason: %@", exception );
    }
}

-(NSURL *)urlForKey:(NSString *)key {
    AmazonS3Client *s3;
    S3ResponseHeaderOverrides *override;
    S3GetPreSignedURLRequest *gpsur;
    
    s3 = [[AmazonS3Client alloc] initWithAccessKey:[manager accessKey] withSecretKey:[manager secretKey]];
    override = [[S3ResponseHeaderOverrides alloc] init];
    gpsur = [[S3GetPreSignedURLRequest alloc] init];
    
    [override setContentType:@"image/jpeg"];
    
    [gpsur setKey:key];
    [gpsur setBucket:bucketName];
    [gpsur setExpires:[NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval) 240]];
    [gpsur setResponseHeaderOverrides:override];
    
    return [s3 getPreSignedURL:gpsur];
}

-(NSData *)objectAtKey:(NSString *)key {
    return [NSData dataWithContentsOfURL:[self urlForKey:key]];
}
@end
