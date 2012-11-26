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

#import "AlertUploader.h"

@interface MainMenuViewController : UIViewController <CLLocationManagerDelegate> {
    
    IBOutlet UISwitch* alertStatusSwitch;
    DBConnection* db;
    
    CMMotionManager* motionManager;
    CLLocationManager *locationManager;
    
    AVAudioPlayer *audioPlayer;
    AVAudioSession *audioSession;
    
    FallDetector* fallDetector;
    
    UIAlertView *alert;
    
    // For testing purposes
    IBOutlet UILabel *longitude;
    IBOutlet UILabel *latitude;
    
    double x_accel;
    double y_accel;
    double z_accel;
    
    double lastlat, lastlon;
    
    NSInteger currentTimeDelay;
    NSTimer * notificationTimer;
    
    //background test
    UIBackgroundTaskIdentifier fallTask;
}

@property NSInteger currentTimeDelay;
@property NSTimer *notificationTimer;

- (IBAction)activateAccelerometer;
- (void)notifyUser:(NSTimer *)timer;
- (void)setTimer;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex ;

@end
