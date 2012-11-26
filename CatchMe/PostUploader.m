//
//  PostUploader.m
//  CatchMe
//
//  Created by Jonathon Simister on 11/25/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "PostUploader.h"

@implementation PostUploader

- (id)initWithURL:(NSString*)url andVariables:(NSString*)postString
{
    self = [super init];
    
    if (self) {
        responseData = [NSMutableData data];
        
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        [request setHTTPMethod:@"POST"];
        
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
        
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        return self;
    }
    
    return nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Show error
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
}

@end
