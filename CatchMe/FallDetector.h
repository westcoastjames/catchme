//
//  FallDetector.h
//  CatchMe
//
//  Created by Jonathon Simister on 11/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#define highacc 1.9
#define lowacc 0.6


@interface FallDetector : NSObject {
    double* framea;
    double* frameb;
    
    int frameac;
    int framebc;
    bool startedb;
    
    bool bFallen;
    
    
}

- (void)receiveDataX:(double)x Y:(double)y Z:(double)z;
- (bool)hasFallen;
- (void)reset;

@end
