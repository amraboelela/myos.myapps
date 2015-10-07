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

#import "LauncherVC.h"
#import "LauncherView.h"
//#import "ApplicationsData.h"

#define _kUIPageControlHeight       20

@implementation LauncherVC

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];// colorWithRed:0.0 green:100.0/255.0 blue:0.0 alpha:1.0];

    CGRect frame = self.view.frame;
    self.view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Wallpaper.png"]] autorelease];
    self.view.frame = frame;
    
    NSMutableArray *applications = FileManagerInstantiateApps();
    _launcherView = [[LauncherView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - _kUIPageControlHeight)];
    _launcherView.delegate = self;
    _launcherView.applications = applications;
    
    //DLog(@"numberOfPages: %d", [_launcherView numberOfPages]);
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - _kUIPageControlHeight,
                                                                      frame.size.width, _kUIPageControlHeight)];
    _pageControl.numberOfPages = [_launcherView numberOfPages];
    _pageControl.currentPage = 0;
    [self.view addSubview:_pageControl];
    
    [_pageControl addTarget:self
                    action:@selector(pageControlValueChanged:)
          forControlEvents:UIControlEventValueChanged];
    
    [applications release];
    [self.view addSubview:_launcherView];
    //[pageControl release];
    //[launcherView release];
    return;
}

- (void)dealloc
{
    //[_backgroundView release];
    [_pageControl release];
    //[_scrollView release];
    [_launcherView release];
    [super dealloc];
}

#pragma mark - Other delegates

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = round(scrollView.contentOffset.x / scrollView.bounds.size.width);
    //DLog(@"_pageControl.currentPage2: %d", _pageControl.currentPage);
}

- (void)gotoHomepage
{
    _pageControl.currentPage = 0;
    _launcherView.contentOffset = CGPointMake(0, _launcherView.contentOffset.y);
}

#pragma mark - Actions

- (void)pageControlValueChanged:(id)sender
{
    //DLog(@"sender: %@", sender);
    [_launcherView setContentOffset:CGPointMake(_pageControl.currentPage * _launcherView.bounds.size.width, _launcherView.contentOffset.y)
                           animated:YES];
}

@end

