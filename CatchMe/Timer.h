//
//  Timer.h
//  CatchMe
//
//  Created by James Hezron Velasco on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject {
    NSDate *start;
    NSDate *end;
}
- (void)startTimer;
- (void)stopTimer;
- (double)timeElapsedInMilliseconds;

@end
