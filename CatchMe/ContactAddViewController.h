//
//  ContactAddViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsListViewController.h"
#import "ContactEdit.h"
#import "ContactUploader.h"

@class ContactsListViewController;

@interface ContactAddViewController : UITableViewController {
    IBOutlet UITextView *nameF;
    IBOutlet UITextView *numberF;
    IBOutlet UITextView *emailF;
    
    __weak IBOutlet UISwitch *shouldcall;
    __weak IBOutlet UISwitch *shouldsms;
    __weak IBOutlet UISwitch *shouldemail;
    UITapGestureRecognizer *tap;
}

- (IBAction)cancelButton:(id)sender;
- (IBAction)doneButton:(id)sender;


@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *numberField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;


@property (weak, nonatomic) IBOutlet UISwitch *shouldcall;
@property (weak, nonatomic) IBOutlet UISwitch *shouldsms;
@property (weak, nonatomic) IBOutlet UISwitch *shouldemail;
 
@property UITapGestureRecognizer *tap;

@property (nonatomic, strong) ContactsListViewController *contactListView;

- (void)dismissKeyboard;

@end
