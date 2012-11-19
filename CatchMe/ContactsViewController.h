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

@property (nonatomic, strong) IBOutlet UITextField *nameInput;
@property (nonatomic, strong) IBOutlet UITextField *txtNumberInput;
@property (nonatomic, strong) IBOutlet UITextField *emailInput;

@property UITapGestureRecognizer *tap;
@property (strong, nonatomic) Contact *contact;


- (IBAction)cancelChanges;
- (IBAction)goMainMenu;
- (void)dismissKeyboard;

@end
