//
//  UserIDDownloader.h
//  CatchMe
//
//  Created by Jonathon Simister on 11/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface UserIDDownloader : NSObject {
    NSMutableData* responseData;
}
    
-(id)init;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end