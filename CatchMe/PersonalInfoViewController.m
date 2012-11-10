//
//  PersonalInfoViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//
// Known issues:
// Birthdate needs to be  checked for correct formatting/limiting character count

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
    
    NSString *monthString = [NSString stringWithFormat:@"%i",month];
    NSString *dayString = [NSString stringWithFormat:@"%i",day];
    NSString *yearString = [NSString stringWithFormat:@"%i",year];
    
    // Fill text boxes with currently saved data
    firstNameTextField.text = firstName;
    lastNameTextField.text = lastName;
    monthTextField.text = monthString;
    dayTextField.text = dayString;
    yearTextField.text = yearString;
    addressTextField.text = address;
    
    // Loads the keyboard dismissal on tap otuside textField
   tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
}

- (void)viewDidUnload
{
    firstNameTextField = nil;
    lastNameTextField = nil;
    monthTextField = nil;
    dayTextField = nil;
    yearTextField = nil;
    addressTextField = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelChanges {
     [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveInfo {
    // Hides the keyboard when the user is done entering info
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [monthTextField resignFirstResponder];
    [dayTextField resignFirstResponder];
    [yearTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    
    // Create strings and integers to hold the data
    NSString *firstName = [firstNameTextField text];
    NSString *lastName  = [lastNameTextField text];
    NSInteger month = [[monthTextField text] integerValue];
    NSInteger day = [[dayTextField text] integerValue];
    NSInteger year = [[yearTextField text] integerValue];
    NSString *address  = [addressTextField text];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:firstName forKey:@"firstName"];
    [defaults setObject:lastName forKey:@"lastName"];
    [defaults setInteger:month forKey:@"month"];
    [defaults setInteger:day forKey:@"day"];
    [defaults setInteger:year forKey:@"year"];
    [defaults setObject:address forKey:@"address"];
    [defaults synchronize];
    
    NSLog(@"Personal Data saved");
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dismissKeyboard {
    [firstNameTextField resignFirstResponder];
    [lastNameTextField resignFirstResponder];
    [monthTextField resignFirstResponder];
    [dayTextField resignFirstResponder];
    [yearTextField resignFirstResponder];
    [addressTextField resignFirstResponder];
    //[self.view removeGestureRecognizer:self.tap];
} 
@end
