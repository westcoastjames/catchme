//
//  MessageSettingsViewController.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/11/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PostUploader.h"

@interface MessageSettingsViewController : UIViewController {
    UITapGestureRecognizer *tap;
    IBOutlet UITextView *messageTextView;
}

- (IBAction)cancelChanges;
- (IBAction)saveChanges;
- (void)dismissKeyboard;
- (IBAction)defaultMessage;

@end
