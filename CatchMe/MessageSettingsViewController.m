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
    
    // Gets stored data from standardUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *alertMessage = [defaults objectForKey:@"alertMessage"];
    NSString *firstName = [defaults objectForKey:@"firstName"];
    bool emailMessageOn = [defaults boolForKey:@"emailMessageOn"];
    bool textMessageOn = [defaults boolForKey:@"textMessageOn"];
    
    if (emailMessageOn) {
        [emailStatus setOn:YES];
    }
    
    if (textMessageOn) {
        [textMessageStatus setOn:YES];
    }
    
    if ([firstName isEqualToString:@""] || firstName == nil) {
        firstName = @"<Unknown>";
    }
    
    if ([alertMessage isEqualToString:@""] || alertMessage == nil) {
        alertMessage = [NSString stringWithFormat:@"This is a default notification. The user, %@, has recently experienced a fall. Please contact them to check if they are ok. Thank-you.",firstName];
    }
    
    // Sets the text field to whatever the saved medical info is
    messageTextView.text = alertMessage;
    
    // Loads the keyboard dismissal on tap outside textField
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO]; // Allows other tap gestures to continue functioning while this one is in effect
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

// Cancels any changes and goes back to the settings menu
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

// Saves any changes and goes back to the settings menu
- (IBAction)saveChanges {
    // Close the keyboard
    [messageTextView resignFirstResponder];
    
    // Get data from text field
    NSString *alertMessage = [messageTextView text];
    bool emailMessageOn = [emailStatus isOn];
    bool textMessageOn = [textMessageStatus isOn];
    
    // Store the data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:alertMessage forKey:@"alertMessage"];
    [defaults setBool:emailMessageOn forKey:@"emailMessageOn"];
    [defaults setBool:textMessageOn forKey:@"textMessageOn"];
    [defaults synchronize];
    
    NSLog(@"Message data saved");
    
    [self dismissModalViewControllerAnimated:YES];
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [messageTextView resignFirstResponder];
}

// Sets the message to the system's default message.
- (IBAction)defaultMessage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"];
    
    if ([firstName isEqualToString:@""] || firstName == nil) {
        firstName = @"<Unknown>";
    }
    
    messageTextView.text = [NSString stringWithFormat:@"This is a default notification. The user, %@, has recently experienced a fall. Please contact them to check if they are ok. Thank-you.",firstName];
}

@end
