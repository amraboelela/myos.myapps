/*
 Copyright © 2014-2015 myOS Group.
 
 This application is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later version.
 
 This library is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 Lesser General Public License for more details.
 
 Contributor(s):
 Amr Aboelela <amraboelela@gmail.com>
 */

#import "AppDelegate.h"
#import "FileManager.h"
//#import <UIKit/UIKit-private.h>

@implementation AppDelegate

@synthesize window=_window;

#pragma mark - Life cycle

- (void)dealloc
{
    //DLog();
    [_window release];
    [_launcherVC release];
    [super dealloc];
}

#pragma mark - Delegates

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    FileManagerSetupDirectories();
    //DLog();
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[[UIWindow alloc] initWithFrame:frame] autorelease];
    //_launcherVC = [[LauncherVC alloc] init];
    _loadingScreenVC = [[LoadingScreenVC alloc] init];
    
    [_window addSubview:_loadingScreenVC.view];
    [_window makeKeyAndVisible];
    
    //DLog(@"self: %@", self);
    [self performSelector:@selector(loadViews) withObject:nil afterDelay:0.01];
    //DLog();
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //DLog();
    [_launcherVC gotoHomepage];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    //DLog();
}

#pragma mark - Helpers

- (void)loadViews
{
    //DLog();
    _launcherVC = [[LauncherVC alloc] init];
    //DLog();
    [_window addSubview:_launcherVC.view];
    //DLog();
    [_loadingScreenVC.view removeFromSuperview];
    //DLog();
    [_loadingScreenVC release];
    //DLog();
    _loadingScreenVC = nil;
    //UIParentApplicationLauncherViewDidAdded();
    //DLog();
    //DLog(@"self: %@", self);
}

@end

