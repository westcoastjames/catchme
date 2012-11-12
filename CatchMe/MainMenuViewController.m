//
//  MainMenuViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "MainMenuViewController.h"

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

- (IBAction)activateAccelerometer {
    

    // Retrieve accelerometer data
    motionManager = [[CMMotionManager alloc]init];
    motionManager.accelerometerUpdateInterval = (double)1/50;// 50 Hz  Frequency affects the sensitivity of the fall detection
    
    if ([motionManager isAccelerometerAvailable] && [systemStatusSwitch isOn]){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [motionManager
         startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             struct timeval tv;
             gettimeofday(&tv,nil);
             
             // ALGORITHM USED TO DETECT A BASIC FALLING MOTION
             
             // Get the x, y, z values
             x_accel = accelerometerData.acceleration.x;
             y_accel = accelerometerData.acceleration.y;
             z_accel = accelerometerData.acceleration.z;
             
             //NSLog(@"X = %.06f, Y = %.06f, Z = %.06f", x_accel, y_accel, z_accel);
             
             // Compute vector sum of data
             double vector_sum = sqrt(x_accel * x_accel + y_accel * y_accel + z_accel * z_accel);
             //NSLog(@"X = %@, Y = %.@, Z = %@", x_str, y_str, z_str);
             
             NSLog(@"Vector Sum: %0.6f", vector_sum);
             
             // Thresholds for different types of motions in comparison to the vector sum
             float freeFallThreshold = 0.3; // The user is falling
             float landedThreshold = 2.0; // The user hits the ground
             
             UIAlertView *alert;
             
             NSLog(@"Point1 Reached~~~~~~~~~");
             // Basic free fall test
             if(vector_sum < freeFallThreshold) {
                 NSLog(@"Point2 Reached~~~~~~~~~~~~~~~~~~~~~");
                 startsecs = tv.tv_sec;
             }
             else if(vector_sum > landedThreshold && ((tv.tv_sec - startsecs) < 2)) {
                 alert = [[UIAlertView alloc]initWithTitle:@"A Fall Was Detected!"
                                                   message:@"Press ok to dismiss this alert."
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
                 
                 
                 NSLog(@"**** FALL DETECTED ****");
                 
                 // Run the alert in the main thread to prevent app from crashing
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [alert show];
                 });
                 
                 [audioPlayer play];
                 
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

//GPS delegate method called when new location is available
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