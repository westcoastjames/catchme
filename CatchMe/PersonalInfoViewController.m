//
//  PersonalInfoViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//
// Known Bugs/Issues:
// The address and care card fields have clear buttons that do not clear the text. This is due to a conflict with the keyboard covering them when it is shown.

#import "PersonalInfoViewController.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

// Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Actions to take place when the window opens
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    invalidCardNum.hidden = TRUE;
    invalidDate.hidden = TRUE;
    
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

// Actions to take place when the window closes
- (void)viewDidUnload {
    firstNameTextField = nil;
    lastNameTextField = nil;
    monthTextField = nil;
    dayTextField = nil;
    yearTextField = nil;
    addressTextField = nil;
    careCardTextField = nil;
    // Release any retained subviews of the main view.
    invalidDate = nil;
    invalidCardNum = nil;
    [super viewDidUnload];
}

// Goes back to the Settings Menu without saving any of the text field changes
- (IBAction)cancelChanges {
     [self dismissModalViewControllerAnimated:YES];
}

// Saves all the text field information into an NSUserDefaults object to be permanently stored
- (IBAction)saveInfo {
    char* s;
    
    invalidCardNum.hidden = TRUE;
    invalidDate.hidden = TRUE;
    
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
    
    // Checks to make sure correct date and care card formats are entered. This does not check to make sure the date
    // and care card are legitimate inputs though
    Boolean error = FALSE;
    if ([careCard length] != 10) {
        if ([careCard length] != 0) {
            invalidCardNum.hidden = FALSE;
            error = TRUE;
        }
    }
    if ((month > 12 || month < 1 || day > 31 || day < 1 || year < 1000 || year > 9999) && (month != 0 || day != 0 || year != 0)) {
        invalidDate.hidden = FALSE;
        error = TRUE;
    }
    if (error == TRUE) {
        return;
    }
    
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
    
    s = calloc(2000,1);
    
    sprintf(s,"id=%d&firstname=%s&lastname=%s",[defaults integerForKey:@"userid"],[firstName UTF8String],[lastName UTF8String]);
    
    NSString* postString;
    
    postString = [[NSString alloc] initWithUTF8String:s];
    
    PostUploader* uploader = [[PostUploader alloc] initWithURL:@"http://www.jnsj.ca/catchme/postsettings.php" andVariables:postString];
    
    free(s);
    
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

// Makes sure interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
