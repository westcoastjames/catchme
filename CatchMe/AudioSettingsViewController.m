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

@synthesize recordButton, stopButton, playButton, saveButton, defaultButton;

// Actions to occur when the window opens
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize audio recorder
    
    // Specify recorder file path
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"mp3"];

    NSURL *URLtoHoldFile = [NSURL fileURLWithPath:soundFilePath];
    
    NSError *recordError = nil;
    
    // Recorder settings
    NSDictionary *recorderSettings = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:AVAudioQualityHigh], AVEncoderAudioQualityKey, [NSNumber numberWithInt:16], AVEncoderBitRateKey, [NSNumber numberWithInt: 2], AVNumberOfChannelsKey, [NSNumber numberWithFloat:44100.0], AVSampleRateKey, nil];
    
    // Create recorder
    aRecorder = [[AVAudioRecorder alloc] initWithURL:URLtoHoldFile settings:recorderSettings error:&recordError];
    
    if (recordError) {
        NSLog(@"There was an error creating the recorder: %@", [recordError localizedDescription]);
    } else {
        [aRecorder prepareToRecord];
    }
    
    NSError *audioError; // will hold any error information that occurs during audio initialization
    aPlayer = [aPlayer initWithContentsOfURL:aRecorder.url error:&audioError]; // sets up audio player
    
    if (audioError) {
        NSLog(@"An error occured setting the audio player: %@", [audioError localizedDescription]);
    }
    
    [aPlayer setVolume:volumeSlider.value];
    
    // Initialize audio player to default sound file
    /*AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    [audioSession setActive:YES error: nil];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bell-ringing" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    audioPlayer.numberOfLoops = -1;
    [audioPlayer setVolume:1.0];*/
}

// Actions to take place when the window closes
- (void)viewDidUnload
{
    volumeSlider = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Checks to see if the interface is correctly oriented
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Starts recording audio message
- (IBAction)recordSound {
    
    if (!aRecorder.recording) {
        playButton.enabled = FALSE;
        recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        
        [aRecorder record];
    }
     
}

// Stops recording audio message || stops playing audio message
- (IBAction)stopSound {
    
    playButton.enabled = TRUE;
    recordButton.enabled = TRUE;
    stopButton.enabled = FALSE;
    
    if (aRecorder.recording) {
        [aRecorder stop];
    }
    else if (aPlayer.playing) {
        [aRecorder stop];
    }
}

// Starts playing audio message
- (IBAction)playSound {
    
    if (!aRecorder.recording) {
        //recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        
        NSError *audioError; // will hold any error information that occurs during audio initialization
        
        aPlayer = [aPlayer initWithContentsOfURL:aRecorder.url error:&audioError]; // sets up audio player
        
        if (audioError) {
            NSLog(@"An error occured setting the audio player: %@", [audioError localizedDescription]);
        }
        else {
            [aPlayer play];
        }
    }
}

- (IBAction)defaultSound {
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"default-audio-alert" ofType:@"mp3"];
    NSURL *URLtoHoldFile = [NSURL fileURLWithPath:soundFilePath];
}

// Saves the audio message
- (IBAction)saveSound {
    //TODO
}

// Changes playback volume in Audio Settings
- (IBAction)changeVolume {
    [aPlayer setVolume:volumeSlider.value];
}


- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

@end
