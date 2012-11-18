//
//  AppDelegate.m
//  CatchMe
//
//  Created by Jonathon Simister on 10/17/12.
//  Copyright (c) 2012 Same Level Software. All rights reserved.
//

#import "AppDelegate.h"

#import "SettingsViewController.h"
#import "ContactsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Detecting if the accelerometer is available on the device

    // This piece of code is always unavailable and not active.
    // But when I put it in SettingsViewController it does detect the accelerometer.
    /*
    if ([motionManager isAccelerometerAvailable]){
        NSLog(@"Accelerometer is available.");
    }   else{
        NSLog(@"Accelerometer is unavailable.");
    }
    
    if ([motionManager isAccelerometerActive]){
        NSLog(@"Accelerometer is active.");
    }   else{
        NSLog(@"Accelerometer is not active.");
    }
    */
    
    
     /* Commenting out to use the Storyboard interface builder
      
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  
    //UIViewController *viewController1 = [[UIPageViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
    UIViewController *viewControllerSettings = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    UIViewController *viewControllerContacts = [[ContactsViewController alloc] initWithNibName:@"ContactsViewController" bundle:nil];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewControllerSettings, viewControllerContacts];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible]; 
      
      */
    
    /*
    motionManager.accelerometerUpdateInterval = (double)0.5; //20Hz
    motionQueue = [[NSOperationQueue alloc] init];
    
    [motionManager startAccelerometerUpdatesToQueue: motionQueue withHandler: ^( CMAccelerometerData* data, NSError* error) {
        NSLog(@"Accelerometer: %@", [data description]);
    }];
     */
    
   
    //Jonathons implementation of the background notification
    NSDate* date = [[NSDate alloc] initWithTimeIntervalSinceNow:5];
    
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = date;
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = @"Notification message";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [locationManager startMonitoringSignificantLocationChanges];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification: %@", notification.alertBody);
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
