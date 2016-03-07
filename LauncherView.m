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
        scoreDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"category" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES], nil];
        int numberOfPages = [self numberOfPages];
        PageView *pageView = nil;
        self.contentSize = CGSizeMake(theFrame.size.width * numberOfPages, theFrame.size.height);
        self.pagingEnabled = YES;
        NSArray *homeApplications = [[[_applications sortedArrayUsingDescriptors:scoreDescriptors] subarrayWithRange:
                                     NSMakeRange(0,PageViewNumberOfAppsPerPage())] sortedArrayUsingDescriptors:scoreDescriptors];
        pageView = [[PageView alloc]
                    initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                             self.frame.size.width, self.frame.size.height)
                    scrollView:self
                    applications:homeApplications
                    pageNumber:0];
        [self addSubview:pageView];
        [pageView release];
        //};
        

        self.applications = [_applications sortedArrayUsingDescriptors:scoreDescriptors];
        for (int i=1; i<numberOfPages; i++) {
            pageView = [[PageView alloc]
                        initWithFrame:CGRectMake(self.frame.origin.x + i * self.frame.size.width, self.frame.origin.y,
                                                 self.frame.size.width, self.frame.size.height)
                        scrollView:self
                        applications:_applications
                        pageNumber:i];
            [self addSubview:pageView];
            [pageView release];
        };
        //pageView.center = CGPointMake(pageView.center.x, pageView.center.y);
        //DLog();
        //self.backgroundColor = [UIColor yellowColor];
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
    int numberOfAppsPerPage = PageViewNumberOfAppsPerPage();
    int result = self.applications.count / numberOfAppsPerPage + 1;
    if (self.applications.count % numberOfAppsPerPage > 0) {
        result++;
    }
    return result;
}

#pragma mark - Actions

@end
