//
//  AudioSettingsViewController.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 10/20/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioRecorder.h>

@interface AudioSettingsViewController : UIViewController {
    
    UIWindow *window;
    
    UIButton *recordButton;
    UIButton *stopButton;
    UIButton *playButton;
    UIButton *saveButton;
    UIButton *defaultButton;
    
    AVAudioRecorder *aRecorder;
    AVAudioPlayer *aPlayer;
}

@property (nonatomic) IBOutlet UIButton *recordButton;
@property (nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic) IBOutlet UIButton *defaultButton;

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)recordSound;
- (IBAction)stopSound;
- (IBAction)playSound;
- (IBAction)saveSound;
- (IBAction)defaultSound;
- (IBAction)goMainMenu;

@end
