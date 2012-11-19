//
//  ContactsViewController.h
//  CatchMe
//
//  Created by Jonathon Simister-Jennings on 10/21/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConnection.h"
#import <UIKit/UIKit.h>

@class Contact;

@interface ContactsViewController : UIViewController {
    DBConnection *db;
    IBOutlet UITextField *txtNumber;
    IBOutlet UITextField *name;
    IBOutlet UITextField *email;
    UITapGestureRecognizer *tap;
}

@property (nonatomic, strong) IBOutlet UITextField *name;
@property (nonatomic, strong) IBOutlet UITextField *txtNumber;
@property (nonatomic, strong) IBOutlet UITextField *email;

@property UITapGestureRecognizer *tap;

- (IBAction)goMainMenu;
- (void)dismissKeyboard;

@end
