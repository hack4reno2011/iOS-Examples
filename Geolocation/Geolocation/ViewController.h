//
//  ViewController.h
//  Geolocation
//
//  Created by John Jusayan on 10/13/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end
