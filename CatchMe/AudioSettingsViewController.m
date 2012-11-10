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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize audio recorder
   // NSURL *URLtoHoldFile = [NSURL fileURLWithPath:soundFilePath];
    NSError *recordError = nil;
    
    NSDictionary *recorderSettings = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInt:AVAudioQualityHigh], AVEncoderAudioQualityKey,
                                      [NSNumber numberWithInt:16], AVEncoderBitRateKey, [NSNumber numberWithInt: 2], AVNumberOfChannelsKey,
                                      [NSNumber numberWithFloat:44100.0], AVSampleRateKey, nil];
    
   // aRecorder = [[AVAudioRecorder alloc] initWithURL:URLtoHoldFile settings:recorderSettings error:&recordError];
    
    if (recordError) {
        NSLog(@"error: %@", [recordError localizedDescription]);
    } else {
        [aRecorder prepareToRecord];
    }
    
    
    // Initialize audio player to default sound file
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Starts recording audio message
- (IBAction)recordSound:(id) sender {
    if (!aRecorder.recording) {
        playButton.enabled = FALSE;
        recordButton.enabled = FALSE;
        stopButton.enabled = TRUE;
        
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
    
    //Testing
    NSLog(@"The stop button was pressed");
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

- (IBAction)defaultSound {
    //TODO
}

// Saves the audio message
- (IBAction)saveSound {
    //TODO
}


- (IBAction)goMainMenu {
    [self dismissModalViewControllerAnimated:YES];
    //[self resignFirstResponder];
}

@end
