//
//  ViewController.m
//  Geolocation
//
//  Created by John Jusayan on 10/13/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize addressLabel = _addressLabel;
@synthesize latitudeLabel = _latitudeLabel;
@synthesize longitudeLabel = _longitudeLabel;
@synthesize distanceLabel = _distanceLabel;
@synthesize locationManager = _locationManager;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setAddressLabel:nil];
    [self setLatitudeLabel:nil];
    [self setLongitudeLabel:nil];
    [self setDistanceLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    
    CLLocation *currentLocation = [self.locationManager location];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [self.latitudeLabel setText:[NSString stringWithFormat:@"%f",  currentLocation.coordinate.latitude]];
    [self.longitudeLabel setText:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude]];
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            // Pick the best out of the possible placemarks
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *addressString = [placemark name];
            [self.addressLabel setText:addressString];
        }

    }];
    
    CLLocation *pionerLocation = [[CLLocation alloc] initWithLatitude:39.524411 longitude:-119.811419];
    CLLocationDistance distance = [currentLocation distanceFromLocation:pionerLocation];
    [self.distanceLabel setText:[NSString stringWithFormat:@"%f m", distance]];
    
    
}

@end
