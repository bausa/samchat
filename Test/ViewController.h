//
//  ViewController.h
//  Test
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageEncryption/ImageEncryption.h>
#import <UIShowingSlider/UIShowingSlider.h>
#import <S3ImageUpload/S3ImageUpload.h>
#import <uuid/uuidgen.h>
#import <WebService/WebService.h>
#import <AWSiOSSDK/S3/AmazonS3Client.h>
#import "SnapListViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) SnapChat *snapChatManager;
@property (nonatomic, retain) MNEValueTrackingSlider *slider;
@property (nonatomic, retain) NSArray *friends;
@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;
- (IBAction)takePhoto:(id)sender;

@end
