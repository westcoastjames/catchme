//
//  ContactUploader.m
//  CatchMe
//
//  Created by Jonathon Simister on 11/24/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactUploader.h"

@implementation ContactUploader

- (id)initWithContact:(ContactEdit*)contact
{
    self = [super init];
    NSMutableURLRequest *request;
    char* s;
    int uuid;
    int a, b, c;
    char* buf;
    
    if (self) {
        responseData = [NSMutableData data];
        
        NSLog(@"ContactUploader initialized");
        
        if(contact.gid == 0) {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jnsj.ca/catchme/newcontact.php"]];
        } else {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.jnsj.ca/catchme/updatecontact.php"]];
        }
        
        mContact = contact;
        
        [request setHTTPMethod:@"POST"];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        uuid = [defaults integerForKey:@"userid"];
        
        buf = calloc(20,1);
        
        sprintf(buf,"userid %d",uuid);
        
        NSLog([[NSString alloc] initWithUTF8String:buf]);
        
        s = calloc(2000,1);
        
        if(contact.shouldcall) { a = 1; } else { a = 0; }
        if(contact.shouldemail) { b = 1; } else { b = 0; }
        if(contact.shouldsms) { c = 1; } else { c = 0; }
        
        if(contact.gid == 0) {
            sprintf(s,"email=%s&phone=%s&name=%s&userid=%d&shouldcall=%d&shouldemail=%d&shouldsms=%d",[contact.email UTF8String],[contact.number UTF8String],[contact.name UTF8String],uuid,a,b,c);
        } else {
            sprintf(s,"email=%s&phone=%s&name=%s&id=%d&shouldcall=%d&shouldemail=%d&shouldsms=%d",[contact.email UTF8String],[contact.number UTF8String],[contact.name UTF8String],contact.gid,a,b,c);
        }
        
        NSString *postString = [[NSString alloc] initWithUTF8String:s];
        
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
    if(mContact.gid == 0) {
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
    
    NSNumber* contactid = [json objectForKey:@"contactid"];
    int iContactID = [contactid intValue];
    
    mContact.gid = iContactID;
    } else {
        NSString* logs;
        
        logs = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        
        NSLog(logs);
    }
}

@end
