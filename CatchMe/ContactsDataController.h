//
//  ContactsDataController.h
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

//this class stores contact objects in a mutable array

#import <Foundation/Foundation.h>

@class Contact;

@interface ContactsDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterContactList;

- (NSUInteger)countOfList;
- (Contact *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addContact:(Contact *)cont;

@end
