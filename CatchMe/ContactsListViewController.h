//
//  ContactsListViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsDataController;

@interface ContactsListViewController : UITableViewController {
    NSMutableData* responseData;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@property (strong, nonatomic) ContactsDataController *dataController;

@property (nonatomic, strong) NSMutableArray *contacts;

- (IBAction)doneButton:(id)sender;


@end
