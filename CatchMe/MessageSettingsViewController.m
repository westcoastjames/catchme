//
//  MessageSettingsViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "MessageSettingsViewController.h"

@interface MessageSettingsViewController ()

@end

@implementation MessageSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Goes back to the Settings Menu without saving any of the text field changes
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

@end
