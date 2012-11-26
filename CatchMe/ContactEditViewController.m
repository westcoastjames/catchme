//
//  ContactEditViewController.m
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactEditViewController.h"
#import "ContactEdit.h"

@interface ContactEditViewController ()

@end

@implementation ContactEditViewController

@synthesize nameField = _nameField;
@synthesize numberField = _numberField;
@synthesize emailField = _emailField;
@synthesize contact = _contact;

@synthesize shouldemail = _shouldemail;
@synthesize shouldcall = _shouldcall;
@synthesize shouldsms = _shouldsms;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.nameField.text = self.contact.name;
    self.numberField.text = self.contact.number;
    self.emailField.text = self.contact.email;
    [self.shouldcall setOn:self.contact.shouldcall];
    [self.shouldemail setOn:self.contact.shouldemail];
    [self.shouldsms setOn:self.contact.shouldsms];
    
    // Loads the keyboard dismissal on tap outside textField
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO]; // Allows other tap gestures to continue functioning while this one is in effect
}

- (void)viewDidUnload
{
    name = nil;
    number = nil;
    email = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)contactDataChange:(id)sender {
    self.contact.name = self.nameField.text;
    self.contact.number = self.numberField.text;
    self.contact.email = self.emailField.text;
    
    self.contact.shouldcall = self.shouldcall.isOn;
    self.contact.shouldsms = self.shouldsms.isOn;
    self.contact.shouldemail = self.shouldemail.isOn;
    
    if(self.contact.gid != 0) {
        ContactUploader* uploader = [[ContactUploader alloc] initWithContact:self.contact];
    }
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [name resignFirstResponder];
    [number resignFirstResponder];
    [email resignFirstResponder];
}


@end
