//
//  SettingsViewController.h
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"

@interface SettingsViewController : UIViewController{
    UISwitch* swOn;
    DBConnection* db;
}

@property (nonatomic, strong) UISwitch* swOn;

@end