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

/*
static NSString *_myosPath = nil;

#pragma mark - Static functions

static NSString *_FileManagerMyOSPath()
{
    if (!_myosPath) {
        _myosPath = IOPipeRunCommand(@"echo ${MYOS_PATH}", YES);
        _myosPath = [_myosPath substringToIndex:_myosPath.length-1];
    }
    return _myosPath;
}*/

#pragma mark - Public functions

void FileManagerSetupDirectories()
{
    //DLog(@"");
    NSFileManager *fileManager = [NSFileManager defaultManager];
//#ifdef ANDROID
//    NSString *filePath = @"/data/data/com.myos.myapps/apps";
//#else
    //NSString *filePath = @"/home/amr/myos/myapps/apps";
    NSString *filePath = [NSString stringWithFormat:@"%@/apps", _NSFileManagerMyAppsPath()];
    //NSString *filePath = IOPipeRunCommand([NSString stringWithFormat:@"echo %@", preFilePath], YES);
//#endif
    
    //DLog(@"filePath: %@", filePath);
    if ([fileManager fileExistsAtPath:filePath]) {
        //DLog(@"fileExistsAtPath:filePath");
    } else {
        //DLog(@"IOPipeRunCommand");
        IOPipeRunCommand([NSString stringWithFormat:@"mkdir -p %@", filePath], NO);
    }
}

NSMutableArray *FileManagerInstantiateApps()
{
    //DLog(@"");
    NSMutableArray *apps = [[NSMutableArray alloc] initWithCapacity:100];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/apps", _NSFileManagerMyAppsPath()];
    NSArray *directories = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:NULL];
    //DLog(@"directories: %@", directories);
    UIChildApplicationProxy *childApp;
    int numberOfApps = directories.count;
    for (NSString *directory in directories) {
        NSString *bundleName  = [directory stringByReplacingOccurrencesOfString:@".app" withString:@""];
        //DLog(@"bundleName: %@", bundleName);
        childApp = [[UIChildApplicationProxy alloc] initWithBundleName:bundleName];
        long childAppPointer = (long)childApp;
        childApp.score = (rand()/2 + childAppPointer) % numberOfApps;
        [apps addObject:childApp];
        [childApp release];
    }
    //DLog();
    return apps;
}
