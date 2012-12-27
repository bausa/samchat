//
//  NSImageDownloadManager.h
//  NSImageDownloadManager
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSImageDownloadManager : NSObject
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSOperationQueue *operationQueue;
@property (nonatomic, retain) NSMutableDictionary *downloadedImages;

-(void)downloadImageFromURL:(NSURL *)url forIndexPath:(NSIndexPath *)indexpath withUUID:(NSString *)uuid;
@end
