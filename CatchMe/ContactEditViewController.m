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
}

- (void)viewDidUnload
{
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
}

@end
