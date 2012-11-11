//
//  CoreLocationController.h
//  CatchMe
//
//  Created by Brian Mo on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface CoreLocationController : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    id delegate;
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) id delegate;



@end
