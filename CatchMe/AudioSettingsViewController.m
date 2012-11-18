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
#import <CoreAudio/CoreAudioTypes.h>

// Audio recording and playback can be done through the use of the AVAudioRecorder and AVAudioPlayer API

@implementation AudioSettingsViewController

@synthesize recordButton, stopButton, playButton, saveButton, defaultButton;

// Actions to occur when the window opens
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    playButton.enabled = TRUE;
    [playButton setBackgroundColor:[UIColor greenColor]];
    recordButton.enabled = TRUE;
    [recordButton setBackgroundColor:[UIColor greenColor]];
    stopButton.enabled = FALSE;
    [stopButton setBackgroundColor:[UIColor redColor]];
    defaultButton.enabled = TRUE;
    [defaultButton setBackgroundColor:[UIColor greenColor]];
    
    // Initialize audio recorder
    
    // Specify recorder file path
    NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* fullFilePath = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"recorded-audio-alert.caf"];
    URLtoHoldFile = [NSURL fileURLWithPath:fullFilePath];
    
    NSError *recordError = nil; // will hold any error information that occurs during the recorder initialization
    
    // Recorder settings
    NSDictionary *recorderSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInt:AVAudioQualityHigh], AVEncoderAudioQualityKey,
                                      [NSNumber numberWithInt:kAudioFormatAppleIMA4], AVFormatIDKey,
                                      [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                      [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                      [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                      nil];
    
    // Create recorder
    aRecorder = [[AVAudioRecorder alloc] initWithURL:URLtoHoldFile settings:recorderSettings error:&recordError];
    
    if (recordError) {
        NSLog(@"There was an error creating the recorder: %@", [recordError localizedDescription]);
    }
    
    [aRecorder prepareToRecord];
    
    // Initialize audio player
    fullFilePath = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"saved-audio-alert.mp3"];
    URLtoHoldFile = [NSURL fileURLWithPath:fullFilePath];
    
    NSError *audioError; // will hold any error information that occurs during audio initialization
    aPlayer = [aPlayer initWithContentsOfURL:URLtoHoldFile error:&audioError]; // sets up audio player
    
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
        [playButton setBackgroundColor:[UIColor redColor]];
        recordButton.enabled = FALSE;
        [recordButton setBackgroundColor:[UIColor redColor]];
        stopButton.enabled = TRUE;
        [stopButton setBackgroundColor:[UIColor greenColor]];
        defaultButton.enabled = FALSE;
        [defaultButton setBackgroundColor:[UIColor redColor]];
        
        [aRecorder record];
        URLtoHoldFile = aRecorder.url;
    }
     
}

// Stops recording audio message || stops playing audio message
- (IBAction)stopSound {
    
    playButton.enabled = TRUE;
    [playButton setBackgroundColor:[UIColor greenColor]];
    recordButton.enabled = TRUE;
    [recordButton setBackgroundColor:[UIColor greenColor]];
    stopButton.enabled = FALSE;
    [stopButton setBackgroundColor:[UIColor redColor]];
    defaultButton.enabled = TRUE;
    [defaultButton setBackgroundColor:[UIColor greenColor]];
    
    if (aRecorder.recording) {
        [aRecorder stop];
    }
    else if (aPlayer.playing) {
        [aPlayer stop];
    }
}

// Starts playing audio message
- (IBAction)playSound {
    
    if (!aRecorder.recording) {
        playButton.enabled = FALSE;
        [playButton setBackgroundColor:[UIColor redColor]];
        recordButton.enabled = FALSE;
        [recordButton setBackgroundColor:[UIColor redColor]];
        stopButton.enabled = TRUE;
        [stopButton setBackgroundColor:[UIColor greenColor]];
        defaultButton.enabled = FALSE;
        [defaultButton setBackgroundColor:[UIColor redColor]];
        
        NSError *audioError; // will hold any error information that occurs during audio initialization
        
        aPlayer = [aPlayer initWithContentsOfURL:URLtoHoldFile error:&audioError]; // sets up audio player
        
        if (audioError) {
            NSLog(@"An error occured setting the audio player: %@", [audioError localizedDescription]);
        }
        else {
            [aPlayer play];
        }
    }
}

- (IBAction)defaultSound {
    NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* fullFilePath = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"default-audio-alert.caf"];
    URLtoHoldFile = [NSURL fileURLWithPath:fullFilePath];
}

// Saves the audio message
- (IBAction)saveSound {
    //TODO
    [self dismissModalViewControllerAnimated:YES];
}

// Changes playback volume in Audio Settings
- (IBAction)changeVolume {
    [aPlayer setVolume:volumeSlider.value];
}


- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

@end
