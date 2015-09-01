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

//- (id)initWithFrame:(CGRect)theFrame andApplicationsPage:(ApplicationsPage *)applicationsPage andParentScrollView:(UIScrollView *)parentScrollView
- (id)initWithFrame:(CGRect)theFrame scrollView:(UIScrollView *)scrollView applications:(NSMutableArray *)applications scoreDescriptors:(NSArray *)scoreDescriptors andStartingIndex:(int)startingIndex
{
    self = [super initWithFrame:theFrame];
    if (self) {
        //_applicationsPage = applicationsPage;
        //_applicationsPage->_delegate = self;
        //for (NSArray *row in _applicationsPage->_applications) {
        //self.backgroundColor = [UIColor grayColor];
        int xLocation = 0;
        int yLocation = 0;
        for (UIChildApplication *application in applications) {
            //DLog(@"application: %p", application);
            if (application != [NSNull null]) {
                //DLog(@"application: %@", application);
                UIApplicationIcon *icon = application->_applicationIcon;
                //DLog(@"application.yLocation: %d", application.yLocation);
                icon.frame = CGRectMake(_kIconWidth * xLocation, _kIconHeight * yLocation,
                                        icon.frame.size.width, icon.frame.size.height); // icon.frame.size.height,
                //DLog(@"icon.frame: %@", NSStringFromCGRect(icon.frame));
                DLog(@"icon: %@", icon);
                icon.parentScrollView = scrollView;
                [self addSubview:icon];
            }
        }
        //}
        //DLog(@"self: %@", self);
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

/*
#pragma mark - Shared functions

void PageViewLoadIcons(PageView *pageView)
{
    
}*/
