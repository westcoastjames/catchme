//
//  SettingsViewController.h
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"
#import <CoreMotion/CoreMotion.h>

// UITableViewController used to fix bug associated this class with the Storyboard
@interface SettingsViewController : UITableViewController /*<UITableViewDataSource, UITableViewDelegate>*/ {
    UISwitch* swOn;
    DBConnection* db;
    CMMotionManager* motionManager;
   // UIButton* button;
    
    //NSArray * settingItems; // Used for the settings menu interface
}

//- (IBAction)goAudioSettings;

@property (nonatomic, strong) IBOutlet UISwitch* swOn;
//@property (nonatomic, strong) NSArray * settingItems;

//@property (nonatomic, strong) IBAction UIButton* button;


@end