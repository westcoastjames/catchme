//
//  MedicalConditionsViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "MedicalConditionsViewController.h"

@interface MedicalConditionsViewController ()

@end

@implementation MedicalConditionsViewController

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
    
    // Get the stored personal information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *firstName = [defaults objectForKey:@"firstName"];
    NSString *lastName = [defaults objectForKey:@"lastName"];
    NSInteger month = [defaults integerForKey:@"month"];
    NSInteger day = [defaults integerForKey:@"day"];
    NSInteger year = [defaults integerForKey:@"year"];
    NSString *address = [defaults objectForKey:@"address"];
    NSString *careCard = [defaults objectForKey:@"careCard"];
    
    // Convert date integers back into strings so they can be displayed
    NSString *monthString = [NSString stringWithFormat:@"%i",month];
    NSString *dayString = [NSString stringWithFormat:@"%i",day];
    NSString *yearString = [NSString stringWithFormat:@"%i",year];
    
    // Makes sure the data stays formatted correctoly even when the user hasn't set any personal informationd
    if (firstName == nil) {
        firstName = @"<unknown>";
    }
    if (lastName == nil) {
        lastName = @"<unknown>";
    }
    if ([monthString isEqualToString:@"0"]) {
        monthString = @"<??>";
    }
    if ([dayString isEqualToString:@"0"]) {
        dayString = @"<??>";
    }
    if ([yearString isEqualToString:@"0"]) {
        yearString = @"<??>";
    }
    if (address == nil) {
        address = @"<unknown>";
    }
    if (careCard == nil) {
        careCard = @"<unknown>";
    }
    
    // Displays the personal information
    personalInfo.text = [NSString stringWithFormat:@"Name: %@ %@ \nBirthdate: %@ / %@ / %@ \nAddress: %@ \nCare Card Number: %@", firstName, lastName, monthString, dayString, yearString, address, careCard];
    
    // Get the stored medical data
    NSString *medicalInfo = [defaults objectForKey:@"medicalInfo"];
    
    if ([medicalInfo isEqualToString:@""] || medicalInfo == nil) {
        medicalInfo = @"The user has not specified any medical instructions.";
    } 
    
    // Display the medical conditions
    medicalConditions.text = medicalInfo;
}

// Actions to take place when the window closes
- (void)viewDidUnload {
    medicalConditions = nil;
    medicalConditions = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Makes sure interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Goes back to the Main Menu
- (IBAction)goBackToMenu {
    [self dismissModalViewControllerAnimated:YES];
}

@end
