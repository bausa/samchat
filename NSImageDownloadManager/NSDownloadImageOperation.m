//
//  NSDownloadImageOperation.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "NSDownloadImageOperation.h"
#import <UIKit/UIKit.h>

@implementation NSDownloadImageOperation
@synthesize delegate;
@synthesize imageURL;
@synthesize uuid;
@synthesize indexPath;
@synthesize manager;

- (void)main {
    // a lengthy operation
    @autoreleasepool {
        NSData *data;
        
        data = [[NSData alloc] initWithContentsOfURL:imageURL];
        
        NSDictionary *delegateResponse = [[NSDictionary alloc] initWithObjects:@[indexPath, data] forKeys:@[@"indexPath", @"data"]];
        if (data != nil && uuid != nil) {
            NSDictionary *managerResponse = [[NSDictionary alloc] initWithObjects:@[data] forKeys:@[uuid]];
            [[[self manager] downloadedImages] addEntriesFromDictionary:managerResponse];
        }
        
        [(NSObject *)self.delegate performSelectorOnMainThread:(@selector(imageDidFinishDownloading:)) withObject:delegateResponse waitUntilDone:YES];
    }
}
@end
