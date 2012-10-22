//
//  SecondViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController()

@end

@implementation SettingsViewController
@synthesize swOn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    NSString* ison;
    
    [super viewDidLoad];

    db = [[DBConnection alloc] init];

    ison = [db getSetting:@"on"];
    
    if([ison isEqualToString:@"yes"]) {
        [swOn setOn:true];
    } else {
        [swOn setOn:false];
    }
    
}

- (void)viewDidUnload
{
    if (swOn.on) {
        [db setSetting:@"on" value:@"yes"];
    } else {
        [db setSetting:@"on" value:@"no"];
    }
    
    [db closeDB];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
