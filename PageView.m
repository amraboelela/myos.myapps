/*
 Copyright © 2014-2016 myOS Group.
 
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
#import <UIKit/UIChildApplicationProxy.h>

@implementation PageView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame scrollView:(UIScrollView *)scrollView applications:(NSMutableArray *)applications pageNumber:(int)pageNumber
{
    self = [super initWithFrame:theFrame];
    if (self) {
        int count = 0;
        int xLocation = 0;
        int yLocation = 0;
        //DLog(@"pageNumber: %d", pageNumber);
        for (UIChildApplicationProxy *application in applications) {
            if (count > PageViewNumberOfAppsPerPage()) {
                break;
            }
            //DLog(@"application: %@", application);
            xLocation = count % PageViewNumberOfColumnsPerPage();
            yLocation = count / PageViewNumberOfColumnsPerPage();
            
            //if (application != [NSNull null]) {
            //DLog(@"application: %@", application);
            //DLog(@"application.yLocation: %d", application.yLocation);
            UIApplicationIcon *icon;
            if (pageNumber == 0) {
                icon = application.homePageIcon;
                //icon.frame = CGRectMake(_kIconWidth * xLocation, _kIconHeight * (5-yLocation),
                //                        icon.frame.size.width, icon.frame.size.height);
            } else {
                icon = application->_applicationIcon;
            }
            icon.frame = CGRectMake(_kIconWidth * xLocation, _kIconHeight * yLocation,
                                    icon.frame.size.width, icon.frame.size.height); // icon.frame.size.height,
            
            //}
            //DLog(@"icon.frame: %@", NSStringFromCGRect(icon.frame));
            icon.parentScrollView = scrollView;
            [self addSubview:icon];
            //}
            count++;
        }
        //DLog(@"self: %@", self);
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Accessors

#pragma mark - Overridden methods

#pragma mark - Delegates

- (void)applicationWillMove:(UIChildApplicationProxy *)application
{
    
}

- (void)applicationDidMove:(UIChildApplicationProxy *)application
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

