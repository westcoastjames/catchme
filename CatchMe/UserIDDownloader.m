//
//  UserIDDownloader.m
//  CatchMe
//
//  Created by Jonathon Simister on 11/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "UserIDDownloader.h"

@implementation UserIDDownloader

- (id)init
{
    self = [super init];
    
    if (self) {
        responseData = [NSMutableData data];
        
        NSLog(@"UserIDDownloader initialized");
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jnsj.ca/catchme/newuser.php"]];
        
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
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    NSNumber* userid = [json objectForKey:@"userid"];
    int iUserID = [userid intValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:iUserID forKey:@"userid"];
    [defaults synchronize];
    
    NSLog(@"got the unique user id: %d",iUserID);
}

@end
