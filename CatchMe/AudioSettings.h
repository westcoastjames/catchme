//
//  AudioSettings.h
//  CatchMe
//
//  Created by Nicholas Hoekstra on 10/20/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVAudioRecorder.h>

@interface AudioSettings : NSObject {
    
    UIWindow *window;
    
    UIButton *recordButton;
    UIButton *stopButton;
    UIButton *playButton;
    UIButton *saveButton;
    
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
}

@property (nonatomic) IBOutlet UIButton *recordButton;
@property (nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)recordSound;
- (IBAction)stopSound;
- (IBAction)playSound;
- (IBAction)saveSound;

@end
