//
//  SecondViewController.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "SettingsViewController.h"
#import "AudioSettings.h"

@interface SettingsViewController()

@end

@implementation SettingsViewController
@synthesize swOn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];

    db = [[DBConnection alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
    NSString* ison;
    
    ison = [db getSetting:@"on"];
    
    if([ison isEqualToString:@"on"]) {
        [swOn setOn:true];

        NSLog(@"on loaded");
        //retrieve accelerometer data
        motionManager = [[CMMotionManager alloc]init];
        
        //if ([motionManager isAccelerometerAvailable]){
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [motionManager
             startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                 NSLog(@"X = %.04f, Y = %.04f, Z = %.04f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
             }];
        /*}else{
            NSLog(@"Accelerometer did not work.");
        }*/
    } else {
        [swOn setOn:false];
        NSLog(@"off loaded");
    }
    // retrieve accelerometer data
    motionManager = [[CMMotionManager alloc]init];

    if ([motionManager isAccelerometerAvailable]){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        [motionManager
         startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
             NSLog(@"X = %.04f, Y = %.04f, Z = %.04f", accelerometerData.acceleration.x, accelerometerData.acceleration.y, accelerometerData.acceleration.z);
         }];
    }else{
        NSLog(@"Accelerometer did not work.");
}
}



-(void)viewDidDisappear:(BOOL)animated {
    if (swOn.on) {
        [db setSetting:@"on" value:@"yes"];
    } else {
        [db setSetting:@"on" value:@"no"];
    }
}

- (void)viewDidUnload
{    
    [db closeDB];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Action to switch to the Audio Settings View
- (IBAction)goAudioSettings {
    AudioSettings *audioSettingsView = [[AudioSettings alloc] initWithNibName:@"AudioSettings" bundle:nil];
    audioSettingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:audioSettingsView animated:YES];
}

@end

