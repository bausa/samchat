//
//  UIEncryptedImagePickerController.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIEncryptedImagePickerController : UIImagePickerController <UIImagePickerControllerDelegate>
@property id controllerDelegate;
-(id)initWithDelegate:(id)newDelegate;

@end
