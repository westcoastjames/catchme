//
//  Timer.m
//  CatchMe
//
//  Created by James Hezron Velasco on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "Timer.h"

@implementation Timer

- (id)init{
    self = [super init];
    if(self){
        start = nil;
        end = nil;
    }
    return self;
}

- (void)startTimer {
    start = [NSDate date];
}

- (void)stopTimer {
    end = [NSDate date];
}

- (double) timeElapsedInMilliseconds{
    return [end timeIntervalSinceDate:start] * 1000.0f;
}

@end
