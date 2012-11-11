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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *medicalInfo = [defaults objectForKey:@"medicalInfo"];
    
    medicalConditions.text = medicalInfo;
}

- (void)viewDidUnload
{
    medicalConditions = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Goes back to the Main Menu
- (IBAction)goBackToMenu {
    [self dismissModalViewControllerAnimated:YES];
}

@end
