//
//  ContactEdit.h
//  CatchMe
//
//  Created by Brian Mo on 11/23/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactEdit : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *email;
@property (nonatomic) int gid;
@property (nonatomic) bool shouldsms;
@property (nonatomic) bool shouldcall;
@property (nonatomic) bool shouldemail;


- (id)initWithName:(NSString *)name number:(NSString *)number email:(NSString *)email shouldcall:(BOOL *)shouldcall shouldsms:(BOOL *)shouldsms shouldemail:(BOOL *)shouldemail;


@end
