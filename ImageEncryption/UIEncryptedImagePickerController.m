//
//  UIEncryptedImagePickerController.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "UIEncryptedImagePickerController.h"
#import "NSData+AES256.h"
#import <CommonCrypto/CommonCryptor.h>
#import "UIEncryptedImagePickerControllerDelegate.h"

@interface UIEncryptedImagePickerController ()
- (NSData *)AES256EncryptData:(NSData *)data WithKey:(NSString *)key;
@end

@implementation UIEncryptedImagePickerController
@synthesize controllerDelegate;

-(id)initWithDelegate:(id)newDelegate {
    if (self = [super init]) {
        [self setDelegate:(id<UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self];
        [self setControllerDelegate:newDelegate];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSelectorInBackground:@selector(encryptImage:) withObject:info];
}

-(void)encryptImage:(NSDictionary *)info {
    NSData *data = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],  0.5);
    [(UIEncryptedImagePickerControllerDelegate *)controllerDelegate imageEncryptionComplete:[self AES256EncryptData:data WithKey:@"I/RpkCqJ3WypMVur5F+bZzDEAzYdSLGsQBgF4h1t420="]];
}

- (NSData *)AES256EncryptData:(NSData *)data WithKey:(NSString *)key {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [data length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
    
	free(buffer); //free the buffer;
	return nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // override the touches ended method
    // so tapping the screen will take a picture
    [self takePicture];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

-(void) viewDidAppear: (BOOL)animated {
    [super viewDidAppear:animated];
}

@end
