//
//  AlertUploader.m
//  CatchMe
//
//  Created by Jonathon Simister on 11/25/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "AlertUploader.h"

@implementation AlertUploader

- (id)initWithLatitude:(double)latitude andLongitude:(double)longitude
{
    self = [super init];
    NSString* url;
    char* s;
    NSString* postString;
    int uuid;
    
    if (self) {
        responseData = [NSMutableData data];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        uuid = [defaults integerForKey:@"userid"];
        
        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jnsj.ca/catchme/postfall.php"]];
        
        [request setHTTPMethod:@"POST"];
        
        s = calloc(2000,1);
        
        sprintf(s,"lat=%f&lon=%f&userid=%d",latitude,longitude,uuid);
        
        postString = [[NSString alloc] initWithUTF8String:s];
        
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
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSLog(responseString);
}


@end
