//
//  MainMenuViewController.h
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>


@interface MainMenuViewController : UIViewController <CLLocationManagerDelegate> {
    
    IBOutlet UISwitch* systemStatusSwitch;
    DBConnection* db;
    CMMotionManager* motionManager;
    CLLocationManager *locationManager;
    
    AVAudioPlayer *audioPlayer;
    
}
- (IBAction)activateAccelerometer;
@end
