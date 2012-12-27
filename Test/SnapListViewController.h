//
//  SnapListViewController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageEncryption/ImageEncryption.h>
#import <NSImageDownloadManager/NSImageDownloadManager.h>
#import <SnapChat/SnapChat.h>
#import <S3ImageUpload/S3ImageUpload.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import "SBJson.h"

@interface SnapListViewController : UITableViewController
@property (nonatomic, retain) UIImageView *snapView;
@property (nonatomic, retain) NSImageDownloadManager *manager;
@property (nonatomic, retain) NSMutableArray *unreadSnaps;
@property (nonatomic, retain) NSMutableDictionary *snapImages;
@property (nonatomic, retain) NSTimer *countdownTimer;
@property (nonatomic, retain) NSIndexPath *currentIndexPath;
@property (nonatomic, retain) SnapChat *snapChatManager;
@property int currentTime;
- (IBAction)clearSnaps:(id)sender;

@end
