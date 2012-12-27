//
//  Snap.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebService/WebService.h>
#import "User.h"

@interface Snap : NSObject
@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *imageUUID;
@property (nonatomic, retain) NSNumber *opened;
@property (nonatomic, retain) NSNumber *screenshoted;
@property (nonatomic, retain) NSString *createdTime;
@property (nonatomic, retain) NSNumber *timeShown;
@property (nonatomic, retain) NSNumber *sent;
@property (nonatomic, retain) User *sender;
@property (nonatomic, retain) User *recipient;

-(void)markAsOpened;
-(void)markAsScreenshoted;

@end
