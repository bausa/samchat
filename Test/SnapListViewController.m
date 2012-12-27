//
//  SnapListViewController.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "SnapListViewController.h"
#import "TabBarViewController.h"

@interface SnapListViewController ()

@end

@implementation SnapListViewController
@synthesize snapView;
@synthesize manager;
@synthesize unreadSnaps;
@synthesize snapImages;
@synthesize countdownTimer;
@synthesize currentTime;
@synthesize currentIndexPath;
@synthesize snapChatManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appAboutToEnd) name:@"APPABOUTTOQUIT" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeFromBG) name:@"resumeFromBG" object:nil];

    snapImages = [[NSMutableDictionary alloc] init];
    
    snapChatManager = [(TabBarViewController *)[self tabBarController] snapChatManager];
    

//    [self setUnreadSnaps:];
//
//    int64_t delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [[self tableView] reloadData];
//        NSLog(@"us: %@", unreadSnaps);
//    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    [self resumeFromBG];

    unreadSnaps = [[NSMutableArray alloc] init];
    manager = [[NSImageDownloadManager alloc] init];
    [manager setDelegate:self];
    

    NSArray *snaps = [[[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/unread?auth_token=%@", [[snapChatManager currentUser] authenticationToken]]]] encoding:NSUTF8StringEncoding] JSONValue];
    unreadSnaps = [[NSMutableArray alloc] init];
    for (NSDictionary *snapDict in snaps) {
        User *recipient = [[User alloc] init];
        [recipient setId:[NSNumber numberWithInt:[[[snapDict objectForKey:@"recipient"] objectForKey:@"id"] intValue]]];
        [recipient setEmail:[[snapDict objectForKey:@"recipient"] objectForKey:@"username"]];
        
        User *sender = [[User alloc] init];
        [sender setId:[NSNumber numberWithInt:[[[snapDict objectForKey:@"sender"] objectForKey:@"id"] intValue]]];
        [sender setEmail:[[snapDict objectForKey:@"sender"] objectForKey:@"username"]];
        
        Snap *snap = [[Snap alloc] init];
        [snap setId:[NSNumber numberWithInt:[[snapDict objectForKey:@"id"] intValue]]];
        [snap setImageUUID:[snapDict objectForKey:@"image_uuid"]];
        if ([[snapDict objectForKey:@"opened"] intValue] == 1) {
            [snap setOpened:[NSNumber numberWithBool:YES]];
        } else {
            [snap setOpened:[NSNumber numberWithBool:NO]];
        }
        if ([[snapDict objectForKey:@"screenshoted"] intValue] == 1) {
            [snap setScreenshoted:[NSNumber numberWithBool:YES]];
        } else {
            [snap setScreenshoted:[NSNumber numberWithBool:NO]];
        }
        [snap setRecipient:recipient];
        [snap setSent:[snapDict objectForKey:@"sent"]];
        [snap setSender:sender];
        [snap setCreatedTime:[snapDict objectForKey:@"created_at"]];
        [snap setTimeShown:[NSNumber numberWithInt:[[snapDict objectForKey:@"time"] intValue]]];
        
        [unreadSnaps addObject:snap];
        
    }
    NSLog(@"us: %@", unreadSnaps);
    [[self tableView] reloadData];
}

-(void)refreshData {
    NSMutableArray *unreadSnapsT = [[NSMutableArray alloc] init];
    NSArray *snaps = [[[NSString alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/unread?auth_token=%@", [[snapChatManager currentUser] authenticationToken]]]] encoding:NSUTF8StringEncoding] JSONValue];
    for (NSDictionary *snapDict in snaps) {
        User *recipient = [[User alloc] init];
        [recipient setId:[NSNumber numberWithInt:[[[snapDict objectForKey:@"recipient"] objectForKey:@"id"] intValue]]];
        [recipient setEmail:[[snapDict objectForKey:@"recipient"] objectForKey:@"username"]];
        
        User *sender = [[User alloc] init];
        [sender setId:[NSNumber numberWithInt:[[[snapDict objectForKey:@"sender"] objectForKey:@"id"] intValue]]];
        [sender setEmail:[[snapDict objectForKey:@"sender"] objectForKey:@"username"]];
        
        Snap *snap = [[Snap alloc] init];
        [snap setId:[NSNumber numberWithInt:[[snapDict objectForKey:@"id"] intValue]]];
        [snap setImageUUID:[snapDict objectForKey:@"image_uuid"]];
        if ([[snapDict objectForKey:@"opened"] intValue] == 1) {
            [snap setOpened:[NSNumber numberWithBool:YES]];
        } else {
            [snap setOpened:[NSNumber numberWithBool:NO]];
        }
        if ([[snapDict objectForKey:@"screenshoted"] intValue] == 1) {
            [snap setScreenshoted:[NSNumber numberWithBool:YES]];
        } else {
            [snap setScreenshoted:[NSNumber numberWithBool:NO]];
        }
        [snap setRecipient:recipient];
        [snap setSent:[snapDict objectForKey:@"sent"]];
        [snap setSender:sender];
        [snap setCreatedTime:[snapDict objectForKey:@"created_at"]];
        [snap setTimeShown:[NSNumber numberWithInt:[[snapDict objectForKey:@"time"] intValue]]];
        
        [unreadSnapsT addObject:snap];
        
    }
    NSLog(@"us: %@", unreadSnaps);
    [self setUnreadSnaps:unreadSnapsT];
    snapImages = [[NSMutableDictionary alloc] init];
    [[self tableView] reloadData];

}

-(void)imageDidFinishDownloading:(NSDictionary *)data {    
    [snapImages addEntriesFromDictionary:[[NSDictionary alloc] initWithObjects:@[[data objectForKey:@"data"]] forKeys:@[[NSString stringWithFormat:@"%i", [(NSIndexPath *)[data objectForKey:@"indexPath"] row]]]]];
    
    [[[[self tableView] cellForRowAtIndexPath:(NSIndexPath *)[data objectForKey:@"indexPath"]] detailTextLabel] setText:@"Done Loading"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [unreadSnaps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Snap *snap = [unreadSnaps objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell textLabel] setText:[[snap sender] email]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([[snap sent] intValue] == 1) {
        [[cell detailTextLabel] setText:@"Sent"];
        if ([[snap opened] intValue] == 1) {
            [[cell detailTextLabel] setText:@"Sent and Opened"];
        }
    } else {
        if ([[snap opened] intValue] == 1) {
            [[cell detailTextLabel] setText:@"Opened"];        
        } else {
            [[cell detailTextLabel] setText:@"Loading..."];
            
            S3Manager *s3 = [[S3Manager alloc] init];
            [s3 setAccessKey:@"AKIAI2K7R6IW4GZHQKYQ"];
            [s3 setSecretKey:@"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"];
            
            [manager downloadImageFromURL:[[s3 bucketWithName:@"snapchatbucket"] urlForKey:[snap imageUUID]] forIndexPath:indexPath withUUID:[snap imageUUID]];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Snap *snap = [unreadSnaps objectAtIndex:indexPath.row];
    NSData *imageData = [snapImages objectForKey:[NSString stringWithFormat:@"%i", [indexPath row]]];
    if (imageData) {
        snapView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        [snapView setImage:[[[ImageEncryption alloc] init] decryptImageDataString:imageData]];
        [[self view] addSubview:snapView];
        [snapView setHidden:NO];
        
        [countdownTimer invalidate];
        countdownTimer = nil;
        
        currentIndexPath = indexPath;
        currentTime = [[snap timeShown] intValue];
        
        countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [[self.view.window layer] addAnimation:animation forKey:@"layerAnimation"];
        [self.tabBarController.tabBar setHidden:YES];
    }
}

-(void)updateTimer {
    NSLog(@"ct: %i", currentTime);
    if (currentTime == 0) {
        [snapView setHidden:YES];
        [countdownTimer invalidate];
        [[[[self tableView] cellForRowAtIndexPath:currentIndexPath] detailTextLabel] setText:@"Opened"];
        NSData *imageData = [snapImages objectForKey:[NSString stringWithFormat:@"%i", [currentIndexPath row]]];
        if (imageData) {
            [snapImages removeObjectForKey:[NSString stringWithFormat:@"%i", [currentIndexPath row]]];
        }
        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
        [[self.view.window layer] addAnimation:animation forKey:@"layerAnimation"];
        [self.tabBarController.tabBar setHidden:NO];
        Snap *snap = [unreadSnaps objectAtIndex:currentIndexPath.row];
        [snap markAsOpened];
    } else {
        currentTime = currentTime-1;
    }
}

-(void)appAboutToEnd {
    NSLog(@"AAE");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    Snap *snap = [unreadSnaps objectAtIndex:currentIndexPath.row];
    [defaults setObject:[snap imageUUID] forKey:@"snapOnQuit"];
    NSLog(@"saved: %c", [[NSUserDefaults standardUserDefaults] synchronize]);
    [snap markAsOpened];
    NSLog(@"MAO");
    [snapView setHidden:YES];
    NSLog(@"HID");
    [countdownTimer invalidate];
    NSLog(@"INV");
}

-(void)resumeFromBG {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults stringForKey:@"snapOnQuit"] && ![[defaults stringForKey:@"snapOnQuit"] isEqualToString:@""]) {
        Snap *snap = [[Snap alloc] init];
        [snap setImageUUID:[defaults stringForKey:@"snapOnQuit"]];
        [snap markAsOpened];
        NSLog(@"MAOOL");
        if (currentIndexPath) {
            [countdownTimer invalidate];
            [[[[self tableView] cellForRowAtIndexPath:currentIndexPath] detailTextLabel] setText:@"Opened"];
            [self refreshData];
            NSData *imageData = [snapImages objectForKey:[NSString stringWithFormat:@"%i", [currentIndexPath row]]];
            if (imageData) {
                [snapImages removeObjectForKey:[NSString stringWithFormat:@"%i", [currentIndexPath row]]];
            }
        }
        [defaults setObject:@"" forKey:@"snapOnQuit"];
    } else {
        NSLog(@"SOQ: %@", [defaults stringForKey:@"snapOnQuit"]);
    }
}

- (IBAction)clearSnaps:(id)sender {
    [[snapChatManager currentUser] clearSnaps:snapChatManager];
    [self refreshData];
}
@end
