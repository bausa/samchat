//
//  NSImageDownloadManager.m
//  NSImageDownloadManager
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "NSImageDownloadManager.h"
#import "NSDownloadImageOperation.h"

@implementation NSImageDownloadManager
@synthesize delegate;
@synthesize operationQueue;
@synthesize downloadedImages;

-(id)init {
    if (self = [super init]) {
        downloadedImages = [[NSMutableDictionary alloc] init];
        operationQueue = [[NSOperationQueue alloc] init];
        [operationQueue setName:@"imageDownloadQueue"];
        [operationQueue setMaxConcurrentOperationCount:3];
    }
    
    return self;
}

-(void)downloadImageFromURL:(NSURL *)url forIndexPath:(NSIndexPath *)indexpath withUUID:(NSString *)uuid {
    if ([downloadedImages objectForKey:uuid] != nil) {
        NSData *data = [downloadedImages objectForKey:[url absoluteString]];
        NSDictionary *delegateResponse = [[NSDictionary alloc] initWithObjects:@[indexpath, data] forKeys:@[@"indexPath", @"data"]];
        [(NSObject *)self.delegate performSelectorOnMainThread:(@selector(imageDidFinishDownloading:)) withObject:delegateResponse waitUntilDone:YES];
    } else {
        NSDownloadImageOperation *operation = [[NSDownloadImageOperation alloc] init];
        [operation setImageURL:url];
        [operation setIndexPath:indexpath];
        [operation setDelegate:delegate];
        [operation setManager:self];
        
        [operationQueue addOperation:operation];
    }
}
@end
