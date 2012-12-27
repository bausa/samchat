//
//  ImagePickerViewController.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "ImagePickerViewController.h"

@interface ImagePickerViewController ()

@end

@implementation ImagePickerViewController

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
    
    UIEncryptedImagePickerController *controller = [[UIEncryptedImagePickerController alloc] init];
    [controller setControllerDelegate:self];
    [controller setSourceType:UIImagePickerControllerSourceTypeCamera];
    [controller setShowsCameraControls:NO];
    [self addChildViewController:controller];
    [[self view] addSubview:[controller view]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageEncryptionComplete:(NSData *)image {
    NSLog(@"Photo Good");
    [self performSegueWithIdentifier:@"gts2" sender:self];
}

@end
