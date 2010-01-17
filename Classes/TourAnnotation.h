//
//  TourAnnotation.h
//  YGap
//
//  Created by Donald Buchanan on 10/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h>

@interface TourAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D _coordinate; 
	NSString *_title; 
	NSString *_subtitle;
	BOOL visited;
}

+ (id)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) BOOL visited;
@end
