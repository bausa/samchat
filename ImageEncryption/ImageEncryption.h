//
//  ImageEncryption.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIEncryptedImagePickerController.h"

@interface ImageEncryption : NSObject
-(UIImage *)decryptImageDataString:(NSData *)string;

@end
