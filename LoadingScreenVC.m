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

#import "LoadingScreenVC.h"

@implementation LoadingScreenVC

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:255.0/255.0 alpha:1.0];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float textY = (screenBounds.size.height - _activityIndicator.frame.size.height) / 2;
    _activityIndicator.frame = CGRectMake((screenBounds.size.width - _activityIndicator.frame.size.width) / 2,
                                          (screenBounds.size.height - _activityIndicator.frame.size.height) / 2,
                                          _activityIndicator.frame.size.width, _activityIndicator.frame.size.height);
    //DLog();
    [self.view addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    //DLog();
}

- (void)dealloc
{
    //DLog(@"self: %@", self);
    //[_loadingLabel release];
    [_activityIndicator stopAnimating];
    [_activityIndicator release];
    [super dealloc];
}

#pragma mark - Delegates

#pragma mark - Actions

#pragma mark - Helpers

- (void)stopAnimating
{
    [_activityIndicator stopAnimating];
}

@end
