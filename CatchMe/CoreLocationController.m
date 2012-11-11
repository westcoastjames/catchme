//
//  CoreLocationController.m
//  CatchMe
//
//  Created by Brian Mo on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "CoreLocationController.h"

@implementation CoreLocationController
@synthesize locationManager, delegate;

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if([delegate conformsToProtocol:@protocol(CoreLocationControllerDelegate)]) {
        [delegate locationError:error];
    }
    
}

- (void)dealloc {
    [locationManager release];
    [super dealloc];
}


@end
