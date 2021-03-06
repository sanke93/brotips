//
//  SBCAppDelegate.m
//  brotips
//
//  Created by Sanket Chauhan on 12/8/13.
//  Copyright (c) 2013 Sanket Chauhan. All rights reserved.
//

#import "SBCAppDelegate.h"

@implementation SBCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *menuBarImage = [UIImage imageNamed:@"8-red-menu-bar.png"];
    UIImage *backButtonImage = [UIImage imageNamed:@"8-red-back-button.png"];
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navbar_bg"];
    [[UINavigationBar appearance] setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setBackgroundImage:menuBarImage forBarMetrics:UIBarMetricsDefault];
    
     backButtonImage = [backButtonImage
                       resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 9.0f, 0.0f, 5.0f)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIFont boldSystemFontOfSize:10.0f], UITextAttributeFont,
      nil] forState:UIControlStateNormal];
  
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], UITextAttributeTextColor,
                                                          [UIFont boldSystemFontOfSize:23.0f], UITextAttributeFont, [UIColor blackColor], UITextAttributeTextShadowColor,  [NSValue valueWithCGSize:CGSizeMake(0.0,1.0)], UITextAttributeTextShadowOffset,
                                                          nil]];
    // Override point for customization after application launch.
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

@end
