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
    
    // Get the stored data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *medicalInfo = [defaults objectForKey:@"medicalInfo"];
    
    if ([medicalInfo isEqualToString:@""]) {
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
