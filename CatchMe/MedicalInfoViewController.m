//
//  MedicalInfoViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "MedicalInfoViewController.h"

@interface MedicalInfoViewController ()

@end

@implementation MedicalInfoViewController

// Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Actions to take place when the window opens
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Gets stored data from standardUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *medicalInfo = [defaults objectForKey:@"medicalInfo"];
    
    if ([medicalInfo isEqualToString:@""] || medicalInfo == nil) {
        medicalInfo = @"Type any necessary medical instructions in here.";
    } 

    // Sets the text field to whatever the saved medical info is
    medicalTextView.text = medicalInfo;
    
    // Loads the keyboard dismissal on tap outside textField
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO]; // Allows other tap gestures to continue functioning while this one is in effect
}

// Actions to take place when the window closes
- (void)viewDidUnload {
    medicalTextView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [medicalTextView resignFirstResponder];
}

// Cancels any changes and goes back to the settings menu
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

// Saves any changes and goes back to the settings menu
- (IBAction)saveChanges {
    // Close the keyboard
    [medicalTextView resignFirstResponder];
    
    // Get data from text field
    NSString *medicalInfo = [medicalTextView text];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:medicalInfo forKey:@"medicalInfo"];
    [defaults synchronize];
    
    NSLog(@"Personal Data saved");
    
    [self dismissModalViewControllerAnimated:YES];
}

// Makes sure interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
