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
#import <QuartzCore/QuartzCore.h>

#define ButtonWidth         90
#define ButtonHeight        25
#define ButtonsInterSpace   20

@implementation FooterView

#pragma mark - Life cycle

- (id)init
{
    self = [super init];
    if (self) {
        //DLog();
        self.backgroundColor = [UIColor whiteColor];
        CGRect frame = [[UIScreen mainScreen] bounds];
        frame.origin.y = frame.size.height - _kScreenFooter;
        frame.size.height = _kScreenFooter;
        self.frame = frame;
        //float homeButtonWidth = 100;
        UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        homeButton.frame = CGRectMake((self.frame.size.width - ButtonWidth * 2 - ButtonsInterSpace) / 2.0 + ButtonWidth + ButtonsInterSpace, (self.frame.size.height - ButtonHeight) / 2.0, ButtonWidth, ButtonHeight);
        //homeButton.backgroundColor = [UIColor greenColor];
        //homeButton.layer.borderColor = [[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:200.0/255.0 alpha:1.0] CGColor];
        //homeButton.layer.borderWidth = 1;
        //homeButton.layer.cornerRadius = 7;
        //homeButton.layer.masksToBounds = YES;
        //homeButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [homeButton setTitle:@"Home" forState:UIControlStateNormal];
        
        //[homeButton addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchDown];
        [homeButton addTarget:self action:@selector(homeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:homeButton];
        
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        backButton.frame = CGRectMake((self.frame.size.width - ButtonWidth * 2 - ButtonsInterSpace) / 2.0, (self.frame.size.height - ButtonHeight) / 2.0, ButtonWidth, ButtonHeight);
        //backButton.backgroundColor = [UIColor clearColor];
        //backButton.layer.cornerRadius = 7;
        //backButton.layer.masksToBounds = YES;
        [backButton setTitle:@"Back" forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
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

- (void)homeButtonClicked:(id)sender
{
    //DLog(@"sender: %@", sender);
    UIParentApplicationShowLauncher();
    //UIParentApplicationTerminateApps();
}

- (void)backButtonClicked:(id)sender
{
    //DLog(@"sender: %@", sender);
    UIParentApplicationGoBack();
}

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

