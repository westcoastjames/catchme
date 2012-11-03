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

@interface SettingsViewController : UIViewController {
    UISwitch* swOn;
    DBConnection* db;
    CMMotionManager* motionManager;
    UIButton* button;
}

- (IBAction)goAudioSettings;

@property (nonatomic, strong) IBOutlet UISwitch* swOn;

<<<<<<< HEAD
=======
//@property (nonatomic, strong) IBAction UIButton* button;
>>>>>>> 4dfe5938f4d5a01029bf1fa1381fd1b65e6b2d40

@end