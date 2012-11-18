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

    IBOutlet UISlider *volumeSlider;
    AVAudioRecorder *aRecorder;
    AVAudioPlayer *aPlayer;
    
    NSURL *URLtoHoldFile;
}

@property (strong, nonatomic) IBOutlet UIButton *recordButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *defaultButton;
@property (strong, nonatomic) IBOutlet UISlider *volumeSlider;

@property (strong, nonatomic) AVAudioRecorder *aRecorder;
@property (strong, nonatomic) AVAudioPlayer *aPlayer;

@property (strong, nonatomic) NSURL *URltoHoldFile;

- (IBAction)recordSound;
- (IBAction)stopSound;
- (IBAction)playSound;
- (IBAction)saveSound;
- (IBAction)defaultSound;
- (IBAction)cancelChanges;
- (IBAction)changeVolume;

@end
