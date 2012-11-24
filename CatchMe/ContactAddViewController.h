//
//  ContactAddViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsListViewController;

@interface ContactAddViewController : UITableViewController {
    IBOutlet UITextView *nameF;
    IBOutlet UITextView *numberF;
    IBOutlet UITextView *emailF;
    UITapGestureRecognizer *tap;
}

- (IBAction)cancelButton:(id)sender;
- (IBAction)doneButton:(id)sender;


@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *numberField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;

@property (nonatomic, assign) BOOL emailOn;
@property (nonatomic, assign) BOOL phoneOn;

@property UITapGestureRecognizer *tap;

@property (nonatomic, strong) ContactsListViewController *contactListView;

- (void)dismissKeyboard;

@end
