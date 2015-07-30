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

#import <UIKit/UIKit-private.h>
#import "ApplicationsData.h"
#import "ApplicationsPage.h"
#import "FileManager.h"

#define kMaximumNumberOfPages   10
#define kNumberOfAppsPerRow     4
#define kNumberOfAppsPerPage    (kNumberOfAppsPerRow * 6)
#define kMaximumNumberOfApps    (kNumberOfAppsPerPage * kMaximumNumberOfPages)

static ApplicationsData *_applicationsData = nil;
static NSString *const _kMAPageNumber = @"pageNumber";

#pragma mark - Static functions

static int ApplicationsDataAppFlatLocation(UIChildApplication *application)
{
    return application.pageNumber * kNumberOfAppsPerPage + application.yLocation * kNumberOfAppsPerRow +  application.xLocation;;
}

static UIChildApplication *ApplicationsDataGetCloseDownAppToFlatLocation(ApplicationsData *applicationsData, int flatLocation)
{
    NSSortDescriptor *pageNumberDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"pageNumber" ascending:NO];
    NSSortDescriptor *yLocationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"yLocation" ascending:NO];
    NSSortDescriptor *xLocationDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"xLocation" ascending:NO];
    NSMutableArray *applications = [applicationsData->_applications sortedArrayUsingDescriptors:[NSArray arrayWithObjects:pageNumberDescriptor, yLocationDescriptor, xLocationDescriptor, nil]];
    //DLog(@"pageNumber, yLocation, xLocation sorted applications: %@", applications);
    for (UIChildApplication *application in applications) {
        if (ApplicationsDataAppFlatLocation(application) <= flatLocation) {
            return application;
        }
    }
    return nil;
}

static int ApplicationsDataSetLocations(ApplicationsData *applicationsData)
{
    //DLog(@"applicationsData->_applications: %@", applicationsData->_applications);
    NSSortDescriptor *anchoredDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"anchored" ascending:NO];
    NSSortDescriptor *scoreDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    applicationsData.applications = [applicationsData->_applications sortedArrayUsingDescriptors:[NSArray arrayWithObjects:anchoredDescriptor, scoreDescriptor, nil]];
    //DLog(@"anchored score sorted applications: %@", applicationsData->_applications);
    int allocSize = sizeof(BOOL)*kMaximumNumberOfApps;
    BOOL *filledLocations = malloc(allocSize);
    memset(filledLocations,NO,allocSize);
    int currentLocation = 0;
    int minusOneIndex = -1;
    //int i;
    int flatLocation;
    UIChildApplication *application;
    for (int i=0; i<applicationsData->_applications.count; i++) {
        application = [applicationsData->_applications objectAtIndex:i];
        //DLog(@"application: %@", application);
        if (application.anchored) {
            flatLocation = ApplicationsDataAppFlatLocation(application);
            //DLog(@"flatLocation: %d", flatLocation);
            filledLocations[flatLocation] = YES;
        } else if (application.score > -1) {
            while (filledLocations[currentLocation]) {
                currentLocation++;
            }
            //DLog(@"currentLocation: %d", currentLocation);
            filledLocations[currentLocation] = YES;
            application.pageNumber = currentLocation / kNumberOfAppsPerPage;
            application.yLocation = (currentLocation % kNumberOfAppsPerPage) / kNumberOfAppsPerRow;
            application.xLocation = (currentLocation % kNumberOfAppsPerPage) % kNumberOfAppsPerRow;
            //DLog(@"set application: %@", application);
            currentLocation++;
            UIChildApplicationSaveData(application);
        } else {
            minusOneIndex = i;
        }
    }
    free(filledLocations);
    return minusOneIndex;
}

static void ApplicationsDataAutoArrange(ApplicationsData *applicationsData)
{
    DLog(@"applicationsData->_applications: %@", applicationsData->_applications);
    int minusOneIndex = ApplicationsDataSetLocations(applicationsData);
    DLog(@"minusOneIndex: %d", minusOneIndex);
    while (minusOneIndex>-1) {
        DLog(@"for (i=minusOneIndex ...");
        int flatLocation = kNumberOfAppsPerPage-1;
        DLog(@"flatLocation: %d", flatLocation);
        UIChildApplication *application = ApplicationsDataGetCloseDownAppToFlatLocation(applicationsData, flatLocation);
        DLog(@"ApplicationsDataGetCloseDownAppToFlatLocation application: %@", application);
        int appFlatLocation = ApplicationsDataAppFlatLocation(application);
        DLog(@"appFlatLocation: %d", appFlatLocation);
        int newAppScore;
        if (appFlatLocation < flatLocation) {
            newAppScore = application.score - 1;
        } else {
            newAppScore = application.score + 1;
        }
        for (int i=minusOneIndex; i<applicationsData->_applications.count; i++) {
            application = [applicationsData->_applications objectAtIndex:i];
            if (application.score == -1) {
                DLog(@"application: %@", application);
                application.score = newAppScore;
            } else {
                break;
            }
            //currentLocation++;
        }
        minusOneIndex = ApplicationsDataSetLocations(applicationsData);
        DLog(@"applicationsData->_applications 2: %@", applicationsData->_applications);
    }
}

@implementation ApplicationsData

@synthesize applications=_applications;
@synthesize applicationsPages=_applicationsPages;

#pragma mark - Life cycle

+ (void)initialize
{
    _applicationsData = [[ApplicationsData alloc] init];
}

- (id)init
{
    if ((self=[super init])) {
        _applications = FileManagerInstantiateApps();
        DLog();
        ApplicationsDataAutoArrange(self);
        DLog();
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pageNumber" ascending:YES];
        DLog(@"_applications: %@", _applications);
        self.applications = [_applications sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        DLog(@"_applications: %@", _applications);
        UIChildApplication *lastApplication = [_applications lastObject];
        int lastPageNumber = lastApplication.pageNumber;
        int numberOfPages = lastPageNumber + 1;
        DLog(@"numberOfPages: %d", numberOfPages);
        
        _applicationsPages = [[NSMutableArray alloc] initWithCapacity:10];
        int startIndex = 0;
        for (int i=0; i<numberOfPages; i++) {
            DLog(@"i: %d", i);
            ApplicationsPage *applicationsPage = [[ApplicationsPage alloc] initWithPageNumber:i
                                                                              andApplications:_applications
                                                                                   startIndex:startIndex];
            startIndex += applicationsPage->_numberOfApplications;
            DLog();
            [_applicationsPages addObject:applicationsPage];
            [applicationsPage release];
        }
        DLog(@"_applicationsPages: %@", _applicationsPages);
    }
    return self;
}

#pragma mark - Class methods

+ (ApplicationsData *)sharedData
{
    return _applicationsData;
}

#pragma mark - Delegates

#pragma mark - Misc

- (void)rearrageApplications
{
    for (int i=0; i<_applicationsPages.count-1; i++) {
        ApplicationsPage *applicationsPage = [_applicationsPages objectAtIndex:i];
        ApplicationsPage *nextApplicationsPage = [_applicationsPages objectAtIndex:i+1];
        [applicationsPage rearrageApplicationsWithNextPage:nextApplicationsPage];
    }
}

@end
