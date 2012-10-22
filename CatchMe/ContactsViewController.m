//
//  ContactsViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactsViewController.h"

@interface ContactsViewController()

@end

@implementation ContactsViewController
@synthesize txtNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Contacts", @"Contacts");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //db = [DBConnection init];
    
    //txtNumber.text = [db getSetting: @"number"];
    
}

- (void)viewDidUnload
{
    [db setSetting:@"number" value:txtNumber.text];
    
    [db closeDB];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end