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
#import "ApplicationsData.h"
#import "ApplicationsPage.h"
#import "FileManager.h"

#define kMaximumNumberOfPages   10
#define kNumberOfAppsPerRow     4
#define kNumberOfRows           6
#define kNumberOfAppsPerPage    (kNumberOfAppsPerRow * kNumberOfRows)
#define kMaximumNumberOfApps    (kNumberOfAppsPerPage * kMaximumNumberOfPages)

static ApplicationsData *_applicationsData = nil;
static NSString *const _kMAPageNumber = @"pageNumber";

#pragma mark - Static functions

/*
static int ApplicationsDataAppFlatLocation(UIChildApplication *application)
{
    return application.pageNumber * kNumberOfAppsPerPage + application.yLocation * kNumberOfAppsPerRow +  application.xLocation;
}*/

static void ApplicationsDataSetLocations(ApplicationsData *applicationsData)
{
    //DLog(@"applicationsData->_applications: %@", applicationsData->_applications);
    //NSSortDescriptor *categoryDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"category" ascending:NO];
    NSSortDescriptor *scoreDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    applicationsData.applications = [applicationsData->_applications sortedArrayUsingDescriptors:[NSArray arrayWithObjects:scoreDescriptor, nil]];
    //DLog(@"Score sorted applications: %@", applicationsData->_applications);
    //int allocSize = sizeof(BOOL)*kNumberOfAppsPerPage;
    //BOOL *filledLocations = malloc(allocSize);
    //memset(filledLocations,NO,allocSize);
    int currentLocation = 0;
    //int flatLocation;
    UIChildApplication *application;
    int count = applicationsData->_applications.count;
    if (count > kNumberOfAppsPerPage) {
        count = kNumberOfAppsPerPage;
    }
    for (int i=0; i<count; i++) {
        application = [applicationsData->_applications objectAtIndex:i];
        //DLog(@"application: %@", application);
        //if (application.anchored) {
        //flatLocation = ApplicationsDataAppFlatLocation(application);
            //DLog(@"flatLocation: %d", flatLocation);
            //filledLocations[flatLocation] = YES;
        //} else if (application.score > -1) {
        /*while (filledLocations[currentLocation]) {
            currentLocation++;
        }*/
            //DLog(@"currentLocation: %d", currentLocation);
        filledLocations[currentLocation] = YES;
            //application.pageNumber = currentLocation / kNumberOfAppsPerPage;
        application.yLocation = kNumberOfRows - 1 - (currentLocation / kNumberOfAppsPerRow);
        application.xLocation = currentLocation % kNumberOfAppsPerRow;
        //DLog(@"application.yLocation: %d", application.yLocation);
        //DLog(@"set application: %@", application);
        currentLocation++;
        UIChildApplicationSaveData(application);
        //} else {
        //    minusOneIndex = i;
        //}
    }
    //free(filledLocations);
    //return;// minusOneIndex;
}

static void ApplicationsDataAutoArrange(ApplicationsData *applicationsData)
{
    //DLog(@"applicationsData->_applications: %@", applicationsData->_applications);
    ApplicationsDataSetLocations(applicationsData);
    /*DLog(@"minusOneIndex: %d", minusOneIndex);
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
                application.score = newAppScore;
            } else {
                break;
            }
            //currentLocation++;
        }
        minusOneIndex = ApplicationsDataSetLocations(applicationsData);
        DLog(@"applicationsData->_applications 2: %@", applicationsData->_applications);
    }*/
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
        ApplicationsDataAutoArrange(self);
        //NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"pageNumber" ascending:YES];
        //DLog(@"_applications: %@", _applications);
        //self.applications = [_applications sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]];
        //DLog(@"_applications: %@", _applications);
        UIChildApplication *lastApplication = [_applications lastObject];
        int numberOfPages = _applications.count / kNumberOfAppsPerPage + 2;// lastPageNumber + 1;
        //DLog(@"numberOfPages: %d", numberOfPages);
        
        _applicationsPages = [[NSMutableArray alloc] initWithCapacity:10];
        int startIndex = 0;
        ApplicationsPage *applicationsPage = [[ApplicationsPage alloc] initWithPageNumber:0
                                                                          andApplications:_applications
                                                                               startIndex:startIndex];
        [_applicationsPages addObject:applicationsPage];
        [applicationsPage release];
        for (int i=1; i<numberOfPages; i++) {
            applicationsPage = [[ApplicationsPage alloc] initWithPageNumber:i
                                                            andApplications:_applications
                                                                 startIndex:startIndex];
            startIndex += applicationsPage->_numberOfApplications;
            [_applicationsPages addObject:applicationsPage];
            [applicationsPage release];
        }
        //DLog(@"_applicationsPages: %@", _applicationsPages);
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
