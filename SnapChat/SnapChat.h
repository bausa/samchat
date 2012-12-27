//
//  SnapChat.h
//  SnapChat
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Snap.h"
#import "User.h"

@interface SnapChat : NSObject
@property (nonatomic, retain) User *currentUser;

@end
