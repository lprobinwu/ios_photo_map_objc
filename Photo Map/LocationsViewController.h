//
//  LocationsViewController.h
//  Photo Map
//
//  Created by Timothy Lee on 3/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationsViewController;

@protocol LocationsViewControllerDelegate <NSObject>

- (void)locationsPickedLocation:(LocationsViewController *)locationsViewController
                       latitude:(NSNumber *)latitude
                      longitude:(NSNumber *)longitude;

@end

@interface LocationsViewController : UIViewController

@property (nonatomic, weak) id<LocationsViewControllerDelegate> delegate;

@end
