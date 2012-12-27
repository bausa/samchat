//
//  Snap.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "Snap.h"

@implementation Snap
@synthesize id;
@synthesize imageUUID;
@synthesize opened;
@synthesize screenshoted;
@synthesize createdTime;
@synthesize sender;
@synthesize recipient;
@synthesize timeShown;
@synthesize sent;

-(void)markAsOpened {
    [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/open?uuid=%@", imageUUID]]];
}

-(void)markAsScreenshoted {
    [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/screenshot?uuid=%@", imageUUID]]];
}

@end