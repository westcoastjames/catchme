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

@interface ContactsViewController : UIViewController {
    DBConnection *db;
    IBOutlet UITextField *txtNumber;
    UITapGestureRecognizer *tap;
}

@property (nonatomic, strong) IBOutlet UITextField *txtNumber;

@property UITapGestureRecognizer *tap;

- (IBAction)goMainMenu;
- (void)dismissKeyboard;

@end
