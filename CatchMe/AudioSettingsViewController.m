//
//  AudioSettingsViewController.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 10/20/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "AudioSettingsViewController.h"
#import "AVFoundation/AVAudioRecorder.h"
#import "AVFoundation/AVAudioPlayer.h"

// Audio recording and playback can be done through the use of the AVAudioRecorder and AVAudioPlayer API

@implementation AudioSettingsViewController

@synthesize recordButton, stopButton, playButton, saveButton;

// Recorder needs to be initialized in a method

// Starts recording audio message
- (IBAction)recordSound:(id) sender {
    if (!aRecorder.recording) {
        playButton.enabled = FALSE;
        recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        
        
        [aRecorder prepareToRecord];
        [aRecorder record];
    }
}

// Stops recording audio message || stops playing audio message
- (IBAction)stopSound:(id) sender {
    
    playButton.enabled = TRUE;
    recordButton.enabled = TRUE;
    stopButton.enabled = FALSE;
    
    if (aRecorder.recording)
        [aRecorder stop];
    else if (aPlayer.playing)
        [aRecorder stop];
}

// Starts playing audio message
- (IBAction)playSound:(id) sender {
    if (!_audioRecorder.recording) {
        recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        
        NSError *audioError; // will hold any error information that occurs during audio initialization
        
        aPlayer = [aPlayer initWithContentsOfURL:aRecorder.url error:&audioError]; // sets up audio player
        
        if (audioError)
            NSLog(@"An Error Occured: %@", [audioError localizedDescription]);
        else
            [aPlayer play];
    }
}

// Saves the audio message
- (IBAction)saveSound {
    //TODO
}


-(IBAction)goMainMenu {
    [self dismissModalViewControllerAnimated:YES];
}

@end
