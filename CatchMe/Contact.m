//
//  Contact.m
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(id)initWithName:(NSString *)name number:(NSString *)number email:(NSString *)email
{
    self = [super init];
    if (self) {
        _name = name;
        _number = number;
        _email = email;
        return self;
    }
    return nil;
}

@end
