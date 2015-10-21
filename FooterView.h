/*
 Copyright © 2015 myOS Group.
 
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

#import <UIKit/UIKit.h>

@interface FooterView : UIView {
@package
    //NSMutableArray *_allApplications;
    //NSArray *_sortDescriptors;
    //int _startingIndex;
    //NSMutableArray *_pageApplications;
    id _delegate;
}

@property (nonatomic, assign) id delegate;

//- (id)initWithFrame:(CGRect)theFrame scrollView:(UIScrollView *)scrollView applications:(NSMutableArray *)applications pageNumber:(int)pageNumber;

@end

//void PageViewLoadIcons(PageView *pageView);

//int PageViewNumberOfColumnsPerPage();
//int PageViewNumberOfRowsPerPage();
//int PageViewNumberOfAppsPerPage();
