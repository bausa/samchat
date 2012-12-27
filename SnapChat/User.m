//
//  User.m
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "User.h"
#import "SnapChat.h"
#import <WebService/WebService.h>

@implementation User
@synthesize id;
@synthesize email;
@synthesize authenticationToken;

-(void)clearSnaps:(SnapChat *)snapchat {
    if ([snapchat currentUser] == self) {
        [WebService getURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.2.24:3000/api/v1/snaps/clear?authToken=%@", authenticationToken]]];
    }
}

@end
