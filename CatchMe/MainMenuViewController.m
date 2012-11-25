//
//  MainMenuViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//  
//  BUG: Multiple alert notifications are shown when fall is detected in activateAccelerator method.

#import "MainMenuViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

@synthesize notificationTimer, currentTimeDelay;

// Constructor
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

// Contains the actions that pertain to the accelerometer
// Activated through the switch on the main menu
- (IBAction)activateAccelerometer {
    
    // Retrieve accelerometer data
    motionManager = [[CMMotionManager alloc]init];
    motionManager.accelerometerUpdateInterval = (double)1/50; // 50 Hz  Frequency affects the sensitivity of the fall detection
    
    if ([motionManager isAccelerometerAvailable] && [systemStatusSwitch isOn]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        fallDetector = [[FallDetector alloc]init];
        [motionManager
         startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             
             // ALGORITHM USED TO DETECT A BASIC FALLING MOTION
             
             // Get the x, y, z values
             x_accel = accelerometerData.acceleration.x;
             y_accel = accelerometerData.acceleration.y;
             z_accel = accelerometerData.acceleration.z;
             [fallDetector receiveDataX:x_accel Y:y_accel Z:z_accel];
             
             if([fallDetector hasFallen]) {
                 
                 // Reset fall detector so alerts will show only once
                 [fallDetector reset];
                 
                 NSLog(@"**** FALL DETECTED ****");
                 
                 // Run the alert in the main thread to prevent app from crashing
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [alert show];
                 });
                 
                 [self setTimer];
                 
                 // Used to access user settings data
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 bool audioNotificationOn = [defaults boolForKey:@"audioNotificationOn"];
                 
                 if (audioNotificationOn) {
                     [audioPlayer play];
                 }
             }
             
             // TEST LABELS ON MAIN WINDOW
             NSString *x_str = [NSString stringWithFormat:@"%0.6f", x_accel];
             NSString *y_str = [NSString stringWithFormat:@"%0.6f", y_accel];
             NSString *z_str = [NSString stringWithFormat:@"%0.6f", z_accel];
             [x_coord setText: x_str];
             [y_coord setText: y_str];
             [z_coord setText: z_str];
             
         }];
        
    }
    // Switch accelerometer detection off
    else if(![systemStatusSwitch isOn]){
        NSLog(@"Accelerometer detection is off.");
    }
    else {
        NSLog(@"Accelerometer did not work.");
    }
}

// Execute the timer
- (void) setTimer {
    // Starts notifying a fall has been detected until the timeDelay has passed or the user dismisses
    notificationTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(notifyUser:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:notificationTimer forMode:NSRunLoopCommonModes];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger timeDelay = [defaults integerForKey:@"timeDelay"];
    
    while(alert.visible)
    {
        // allow the run loop to run for, arbitrarily, 2 seconds
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:timeDelay]];
    }
}

// Timer method used to notify user when a fall has been detected, continues executing until set time has passed or alert has been dismissed
- (void)notifyUser:(NSTimer *)timer {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool vibrationNotificationOn = [defaults boolForKey:@"vibrationNotificationOn"];
    NSInteger timeDelay = [defaults integerForKey:@"timeDelay"];
    NSLog(@"Notify user reached, timeDelay: %i currentTimeDelay: %i vibrationOn: %d alert visible: %d", timeDelay, currentTimeDelay, vibrationNotificationOn, alert.visible);
    
    currentTimeDelay = currentTimeDelay + 1;
    
    if((currentTimeDelay < timeDelay) && vibrationNotificationOn && alert.visible) {
        NSLog(@"Vibration method reached");
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    else {
        NSLog(@"Kill everything reached");
        // Kill timer, hide alert, stop sound
        [notificationTimer invalidate];
        
        if (audioPlayer.playing) {
            [audioPlayer stop];
        }
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        // [alert release];
    }
}

// Actions that should take place after the the user has been notified of a detected fall
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"This alert sending out method was reached");
    // If alert was dismissed, reset the fall detection algorithm
    if (buttonIndex == 1) {
        NSLog(@"Fall dismissed");
        [fallDetector reset];
        currentTimeDelay = 0;
    }
    
    // Else begin sending out audio and message alerts
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *soundFileName = [defaults objectForKey:@"soundFileName"];
        CGFloat messageVolume = [defaults floatForKey:@"messageVolume"];
        bool audioMessageOn = [defaults boolForKey:@"audioMessageOn"];
        currentTimeDelay = 0;
        
        if (audioMessageOn) {
            NSLog(@"Audio message alert played");
            NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"caf"];
            NSURL *url = [NSURL fileURLWithPath:soundPath];
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            audioPlayer.numberOfLoops = 0;
            [audioPlayer setVolume:messageVolume];
            [audioPlayer play];
        }
        
        // NEED TO ADD SENDING OUT MESSAGES TO CONTACTS
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if (systemStatusSwitch.on) {
        [db setSetting:@"on" value:@"yes"];
    } else {
        [db setSetting:@"on" value:@"no"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // For reseting alert notification
    currentTimeDelay = 0;
    
    // GPS location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // Updates whenever you move
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; // Accuracy of the GPS
    [locationManager startUpdatingLocation];
    
    // Code for Audio playback plays sound when fall is detected
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    [audioSession setActive:YES error: nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat messageVolume = [defaults floatForKey:@"messageVolume"];
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"bell-ringing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer setVolume:messageVolume];
    
    
    // Create alert notification
    alert = [[UIAlertView alloc]initWithTitle:@"A Fall Was Detected!"
                                      message:@"Do you require assistence?"
                                     delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Yes, help me!", @"No, dismiss alert.", nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [db closeDB];
}

// Makes sure interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// GPS delegate method called when new location is available
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal *3600 - minutes *60;
    NSString *lat_str = [NSString stringWithFormat:@"%d° %d' %1.4f", degrees, minutes, seconds];
    //NSLog(@"Latitude: %@\"",lat_str);
    
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal *60;
    seconds = decimal *3600 - minutes *60;
    NSString *long_str = [NSString stringWithFormat:@"%d° %d' %1.4f", degrees, minutes, seconds];
    //NSLog(@"Longitude: %@\"",long_str);
    
    // Testing purposes
    [longitude setText:long_str];
    [latitude setText:lat_str];
}

@end