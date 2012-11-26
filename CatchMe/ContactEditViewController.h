//
//  ContactEditViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactEdit.h"
#import "ContactUploader.h"

@class ContactEdit;

@interface ContactEditViewController : UITableViewController {
    UITapGestureRecognizer *tap;

    __weak IBOutlet UITextField *name;
    __weak IBOutlet UITextField *number;
    __weak IBOutlet UITextField *email;


}

@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *numberField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;

@property (nonatomic, strong) ContactEdit *contact;

@property (weak, nonatomic) IBOutlet UISwitch *shouldcall;
@property (weak, nonatomic) IBOutlet UISwitch *shouldsms;
@property (weak, nonatomic) IBOutlet UISwitch *shouldemail;

- (IBAction)contactDataChange:(id)sender;

- (void)dismissKeyboard;

@property UITapGestureRecognizer *tap;

@end
