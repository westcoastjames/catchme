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
    
    if ([motionManager isAccelerometerAvailable] && [systemStatusSwitch isOn]){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [motionManager
         startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             // ALGORITHM USED TO DETECT A BASIC FALLING MOTION
             
             // Get the x, y, z values
             double x_accel = accelerometerData.acceleration.x;
             double y_accel = accelerometerData.acceleration.y;
             double z_accel = accelerometerData.acceleration.z;
             
             // For testing purposes
             NSLog(@"X = %.06f, Y = %.06f, Z = %.06f", x_accel, y_accel, z_accel);
             
             // Compute vector sum of data
             double vector_sum = sqrt(x_accel * x_accel + y_accel * y_accel + z_accel * z_accel);
             //NSLog(@"Vector Sum = %.06f", vector_sum);
             
             // Thresholds for different types of motions in comparison to the vector sum
             float freeFallThreshold = 0.2; // The user is falling
             float landedThreshold = 2.0; // The user hits the ground
             
             // Basic free fall test
             if(vector_sum < freeFallThreshold) {
                 
             }
         }];
    }
    else {
        NSLog(@"Accelerometer did not work.");
    }
    

    // Create alert notification
    alert = [[UIAlertView alloc] initWithTitle:@"A Fall Was Detected!" message:@"Press ok to dismiss this alert." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // To show the alert
    [alert show];
    
    // To hide the alert (use timer!)
    //[alert dismissWithClickedButtonIndex:0 animated:TRUE];
    
}

- (void)viewWillAppear:(BOOL)animated {
    /* Commented Pitch, Roll, Yaw out until we actually need it for the falling algorithm.
     motionManager = [[CMMotionManager alloc] init];
     motionManager.deviceMotionUpdateInterval = 0.05; // 20 Hz
     
     [motionManager startDeviceMotionUpdates];
     NSLog(@"Pitch = %.02f, Roll = %.02f, Yaw = %.02f", motionManager.deviceMotion.attitude.pitch, motionManager.deviceMotion.attitude.roll, motionManager.deviceMotion.attitude.yaw);
     */
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
    
    // Code for Audio playback
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/bell-ringing.mp3", [[NSBundle mainBundle] resourcePath]]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    audioPlayer.numberOfLoops = -1;
    
    if (audioPlayer == nil){
        NSLog([error description]);
    }
    else {
        [audioPlayer play];
    }


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
    NSLog(@"Latitude: %d° %d' %1.4f\"",degrees, minutes, seconds);
    
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal *60;
    seconds = decimal *3600 - minutes *60;
    NSLog(@"Longitude: %d° %d' %1.4f\"",degrees, minutes, seconds);
}

@end