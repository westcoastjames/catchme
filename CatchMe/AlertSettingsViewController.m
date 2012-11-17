//
//  AlertSettingsViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "AlertSettingsViewController.h"

@interface AlertSettingsViewController ()

@end

@implementation AlertSettingsViewController

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
    
    // Loads in the user default settings
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger timeDelay = [defaults integerForKey:@"timeDelay"];
    bool audioNotificationOn = [defaults boolForKey:@"audioNotificationOn"];
    bool vibrationNotificationOn = [defaults boolForKey:@"vibrationNotificationOn"];
    
    // Convert tiemDelay integer back into a string so it can be displayed in the textbox
    NSString *timeDelayString = [NSString stringWithFormat:@"%i",timeDelay];
    
    timeDelayTextField.text = timeDelayString;
    
    if (audioNotificationOn) {
        [audioNotification setOn:YES];
    }
    
    if (vibrationNotificationOn) {
        [vibrationNotification setOn:YES];
    }
    
    
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

// Goes back to the Settings Menu without saving any of the text field changes
- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [timeDelayTextField resignFirstResponder];
}

- (IBAction)saveInfo {
    [timeDelayTextField resignFirstResponder];
    
    bool audioNotificationOn = [audioNotification isOn];
    bool vibrationNotificationOn = [vibrationNotification isOn];
    NSInteger timeDelay = [[timeDelayTextField text] integerValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:audioNotificationOn forKey:@"audioNotificationOn"];
    [defaults setBool:vibrationNotificationOn forKey:@"vibrationNotificationOn"];
    [defaults setInteger:timeDelay forKey:@"timeDelay"];
    
    // Go back to the settings menu
    [self dismissModalViewControllerAnimated:YES];
}

@end
