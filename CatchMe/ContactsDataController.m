//
//  ContactsDataController.m
//  CatchMe
//
//  Created by Brian Mo on 11/18/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "ContactsDataController.h"
#import "Contact.h"

//declare list creation
@interface ContactsDataController ()

- (void)initializeDefaultDataList;

@end


@implementation ContactsDataController

//make the default list

- (void)initializeDefaultDataList {
    NSMutableArray *contactList = [[NSMutableArray alloc]init];
    self.masterContactList = contactList;
    Contact *cont;
    cont = [[Contact alloc] initWithName:@"Name" number:@"000-0000" email:@"example@test.com"];
    [self addContact:cont];
}


//custom setter for master list
- (void)setMasterContactList:(NSMutableArray *)newList {
    if(_masterContactList != newList) {
        _masterContactList = [newList mutableCopy];
    }
}

//initialize data controller object
- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}


- (NSUInteger)countOfList {
    return [self.masterContactList count];
}


- (Contact *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterContactList objectAtIndex:theIndex];
}

- (void)addContact:(Contact *)cont {
    [self.masterContactList addObject:cont];
}

@end
