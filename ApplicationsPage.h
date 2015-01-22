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

#import <UIKit/UIKit-private.h>

@interface ApplicationsPage : NSObject {
@package
    int _pageNumber;
    NSArray *_applications;
    int _numberOfApplications;
    id _delegate;
}

- (id)initWithPageNumber:(int)pageNumber andApplications:(NSArray *)applications startIndex:(int)index;
- (void)rearrageApplicationsWithNextPage:(ApplicationsPage *)nextPage;

@end

@protocol ApplicationsPageDelegate <NSObject>

- (void)applicationWillMove:(UIMAApplication *)application;
- (void)applicationDidMove:(UIMAApplication *)application;

@end
