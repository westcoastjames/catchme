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
    
    // Used to access user settings data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // Retrieve accelerometer data
    motionManager = [[CMMotionManager alloc]init];
    motionManager.accelerometerUpdateInterval = (double)1/50;// 50 Hz  Frequency affects the sensitivity of the fall detection
    
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
             struct timeval tv;
             gettimeofday(&tv,nil);
             startsecs = tv.tv_sec * 1000 + tv.tv_usec / 1000;
             
             NSLog(@"&,%ld,%0.6f,%0.6f,%0.6f",startsecs,x_accel,y_accel,z_accel);
             
             if([fallDetector hasFallen]) {
                 
                 // Reset fall detector so alerts will show oonly once
                 [fallDetector reset];
                 
                 NSLog(@"**** FALL DETECTED ****");
                 
                 NSInteger timeDelay = [defaults integerForKey:@"timeDelay"];
                 bool audioNotificationOn = [defaults boolForKey:@"audioNotificationOn"];
                 bool vibrationNotificationOn = [defaults boolForKey:@"vibrationNotificationOn"];
                 
                 // Run the alert in the main thread to prevent app from crashing
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [alert show];
                 });
                 
                 if (vibrationNotificationOn) {
                     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                 }
                 if (audioNotificationOn) {
                     // Delay playback to 4 seconds
                     //startAudioTime = 4.0;
                     //[audioPlayer playAtTime:audioPlayer.deviceCurrentTime + startAudioTime];
                     [audioPlayer play];
                 }
                 
                 
                 // NEED TO ADD TIMING, notification should stay up for timeDelay seconds, stopping all notifications once timeDelay is reached, then alerts shouldbe sent out
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
        [audioPlayer stop];
    }
    else {
        NSLog(@"Accelerometer did not work.");
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
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
    
    // GPS location manager
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; //updates whenever you move
    locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; //accuracy of the GPS
    [locationManager startUpdatingLocation];
    
    // Code for Audio playback plays sound when fall is detected
    AVAudioSession * audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    [audioSession setActive:YES error: nil];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bell-ringing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer setVolume:1.0];
    
    
    // Create alert notification
    alert = [[UIAlertView alloc]initWithTitle:@"A Fall Was Detected!"
                                      message:@"Press ok to dismiss this alert."
                                     delegate:nil
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [db closeDB];
}

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
    NSLog(@"Latitude: %@\"",lat_str);
    
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal *60;
    seconds = decimal *3600 - minutes *60;
    NSString *long_str = [NSString stringWithFormat:@"%d° %d' %1.4f", degrees, minutes, seconds];
    NSLog(@"Longitude: %@\"",long_str);
    
    // Testing purposes
    [longitude setText:long_str];
    [latitude setText:lat_str];
}

@end