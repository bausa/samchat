//
//  WebService.m
//  WebService
//
//  Created by Sam Baumgarten on 11/26/12.
//  Copyright (c) 2012 Makrr. All rights reserved.
//

#import "WebService.h"

@implementation WebService
+(NSData *)getURL:(NSURL *)url {
    NSURLRequest *request;
    NSError *error;
    NSURLResponse *response;
    NSData *responseData;
    
    request = [[NSURLRequest alloc] initWithURL:url];
    responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                    
    return responseData;
}

+(NSData *)postURL:(NSURL *)url withBody:(NSString *)body {
    NSMutableString *httpBodyString;
    NSURLResponse *response;
    NSError *error;
    
    httpBodyString = [[NSMutableString alloc] initWithString:body];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    
    return [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
}

@end
