//
//  NSDownloadImageOperation.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSImageDownloadManager.h"

@interface NSDownloadImageOperation : NSOperation
@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) NSImageDownloadManager *manager;
@property (nonatomic, retain) NSURL *imageURL;
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSIndexPath *indexPath;

@end
