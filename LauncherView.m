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

#import <UIKit/UIKit-private.h>
#import "PageView.h"
#import "LauncherView.h"
//#import "ApplicationsData.h"

#define _kIconWidth                 80
#define _kIconHeight                92
#define _kUIPageControlHeight       20

@implementation LauncherView

@synthesize applications = _applications;

#pragma mark - Life cycle

- (id)initWithFrame:(CGRect)theFrame
{
    self = [super initWithFrame:theFrame];
    if (self) {
        _applications = FileManagerInstantiateApps();
        NSSortDescriptor *scoreDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
        NSArray *scoreDescriptors = [NSArray arrayWithObjects:scoreDescriptor, nil];
        
        //ApplicationsData *applicationsData = [ApplicationsData sharedData];
        int numberOfPages = [self numberOfPages];//applicationsData->_applicationsPages.count;
        PageView *pageView = nil;
        self.contentSize = CGSizeMake(theFrame.size.width * numberOfPages, theFrame.size.height);
        self.pagingEnabled = YES;
        //DLog(@"numberOfPages: %d", numberOfPages);
        for (int i=0; i<numberOfPages; i++) {
            pageView = [[PageView alloc]
                        initWithFrame:CGRectMake(self.frame.origin.x + i * self.frame.size.width, self.frame.origin.y,
                                                 self.frame.size.width, self.frame.size.height)
                        scrollView:self
                        applications:_applications
                        scoreDescriptors:scoreDescriptors
                        andStartingIndex:0];
            [self addSubview:pageView];
            [pageView release];
        };
        //pageView.center = CGPointMake(pageView.center.x, pageView.center.y);
        //DLog();
    }
    return self;
}

- (void)dealloc
{
    [_applications release];
    [super dealloc];
}

#pragma mark - Accessors

- (int)numberOfPages
{
    int numberOfAppsPerPage = 6 * 4;
    int result = self.applications.count / numberOfAppsPerPage + 1;
    if (self.applications.count % numberOfAppsPerPage > 0) {
        result++;
    }
    return result;
}

#pragma mark - Actions

@end
