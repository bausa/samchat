//
//  TabBarViewController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 12/10/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SnapChat/SnapChat.h>

@interface TabBarViewController : UITabBarController
@property (nonatomic, retain) SnapChat *snapChatManager;
@end
