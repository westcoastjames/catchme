//
//  AudioSettings.m
//  CatchMe
//
//  Created by Nicholas Hoekstra on 10/20/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "AudioSettings.h"
#import "AVFoundation/AVAudioRecorder.h"
#import "AVFoundation/AVAudioPlayer.h"

// Audio recording and playbac can be done through the use of the AVAudioRecorder and AVAudioPlayer API

@implementation AudioSettings

@synthesize recordButton, stopButton, playButton, saveButton;

// Starts recording audio message
- (IBAction)recordSound {
    if (!aRecorder.recording) {
        recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        playButton.enabled = FALSE;
        
        [aRecorder record];
    }
}

// Stops recording audio message || stops playing audio message
- (IBAction)stopSound {
    stopButton.enabled = FALSE;
    playButton.enabled = TRUE;
    recordButton.enabled = TRUE;
    
    if (aRecorder.recording) {
        [aRecorder stop];
    } else if (aPlayer.playing) {
        [aRecorder stop];
    }
}

// Starts playing audio message
- (IBAction)playSound {
    if (!_audioRecorder.recording) {
        playButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        recordButton.enabled = FALSE;
        
        [_audioPlayer play];
    }
}

// Saves the audio message
- (IBAction)saveSound {
    //TODO
}


@end
