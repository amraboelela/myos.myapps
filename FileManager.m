/*
 Copyright © 2014 myOS Group.
 
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit-private.h>
#import <IOKit/IOKit.h>
#import "FileManager.h"

#pragma mark - Public C functions

void FileManagerSetupDirectories()
{
    //DLog(@"");
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *filePath = @"/data/data/com.myos.myapps/apps";
	//DLog(@"filePath: %@", filePath);
	if ([fileManager fileExistsAtPath:filePath]) {
    } else {
        IOPipeRunCommand([NSString stringWithFormat:@"mkdir %@", filePath], NO);
    }
}

NSMutableArray *FileManagerInstantiateApps()
{
    NSMutableArray *apps = [[NSMutableArray alloc] initWithCapacity:100];
    NSString *filePath = @"/data/data/com.myos.myapps/apps";
    
    NSArray *directories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
    UIChildApplication *maApp;
    for (NSString *directory in directories) {
        NSString *appName  = [directory stringByReplacingOccurrencesOfString:@".app" withString:@""];
        //DLog(@"appName: %@", appName);
        maApp = [[UIChildApplication alloc] initWithAppName:appName];
        [apps addObject:maApp];
        [maApp release];
    }
    return apps;
}
