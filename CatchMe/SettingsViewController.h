//
//  SettingsViewController.h
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UITableViewController {
    
}

- (IBAction)activateAccelerometer;
@property (nonatomic, strong) IBOutlet UISwitch* swOn;


@end