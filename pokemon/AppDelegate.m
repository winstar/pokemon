//
//  AppDelegate.m
//  pokemon
//
//  Created by 白彝澄源 on 13-6-20.
//  Copyright (c) 2013年 白彝澄源. All rights reserved.
//

#import "AppDelegate.h"
#import "NVSlideMenuController.h"
#import "MenuViewController.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[SqliteHelper sharedHelper] createEditableCopyOfDatabaseIfNeeded];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

	MenuViewController *menuVC = [storyBoard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    menuVC.currentMenu = 0;
    
	ViewController *pmListVC = [storyBoard instantiateViewControllerWithIdentifier:@"PMListViewController"];
    
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:pmListVC];
	NVSlideMenuController *slideMenuVC = [[NVSlideMenuController alloc] initWithMenuViewController:menuVC andContentViewController:navController];
	slideMenuVC.contentViewWidthWhenMenuIsOpen = 100;
    
	self.window.rootViewController = slideMenuVC;
    [self.window makeKeyAndVisible];
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
