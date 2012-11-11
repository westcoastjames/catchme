//
//  MedicalInfoViewController.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 11/10/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalInfoViewController : UIViewController {
    UITapGestureRecognizer *tap;
    IBOutlet UITextView *medicalTextView;
}

@property UITapGestureRecognizer *tap;

- (IBAction)cancelChanges;
- (IBAction)saveChanges;
- (void)dismissKeyboard;

@end
