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

#define ButtonWidth         100
#define ButtonHeight        20
#define ButtonsInterSpace   30

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
        self.homeButton.frame = CGRectMake((self.frame.size.width - ButtonWidth * 2 - ButtonsInterSpace) / 2.0 + ButtonWidth + ButtonsInterSpace, (self.frame.size.height - ButtonHeight) / 2.0, ButtonWidth, ButtonHeight);
        self.homeButton.backgroundColor = [UIColor greenColor];
        //self.homeButton.layer.borderColor = [[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:200.0/255.0 alpha:1.0] CGColor];
        //self.homeButton.layer.borderWidth = 1;
        self.homeButton.layer.cornerRadius = 7;
        self.homeButton.layer.masksToBounds = YES;
        //self.homeButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.homeButton setTitle:@"Home" forState:UIControlStateNormal];
        
        //[button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchDown];
        //[button addTarget:self action:@selector(unClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:homeButton];
        
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.backButton.frame = CGRectMake((self.frame.size.width - ButtonWidth * 2 - ButtonsInterSpace) / 2.0, (self.frame.size.height - ButtonHeight) / 2.0, ButtonWidth, ButtonHeight);
        self.backButton.backgroundColor = [UIColor greenColor];
        self.backButton.layer.cornerRadius = 7;
        //self.backButton.layer.masksToBounds = YES;
        //self.homeButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
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
