//
//  ContactUploader.h
//  CatchMe
//
//  Created by Jonathon Simister on 11/24/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactEdit.h"

@interface ContactUploader : NSObject {
    NSMutableData* responseData;
    ContactEdit* mContact;
}

- (id)initWithContact:(ContactEdit*)contact;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
