//
//  LoginViewController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 12/7/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebService/WebService.h>
#import <SnapChat/SnapChat.h>
#import "SBJson.h"

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) SnapChat *snapChatManager;
@property BOOL keyboardVisible;
@property CGPoint offset;
@property UITextField *activeField;
- (IBAction)login:(id)sender;

@end
