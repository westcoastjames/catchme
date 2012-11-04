//
//  ContactsViewController.h
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnection.h"

@interface ContactsViewController : UIViewController {
    DBConnection* db;
    UITapGestureRecognizer* tapRecognizer;
}

@property (nonatomic, strong) UITextField *txtNumber;

- (IBAction)goMainMenu;

@end
