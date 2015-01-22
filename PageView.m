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

#import "PageView.h"
#import <UIKit/UIKit-private.h>

@implementation PageView

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame andApplicationsPage:(ApplicationsPage *)applicationsPage andParentScrollView:(UIScrollView *)parentScrollView
{ 
    self = [super initWithFrame:theFrame];
    if (self) {
        _applicationsPage = applicationsPage;
        _applicationsPage->_delegate = self;
        for (NSArray *row in _applicationsPage->_applications) {
            for (UIMAApplication *application in row) {
                //DLog(@"application: %p", application);
                if (application != [NSNull null]) {
                    //DLog(@"application: %@", application);
                    UIApplicationIcon *icon = application->_applicationIcon;
                    icon.frame = CGRectMake(_kIconWidth * application.xLocation,
                                            self.frame.size.height - _kIconHeight * application.yLocation - icon.frame.size.height,
                                            icon.frame.size.width, icon.frame.size.height);
                    icon.parentScrollView = parentScrollView;
                    [self addSubview:icon];
                }
            }
        }
        //DLog(@"self: %@", self);
    }
    return self;
}

- (void)dealloc
{
    //[_icons release];
    [super dealloc];
}

#pragma mark - Accessors

#pragma mark - Overridden methods

#pragma mark - Delegates

- (void)applicationWillMove:(UIMAApplication *)application
{
    
}

- (void)applicationDidMove:(UIMAApplication *)application
{
    
}

#pragma mark - Actions

@end

#pragma mark - Shared functions

void PageViewLoadIcons(PageView *pageView)
{
    
}
