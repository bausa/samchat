//
//  UIEncryptedImagePickerControllerDelegate.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIEncryptedImagePickerControllerDelegate : UIViewController
-(void)imageEncryptionComplete:(NSData *)image;
@end
