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

#import "PageView.h"
#import <UIKit/UIKit-private.h>

@implementation PageView

@synthesize allApplications=_allApplications;
@synthesize sortDescriptors=_sortDescriptors;
@synthesize pageApplications=_pageApplications;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame scrollView:(UIScrollView *)scrollView applications:(NSMutableArray *)applications pageNumber:(int)pageNumber
{
    self = [super initWithFrame:theFrame];
    if (self) {
        int xLocation = 0;
        int yLocation = 0;
        for (UIChildApplication *application in applications) {
            //DLog(@"application: %p", application);
            if (application != [NSNull null]) {
                DLog(@"application: %@", application);
                //DLog(@"application.yLocation: %d", application.yLocation);
                UIApplicationIcon *icon;
                if (pageNumber == 0) {
                    icon = application.homeIcon;
                    icon.frame = CGRectMake(_kIconWidth * xLocation, _kIconHeight * (5-yLocation),
                                            icon.frame.size.width, icon.frame.size.height);
                } else {
                    icon = application->_applicationIcon;
                    icon.frame = CGRectMake(_kIconWidth * xLocation, _kIconHeight * yLocation,
                                            icon.frame.size.width, icon.frame.size.height); // icon.frame.size.height,
                    
                }
                DLog(@"icon.frame: %@", NSStringFromCGRect(icon.frame));
                icon.parentScrollView = scrollView;
                [self addSubview:icon];
            }
        }
        DLog(@"self: %@", self);
    }
    return self;
}

- (void)dealloc
{
    [_allApplications release];
    [_sortDescriptors release];
    [_pageApplications release];
    [super dealloc];
}

#pragma mark - Accessors

#pragma mark - Overridden methods

#pragma mark - Delegates

- (void)applicationWillMove:(UIChildApplication *)application
{
    
}

- (void)applicationDidMove:(UIChildApplication *)application
{
    
}

#pragma mark - Actions

@end

#pragma mark - Public functions

int PageViewNumberOfColumnsPerPage()
{
    return 4;
}

int PageViewNumberOfRowsPerPage()
{
    return 6;
}

int PageViewNumberOfAppsPerPage()
{
    return PageViewNumberOfColumnsPerPage() * PageViewNumberOfRowsPerPage();
}
