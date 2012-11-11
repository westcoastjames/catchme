//
//  CoreLocationViewController.h
//  CatchMe
//
//  Created by Brian Mo on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CoreLocationViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;

}

@end
