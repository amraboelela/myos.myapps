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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit-private.h>
#import <IOKit/IOKit.h>
#import "FileManager.h"

#pragma mark - Public C functions

void FileManagerSetupDirectories()
{
    //DLog(@"");
    NSFileManager *fileManager = [NSFileManager defaultManager];
#ifdef ANDROID
    NSString *filePath = @"/data/data/com.myos.myapps/apps";
#else
    //NSString *filePath = @"/home/amr/myos/myapps/apps";
    NSString *filePath = @"${MYOS_PATH}/myapps/apps";
    //NSString *filePath = IOPipeRunCommand([NSString stringWithFormat:@"echo %@", preFilePath], YES);
#endif
    
    //DLog(@"filePath: %@", filePath);
    if ([fileManager fileExistsAtPath:filePath]) {
        DLog(@"fileExistsAtPath:filePath");
    } else {
        //DLog(@"IOPipeRunCommand");
        IOPipeRunCommand([NSString stringWithFormat:@"mkdir -p %@", filePath], NO);
    }
}

NSMutableArray *FileManagerInstantiateApps()
{
    //DLog(@"");
    NSMutableArray *apps = [[NSMutableArray alloc] initWithCapacity:100];
    
#ifdef ANDROID
    NSString *filePath = @"/data/data/com.myos.myapps/apps";
#else
    NSString *preFilePath = @"${MYOS_PATH}/myapps/apps";
    NSString *filePath = IOPipeRunCommand([NSString stringWithFormat:@"echo %@", preFilePath], YES);
#endif
    
    DLog(@"filePath: %@", filePath);
    
    NSArray *directories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
    DLog(@"directories: %@", directories);
    UIChildApplication *maApp;
    for (NSString *directory in directories) {
        NSString *appName  = [directory stringByReplacingOccurrencesOfString:@".app" withString:@""];
        DLog(@"appName: %@", appName);
        maApp = [[UIChildApplication alloc] initWithAppName:appName];
        DLog();
        [apps addObject:maApp];
        DLog();
        [maApp release];
        DLog();
    }
    DLog();
    return apps;
}

