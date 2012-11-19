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
#import <AVFoundation/AVFoundation.h>

// Audio recording and playback can be done through the use of the AVAudioRecorder and AVAudioPlayer API

@implementation AudioSettingsViewController

@synthesize recordButton, stopButton, playButton, saveButton, defaultButton;

// Actions to occur when the window opens
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Sets buttons to enable/disable
    playButton.enabled = TRUE;
    [playButton setBackgroundColor:[UIColor greenColor]];
    recordButton.enabled = TRUE;
    [recordButton setBackgroundColor:[UIColor greenColor]];
    stopButton.enabled = FALSE;
    [stopButton setBackgroundColor:[UIColor redColor]];
    defaultButton.enabled = TRUE;
    [defaultButton setBackgroundColor:[UIColor greenColor]];
    
    // Load any setting values previously saved
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    bool audioMessageOn = [defaults boolForKey:@"audioMessageOn"];
    CGFloat messageVolume = [defaults floatForKey:@"messageVolume"];
    NSString *soundFileName = [defaults objectForKey:@"soundFileName"];
    
    NSLog(@"The file name is: %@", soundFileName);
    
    if (soundFileName == nil) {
        soundFileName = @"default-audio-alert";
    }
    
     NSLog(@"The file name is: %@", soundFileName);
    
    if (audioMessageOn) {
        [audioMessageStatus setOn:YES];
    }
    
    if (messageVolume != 0) {
        volumeSlider.value = messageVolume;
    }
    
    // Initialize audio session
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
    [audioSession setActive:YES error: nil];
    
    // Initialize audio recorder
    
    // Specify recorder file path
    //NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *fullFilePath = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"recorded-audio-alert.caf"];
    NSString *fullFilePath = [[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"];

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
    
    // Set the filepath to be the last saved audio clip so that when play is pressed the current saved message plays

    fullFilePath = [[NSBundle mainBundle] pathForResource:soundFileName ofType:@"caf"];
    NSLog(fullFilePath);
    URLtoHoldFile = [NSURL fileURLWithPath:fullFilePath];
    
    // Initialize the audio player
    NSError *audioError = nil; // will hold any error information that occurs during audio initialization
    aPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:URLtoHoldFile error:&audioError]; // sets up audio player
    
    if (audioError) {
        NSLog(@"An error occured setting the audio player: %@", [audioError localizedDescription]);
    }

    aPlayer.volume = volumeSlider.value;
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
        
        NSError *audioError = nil; // will hold any error information that occurs during audio initialization
        
        aPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:URLtoHoldFile error:&audioError]; // sets up audio player
        aPlayer.volume = volumeSlider.value;
        
        if (audioError) {
            NSLog(@"An error occured setting the audio player: %@", [audioError localizedDescription]);
        }
        else {
            [aPlayer prepareToPlay];
            [aPlayer play];
        }
    }
}

- (IBAction)defaultSound {
    NSString *fullFilePath = [[NSBundle mainBundle] pathForResource:@"default-audio-alert" ofType:@"caf"];
    URLtoHoldFile = [NSURL fileURLWithPath:fullFilePath];
}

// Saves the audio message
- (IBAction)saveSound {
    // Save the recorded sound
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSString *soundFileName;
    NSError *savingError;
    
    // Used for comparisons below
    NSLog(@"START DEBUG--------------------");
    NSURL *defaultURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"default-audio-alert" ofType:@"caf"]];
    NSLog(@"default OK--------------------");
    //NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *fullFilePath = [[documentPaths objectAtIndex:0] stringByAppendingPathComponent:@"recorded-audio-alert.caf"];
    //NSURL *recordedURL = [NSURL fileURLWithPath:fullFilePath];
    NSURL *recordedURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"]];
    //NSLog(@"recorded OK--------------------, %@ ERROR@: %@", fullFilePath, [[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"]);
    NSURL *savedURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"saved-audio-alert" ofType:@"caf"]];
    NSLog(@"saved OK--------------------");
    
    if ([[URLtoHoldFile absoluteURL] isEqual:[defaultURL absoluteURL]]) {
         NSLog(@"A file error D--------------------");
        //[filemanager removeItemAtPath:[[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"] error: NULL];
        soundFileName = @"default-audio-alert";
        NSLog(@"Not A file error D-------------------");
    }
    else if ([[URLtoHoldFile absoluteURL] isEqual:[recordedURL absoluteURL]]) {
        NSLog(@"A file error R--------------------");
        
        [filemanager  removeItemAtPath:[[NSBundle mainBundle] pathForResource:@"saved-audio-alert" ofType:@"caf"] error:&savingError];
        
        NSLog(@"A file error R2--------------------%@, ERROR2: %@", [[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"], [[NSBundle mainBundle] pathForResource:@"saved-audio-alert" ofType:@"caf"]);
        
        [filemanager moveItemAtPath:[[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"]
                         toPath:[[NSBundle mainBundle] pathForResource:@"saved-audio-alert" ofType:@"caf"] error:&savingError];
        
        soundFileName = @"saved-audio-alert";
        NSLog(@"Not A file error R----------------------");
    }
    else if ([[URLtoHoldFile absoluteURL] isEqual:[savedURL absoluteURL]]) {
        NSLog(@"A file error S---------------------");
        //[filemanager  removeItemAtPath:[[NSBundle mainBundle] pathForResource:@"recorded-audio-alert" ofType:@"caf"] error:&savingError];
        soundFileName = @"saved-audio-alert";
        NSLog(@"Not A file error S-------------------");
    }
    else {
        NSLog(@"There was an error in saving.---------------------");
    }
    
    // Store data in user default settings
    bool audioMessageOn = [audioMessageStatus isOn];
    CGFloat messageVolume = volumeSlider.value;
    NSLog(soundFileName);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:audioMessageOn forKey:@"audioMessageOn"];
    [defaults setFloat:messageVolume forKey:@"messageVolume"];
    [defaults setObject:soundFileName forKey:@"soundFileName"];
    
    [self dismissModalViewControllerAnimated:YES];
}

// Changes playback volume in Audio Settings
- (IBAction)changeVolume {
    aPlayer.volume = volumeSlider.value;
}


- (IBAction)cancelChanges {
    [self dismissModalViewControllerAnimated:YES];
}

@end
