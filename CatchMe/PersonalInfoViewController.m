//
//  PersonalInfoViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//
// Known issues:
// Birthdate needs to be checked such that only certain dates are accepted correctly

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

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
    
    // Gets stored data from standardUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"];
    NSString *lastName = [defaults objectForKey:@"lastName"];
    NSInteger month = [defaults integerForKey:@"month"];
    NSInteger day = [defaults integerForKey:@"day"];
    NSInteger year = [defaults integerForKey:@"year"];
    NSString *address = [defaults objectForKey:@"address"];
    NSString *careCard = [defaults objectForKey:@"careCard"];
    
    // Convert date integers back into strings so they can be displayed in the textboxes
    NSString *monthString = [NSString stringWithFormat:@"%i",month];
    NSString *dayString = [NSString stringWithFormat:@"%i",day];
    NSString *yearString = [NSString stringWithFormat:@"%i",year];
    
    // Takes care of when the month, day and year textFields are blank
    // Otherwise due to the conversion above an unwanted 0 will be outputted
    if ([monthString isEqualToString:@"0"]) {
        monthString = @"";
    }
    if ([dayString isEqualToString:@"0"]) {
        dayString = @"";
    }
    if ([yearString isEqualToString:@"0"]) {
        yearString = @"";
    }
    
    // Fill text boxes with currently saved data
    firstNameTextField.text = firstName;
    lastNameTextField.text = lastName;
    monthTextField.text = monthString;
    dayTextField.text = dayString;
    yearTextField.text = yearString;
    addressTextField.text = address;
    careCardTextField.text = careCard;
    
    // Loads the keyboard dismissal on tap outside textField
   tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO]; // Allows other tap gestures to continue functioning while this one is in effect
}

- (void)viewDidUnload {
    firstNameTextField = nil;
    lastNameTextField = nil;
    monthTextField = nil;
    dayTextField = nil;
    yearTextField = nil;
    addressTextField = nil;
    careCardTextField = nil;
    // Release any retained subviews of the main view.
    [super viewDidUnload];
}

// Goes back to the Settings Menu without saving any of the text field changes
- (IBAction)cancelChanges {
     [self dismissModalViewControllerAnimated:YES];
}

// Saves all the text field information into an NSUserDefaults object to be permanently stored
- (IBAction)saveInfo {
    // Hides the keyboard when the user is done entering info
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [monthTextField resignFirstResponder];
    [dayTextField resignFirstResponder];
    [yearTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    [careCardTextField resignFirstResponder];
    
    // Create strings and integers to hold the data
    NSString *firstName = [firstNameTextField text];
    NSString *lastName  = [lastNameTextField text];
    NSInteger month = [[monthTextField text] integerValue];
    NSInteger day = [[dayTextField text] integerValue];
    NSInteger year = [[yearTextField text] integerValue];
    NSString *address  = [addressTextField text];
    NSString *careCard = [careCardTextField text];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:firstName forKey:@"firstName"];
    [defaults setObject:lastName forKey:@"lastName"];
    [defaults setInteger:month forKey:@"month"];
    [defaults setInteger:day forKey:@"day"];
    [defaults setInteger:year forKey:@"year"];
    [defaults setObject:address forKey:@"address"];
    [defaults setObject:careCard forKey:@"careCard"];
    [defaults synchronize];
    
    NSLog(@"Personal Data saved");
    
    [self dismissModalViewControllerAnimated:YES];
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [monthTextField resignFirstResponder];
    [dayTextField resignFirstResponder];
    [yearTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    [careCardTextField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
