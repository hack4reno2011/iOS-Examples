//
//  ViewController.m
//  Closeby
//
//  Created by John Jusayan on 10/8/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//

#import "ViewController.h"
#import "ARView.h"
#import "Place.h"

#define H4RLabelTag 1

@implementation ViewController

@synthesize places = _places;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"PlaceTapped" object:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
	[super viewDidLoad];
    [self setPlaces:[self placesFromFileWithName:@"Places" extension:@"plist"]];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"PlaceTapped" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self removeLabelIfPresent:nil];
        
        UILabel *label = [[UILabel alloc] init];
        [label setNumberOfLines:0];
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        label.frame = CGRectMake(0, 0, screenRect.size.width, screenRect.size.height*0.25);
        Place *tappedPlace = (Place*)note.object;
        label.text = tappedPlace.note;
        label.opaque = NO;
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
        [label setTag:H4RLabelTag];
        [self.view addSubview:label];
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeLabelIfPresent:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)removeLabelIfPresent:(id)sender
{
    UILabel *noteLabel = (UILabel*)[self.view viewWithTag:H4RLabelTag];
    [UIView animateWithDuration:0.3 animations:^{
        [noteLabel setAlpha:0.0];                
    } completion:^(BOOL finished) {
        [noteLabel removeFromSuperview];
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	ARView *arView = (ARView *)self.view;
	[arView start];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	ARView *arView = (ARView *)self.view;
	[arView stop];
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

#pragma mark - Places

- (void)setPlaces:(NSMutableArray *)somePlaces
{
    ARView *arView = (ARView *)self.view;
    _places = somePlaces;
    [arView setPlacesOfInterest:_places];	
}

- (NSMutableArray*)placesFromFileWithName:(NSString*)baseFileName extension:(NSString*)fileExtension
{
    fileExtension = [fileExtension stringByReplacingOccurrencesOfString:@"." withString:@""];    
    NSMutableArray *places = [NSMutableArray array];
    
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:baseFileName withExtension:fileExtension];
    NSArray *placeDictionaries = [[NSArray alloc] initWithContentsOfURL:fileURL];
        
    for (NSDictionary *placeDict in placeDictionaries) {
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[[placeDict objectForKey:@"latitude"] doubleValue] longitude:[[placeDict objectForKey:@"longitude"] doubleValue]];
        Place *place = [[Place alloc] initWithName:[placeDict objectForKey:@"name"] andLocation:location];
        place.note = [placeDict objectForKey:@"note"];
        [places addObject:place];
    }
    return places;
}

@end
