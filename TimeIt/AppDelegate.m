//
//  SidebarTableViewController.m
//  ProyectoFinalDispositivosMoviles
//
//  Created by Rodolfo Andrés Ramírez Valenzuela on 14/03/15.
//  Copyright (c) 2015 Rodolfo Andrés Ramírez Valenzuela. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse enableLocalDatastore];
    sleep(2);
    //Initiliate parse database here
    [Parse setApplicationId:@"0s99qQtzidvWQDdrU1KJKjhUdUY6h9eq2Wk8e2ct" clientKey:@"yKLG337pUj50vwcirtXMf2VyGL5OWZxiUI3bqqMM"];
    
    //This will be for tracking the statistics around applications opens
    //[PFAnalyitics trackAppOpenedWithLaunchOptions:launchOptions]
    
    // Override point for customization after application launch.
    
    //Initialize the task and project in order to use it along the application

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
