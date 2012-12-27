//
//  WebService.h
//  WebService
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject
+(NSData *)getURL:(NSURL *)url;
+(NSData *)postURL:(NSURL *)url withBody:(NSString *)body;
@end
