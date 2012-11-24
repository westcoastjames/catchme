//
//  ContactDownloader.h
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 11/24/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactDownloader : NSObject {
    NSMutableData* responseData;
}

-(id)init;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
