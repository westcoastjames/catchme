//
//  ContactEditViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property (nonatomic, assign) BOOL emailOn;
@property (nonatomic, assign) BOOL phoneOn;

- (IBAction)contactDataChange:(id)sender;

- (void)dismissKeyboard;

@property UITapGestureRecognizer *tap;

@end
