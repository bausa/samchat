//
//  FriendsViewController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 12/10/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebService/WebService.h>
#import <SnapChat/SnapChat.h>
#import "SBJson.h"

@interface FriendsViewController : UITableViewController
@property (nonatomic, retain) SnapChat *snapChatManager;
@property (nonatomic, retain) NSArray *friends;

- (IBAction)addFriend:(id)sender;
@end
