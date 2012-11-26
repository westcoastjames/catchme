//
//  SettingsViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController()

@end

@implementation SettingsViewController

// Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

// Actions to take place when the window opens
- (void)viewDidLoad {
    [super viewDidLoad];
}

// Actions to take place when the window closes
- (void)viewDidUnload {    
    [super viewDidUnload];
}

// Makes sure interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end

