//
//  SignupViewController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 12/10/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebService/WebService.h>
#import <SnapChat/SnapChat.h>
#import "SBJson.h"

@interface SignupViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (nonatomic, retain) SnapChat *snapChatManager;
@property BOOL keyboardVisible;
@property CGPoint offset;
@property UITextField *activeField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)signup:(id)sender;
@end
