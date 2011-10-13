//
//  ViewController.h
//  Closeby
//
//  Created by John Jusayan on 10/8/11.
//  Copyright (c) 2011 Treeness, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *places;

- (NSMutableArray*)placesFromFileWithName:(NSString*)baseFileName extension:(NSString*)fileExtension;
- (void)removeLabelIfPresent:(id)sender;

@end
