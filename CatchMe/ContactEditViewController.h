//
//  ContactEditViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactEdit;

@interface ContactEditViewController : UITableViewController

@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *numberField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;

@property (nonatomic, strong) ContactEdit *contact;

- (IBAction)contactDataChange:(id)sender;

@end
