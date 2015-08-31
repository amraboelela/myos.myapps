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

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//#import "ApplicationsPage.h"

@interface PageView : UIView {
@package
    //ApplicationsPage *_applicationsPage;
    NSMutableArray *_allApplications;
    NSArray *_sortDescriptors;
    int _startingIndex;
    NSMutableArray *_pageApplications;
}

@property (nonatomic, retain) NSMutableArray *allApplications;
@property (nonatomic, retain) NSArray *sortDescriptors;
@property (nonatomic, retain) NSMutableArray *pageApplications;

- (id)initWithFrame:(CGRect)theFrame scrollView:(UIScrollView *)scrollView applications:(NSMutableArray *)applications scoreDescriptors:(NSArray *)scoreDescriptors andStartingIndex:(int)startingIndex;

//andApplicationsPage:(ApplicationsPage *)applicationsPage andParentScrollView:(UIScrollView *)parentScrollView;

@end

void PageViewLoadIcons(PageView *pageView);
