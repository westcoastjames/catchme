//
//  MainMenuViewController.h
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"
#import "FallDetector.h"
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

#include "sys/time.h"

@interface MainMenuViewController : UIViewController <CLLocationManagerDelegate> {
    
    IBOutlet UISwitch* systemStatusSwitch;
    DBConnection* db;
    CMMotionManager* motionManager;
    CLLocationManager *locationManager;
    
    AVAudioPlayer *audioPlayer;
    NSTimeInterval startAudioTime;
    
    FallDetector* fallDetector;
    
    UIAlertView *alert;
    // For testing purposes
    IBOutlet UILabel *x_coord;
    IBOutlet UILabel *y_coord;
    IBOutlet UILabel *z_coord;
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *latitude;
    
    double x_accel;
    double y_accel;
    double z_accel;
    
    long startsecs;
    
    
}

- (IBAction)activateAccelerometer;

@end
