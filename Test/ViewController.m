//
//  ViewController.m
//  Test
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "ViewController.h"
#import "TabBarViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize snapChatManager;
@synthesize slider;
@synthesize friends;
@synthesize friendsTableView;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    snapChatManager = [(TabBarViewController *)[self tabBarController] snapChatManager];
    
    slider = [[MNEValueTrackingSlider alloc] initWithFrame:CGRectMake(18, 89, [[UIScreen mainScreen] bounds].size.width-36, 23)];
    [slider setMinimumValue:1.00];
    [slider setMaximumValue:10.00];
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:0.53 green:0.69 blue:0.376 alpha:1]];
    [slider setValue:0.00];
    [[self view] addSubview:slider];

    NSData *friendsData = [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/friends?auth_token=%@", [[snapChatManager currentUser] authenticationToken]]]];
    NSString *friendsString = [[NSString alloc] initWithData:friendsData encoding:NSUTF8StringEncoding];
    friends = [friendsString JSONValue];
    NSLog(@"friends: %@", friends);
    
    [[self friendsTableView] reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)imageEncryptionComplete:(NSData *)image {
    NSMutableArray *recipIDs = [[NSMutableArray alloc] init];
    for (NSIndexPath *index in [[self friendsTableView] indexPathsForSelectedRows]) {
        [recipIDs addObject:[[friends objectAtIndex:index.row] objectForKey:@"id"]];
        NSLog(@"recip: %@", recipIDs);
    }
    
    
    NSString *uuid = [UUIDGen generateUUID];
    
    S3Manager *s3 = [[S3Manager alloc] init];
    [s3 setAccessKey:@"AKIAI2K7R6IW4GZHQKYQ"];
    [s3 setSecretKey:@"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"];
    [[s3 bucketWithName:@"snapchatbucket"] upload:image forKey:uuid];
    
    [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/snap?uuid=%@&auth_token=%@&timeShown=%f&recipients=%@", uuid, [[snapChatManager currentUser] authenticationToken], slider.value, [recipIDs componentsJoinedByString:@","]]]];
    NSData *friendsData = [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/friends?auth_token=%@", [[snapChatManager currentUser] authenticationToken]]]];
    NSString *friendsString = [[NSString alloc] initWithData:friendsData encoding:NSUTF8StringEncoding];
    friends = [friendsString JSONValue];
    NSLog(@"friends: %@", friends);
    
    [[self friendsTableView] reloadData];
}


- (IBAction)takePhoto:(id)sender {
    if ([[[self friendsTableView] indexPathsForSelectedRows] count] != 0) {
        UIEncryptedImagePickerController *ipc = [[UIEncryptedImagePickerController alloc] initWithDelegate:self];
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:ipc animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select friends to send this snap to" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SnapListViewController *vc = [segue destinationViewController];
    [vc setSnapChatManager:snapChatManager];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected: %@", [tableView indexPathsForSelectedRows]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [friends count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    [[cell textLabel] setText:[[friends objectAtIndex:indexPath.row] objectForKey:@"email"]];
    
    return cell;
}


@end
