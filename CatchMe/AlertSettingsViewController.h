//
//  AlertSettingsViewController.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertSettingsViewController : UIViewController {
    IBOutlet UITextField *timeDelayTextField;
    IBOutlet UISwitch *audioNotification;
    IBOutlet UISwitch *vibrationNotification;
    UITapGestureRecognizer *tap;
}

- (IBAction)cancelChanges;
- (IBAction)dismissKeyboard;
- (IBAction)saveInfo;

@end
