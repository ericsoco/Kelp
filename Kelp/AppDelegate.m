//
//  AppDelegate.m
//  Kelp
//
//  Created by Eric Socolofsky on 3/20/14.
//  Copyright (c) 2014 Eric Socolofsky. All rights reserved.
//

#import "AppDelegate.h"
#import "BusinessListViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    // Override point for customization after application launch.
	BusinessListViewController *businessListViewController = [[BusinessListViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:businessListViewController];
	self.window.rootViewController = navController;
	
	[navController.navigationBar setBarTintColor:[UIColor colorWithRed:0.812 green:0.094 blue:0.024 alpha:1.0]];
	[navController.navigationBar setTranslucent:YES];
	[navController.navigationBar setBarStyle:UIBarStyleBlack];
	
	// Use UIAppearance proxy to style all UIBarButtonItems in application.
	NSDictionary *barButtonAppearanceDict = @{ NSFontAttributeName : [UIFont fontWithName:@"Avenir-Medium" size:20.0] };
	[[UIBarButtonItem appearance] setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];
	[[UIBarButtonItem appearance] setTitlePositionAdjustment:UIOffsetMake(-1.0, -1.5) forBarMetrics:UIBarMetricsDefault];
	//	[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:<#(UIOffset)#> forBarMetrics:<#(UIBarMetrics)#>
	
	[businessListViewController setNeedsStatusBarAppearanceUpdate];
	
	/*
	// Dump font families/names
	for (NSString* family in [UIFont familyNames]) {
		NSLog(@"%@", family);
		for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
			NSLog(@"  %@", name);
		}
	}
	*/
	
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
