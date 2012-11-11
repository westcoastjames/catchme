//
//  ContactsViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//
// Known bugs: Keyboard will not minimize on when tapping outside of textField
//             @property (nonatomic, strong) IBOutlet UITextField *txtNumber;
//             in the header may be part of the cause of this

#import "ContactsViewController.h"

@interface ContactsViewController()

@end

@implementation ContactsViewController
//@synthesize txtNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Contacts", @"Contacts");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    db = [[DBConnection alloc] init];
    /*
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
  tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)]; */
    
    // Loads the keyboard dismissal on tap outside textField
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO]; // Allows other tap gestures to continue functioning while this one is in effect
}

-(void)viewWillAppear:(BOOL)animated {
    txtNumber.text = [db getSetting: @"number"];
}

-(void)viewDidDisappear:(BOOL)animated {
    [db setSetting:@"number" value:txtNumber.text];
    
    NSLog(@"set setting");
    
    NSString *s;
    
    s = [db getSetting:@"number"];
    
    NSLog(s);
}

// Hides the keyboard when the users taps outside a text field
- (void)dismissKeyboard {
    [txtNumber resignFirstResponder];
}

// Code has been replaced
/*
-(void) keyboardWillShow:(NSNotification *) note {
    [self.view addGestureRecognizer:tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification *) note
{
    [self.view removeGestureRecognizer:tapRecognizer];
}

-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [txtNumber resignFirstResponder];
}

*/

- (void)viewDidUnload {    
    [db closeDB];
    
    txtNumber = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)goMainMenu {
    [self dismissModalViewControllerAnimated:YES];
}

@end