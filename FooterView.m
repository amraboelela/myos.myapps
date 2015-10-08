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

#import "FooterView.h"
#import <UIKit/UIKit-private.h>

@implementation FooterView

#pragma mark - Life cycle

- (id)init
{
    self = [super init];
    if (self) {
<<<<<<< HEAD
        //DLog();
        self.backgroundColor = [UIColor whiteColor];
=======
        DLog();
        self.backgroundColor = [UIColor lightGrayColor];
>>>>>>> parent of 7a47134... Revert "@implementation FooterView"
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.origin.y = frame.size.height - _kScreenFooter;
        frame.size.height = _kScreenFooter;
        self.frame = frame;
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

#pragma mark - Actions

@end

#pragma mark - Public functions

/*
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
}*/
