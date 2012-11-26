//
//  PersonalInfoViewController.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PostUploader.h"

@interface PersonalInfoViewController : UIViewController {
    IBOutlet UITextField *firstNameTextField;
    IBOutlet UITextField *lastNameTextField;
    IBOutlet UITextField *monthTextField;
    IBOutlet UITextField *dayTextField;
    IBOutlet UITextField *yearTextField;
    IBOutlet UITextField *addressTextField;
    IBOutlet UITextField *careCardTextField;
    IBOutlet UILabel *invalidDate;
    IBOutlet UILabel *invalidCardNum;
    UITapGestureRecognizer *tap;
}

@property UITapGestureRecognizer *tap;

- (IBAction)cancelChanges;
- (IBAction)saveInfo;
- (void)dismissKeyboard;

@end
