//
//  User.h
//  ImageEncryption
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, retain) NSNumber *id;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *authenticationToken;

-(void)clearSnaps:(id)snapchat;
@end
