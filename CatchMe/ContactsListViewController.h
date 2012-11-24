//
//  ContactsListViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsDataController;

@interface ContactsListViewController : UITableViewController

@property (strong, nonatomic) ContactsDataController *dataController;

@property (nonatomic, strong) NSMutableArray *contacts;

- (IBAction)cancelChanges;
- (IBAction)done:(UIStoryboardSegue *)segue;


@end
