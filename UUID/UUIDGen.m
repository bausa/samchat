//
//  UUID.m
//  UUID
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "UUIDGen.h"

@implementation UUIDGen
+(NSString *)generateUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    NSString *uuidStringObj = (__bridge NSString *)uuidString;
    CFRelease(uuidString);
    return uuidStringObj;
}
@end
