//
//  Place.h
//  Closeby
//
//  Created by John Jusayan on 10/8/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface Place : NSObject

@property (nonatomic, strong) UIView *associatedView;
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *note;

- (id)initWithName:(NSString*)aName andLocation:(CLLocation*)aLocation;
- (void)didSelectNameViewWithGestureRecognizer:(UITapGestureRecognizer*)gestureRecognizer;
@end
