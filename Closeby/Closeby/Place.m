//
//  Place.m
//  Closeby
//
//  Created by John Jusayan on 10/8/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//


#import "Place.h"

@implementation Place

@synthesize name = _name;
@synthesize note = _note;
@synthesize associatedView = _associatedView;
@synthesize location = _location;

- (id)initWithName:(NSString*)aName andLocation:(CLLocation*)aLocation
{
    self = [super init];
    if (self) {
        _name = aName;
        _location = aLocation;
        
        UILabel *label = [[UILabel alloc] init];
        label.adjustsFontSizeToFitWidth = NO;
        label.opaque = NO;
        label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
        label.center = CGPointMake(200.0f, 200.0f);
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = aName;
        CGSize size = [label.text sizeWithFont:label.font];
        label.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectNameViewWithGestureRecognizer:)];
        [label addGestureRecognizer:tapGestureRecognizer];
        _associatedView = label;
    }    
    return self;
}

- (void)setName:(NSString *)aName
{
    _name = aName;
    
    UILabel *label = [[UILabel alloc] init];
    label.adjustsFontSizeToFitWidth = NO;
    label.opaque = NO;
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
    label.center = CGPointMake(200.0f, 200.0f);
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = aName;
    CGSize size = [label.text sizeWithFont:label.font];
    label.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectNameViewWithGestureRecognizer:)];
    [label addGestureRecognizer:tapGestureRecognizer];
    self.associatedView = label;
}

- (void)didSelectNameViewWithGestureRecognizer:(UITapGestureRecognizer*)gestureRecognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlaceTapped" object:self userInfo:nil];
}


@end
