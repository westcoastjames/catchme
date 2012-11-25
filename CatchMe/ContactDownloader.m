//
//  ContactDownloader.m
//  CatchMe
//
//  Created by Jonathon Simisteron 11/24/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactDownloader.h"

@implementation ContactDownloader

- (id)init
{
    self = [super init];
    NSString* url;
    char* buf;
    int uuid;
    
    if (self) {
        responseData = [NSMutableData data];
        
        buf = calloc(2000,1);
        
        NSLog(@"ContactDownloader initialized");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        uuid = [defaults integerForKey:@"userid"];
        
        sprintf(buf,"http://www.jnsj.ca/catchme/getcontacts.php?userid=%d",uuid);
        
        url = [[NSString alloc] initWithUTF8String:buf];
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
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
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(responseString);
}


@end
