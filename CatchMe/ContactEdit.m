//
//  ContactEdit.m
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactEdit.h"

@implementation ContactEdit

@synthesize name = _name;
@synthesize number = _number;
@synthesize email = _email;
@synthesize gid = _gid;
@synthesize shouldcall = _shouldcall;
@synthesize shouldsms = _shouldsms;
@synthesize shouldemail = _shouldemail;

- (id)initWithName:(NSString *)name number:(NSString *)number email:(NSString *)email {
    self = [super init];
    
    if(self) {
        self.name = name;
        self.number = number;
        self.email = email;
        self.gid = 0;
        self.shouldcall = false;
        self.shouldsms = true;
        self.shouldemail = false;
        
    }
    return self;
}

@end
