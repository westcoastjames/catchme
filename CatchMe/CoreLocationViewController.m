//
//  CoreLocationViewController.m
//  CatchMe
//
//  Created by Brian Mo on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "CoreLocationViewController.h"

@implementation CoreLocationViewController


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)viewDIdLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever the user moves it updates
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //accuracy
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal *3600 - minutes *60;
    NSLog(@"%d° %d' %1.4f\"",degrees, minutes, seconds);
    
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal *60;
    seconds = decimal *3600 - minutes *60;
    NSLog(@"%d° %d' %1.4f\"",degrees, minutes, seconds);
}



@end
