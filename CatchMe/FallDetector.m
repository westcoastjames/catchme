//
//  FallDetector.m
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 11/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "FallDetector.h"

@implementation FallDetector

- (id)init{
    self = [super init];
    if(self){
        framea = malloc(sizeof(double)*75); // based on 1.5 second frames at 50 Hz
        frameb = malloc(sizeof(double)*75);
        
        frameac = 0;
        startedb = false;
        
        bFallen = false;
    }
    return self;
}

bool fallen(double* frame) {
    int c;
    double max = frame[0];
    double min = frame[0];
    int mint = 0;
    int maxt = 0;
    
    for(c = 1;c < 75;c++) {
        if(frame[c] > max) {
            max = frame[c];
            maxt = c;
        }
        if(frame[c] < min) {
            min = frame[c];
            mint = c;
        }
    }
    
    if((max >= highacc)
       && (min <= lowacc)
       && (mint < maxt)) {
        return true;
    } else {
        return false;
    }
}

- (void)receiveDataX:(double)x Y:(double)y Z:(double)z {
    double rms = sqrt((x*x) + (y*y) + (z*z));
    
    if(bFallen) { return; }
    
    framea[frameac] = rms;
    frameac++;
    
    if(frameac == 37 && !startedb) {
        startedb = true;
        framebc = 0;
    }
    
    if(startedb) {
        frameb[framebc] = rms;
        framebc++;
    }
    
    if(frameac > 74) {
        bFallen = fallen(framea);
        frameac = 0;
    }
    if(framebc > 74) {
        
        // there's no conceivable way that both of these can go at the same time, so it doesn't matter that we overwrite
        bFallen = fallen(frameb); 
        
        framebc = 0;
    }
}

- (bool)hasFallen {
    return bFallen;
}

-(void)reset {
    frameac = 0;
    startedb = false;
    bFallen = false;
}

@end
