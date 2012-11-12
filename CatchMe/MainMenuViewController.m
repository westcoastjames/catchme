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
    motionManager.accelerometerUpdateInterval = (double)1/50;// 50 Hz
    
    if ([motionManager isAccelerometerAvailable] && [systemStatusSwitch isOn]){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [motionManager
         startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             
             x_accel = accelerometerData.acceleration.x;
             y_accel = accelerometerData.acceleration.y;
             z_accel = accelerometerData.acceleration.z;
             
             //NSLog(@"X = %.06f, Y = %.06f, Z = %.06f", x_accel, y_accel, z_accel);
            
             
             
             //NSLog(@"X = %@, Y = %.@, Z = %@", x_str, y_str, z_str);
            
             
             
             /*
             x_coord.text = x_str;
             y_coord.text = y_str;
             z_coord.text = y_str;
             */
             NSString *x_str = [NSString stringWithFormat:@"%0.6f", x_accel];
             NSString *y_str = [NSString stringWithFormat:@"%0.6f", y_accel];
             NSString *z_str = [NSString stringWithFormat:@"%0.6f", z_accel];
             [x_coord setText: x_str];
             [y_coord setText: y_str];
             [z_coord setText: z_str];
             //double vector_sum = sqrt(x_accel * x_accel + y_accel * y_accel + z_accel * z_accel);
             //NSLog(@"Vector Sum = %.06f", vector_sum);
         }];
        
    }
    else if(![systemStatusSwitch isOn]){
        NSLog(@"Accelerometer is off.");
    }
    else{
        NSLog(@"Accelerometer did not work.");
    }
    
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
    
    // Code for Audio playback plays sound when app is launched
    // Move this code to somewhere appropriate when testing is done
    /*NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/bell-ringing.mp3", [[NSBundle mainBundle] resourcePath]]];
    */
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bell-ringing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer play];
    
    


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