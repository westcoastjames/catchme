//
//  AlertUploader.h
//  CatchMe
//
//  Created by Jonathon Simister on 11/25/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertUploader : NSObject {
    NSMutableData* responseData;
}

- (id)initWithLatitude:(double)latitude andLongitude:(double)longitude;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
