//
//  TourController.h
//  YGap
//
//  Created by Donald Buchanan on 10/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TouchXML.h"

@class TourAnnotation;
@interface TourController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>  {
	MKMapView *_mapView;
	TourAnnotation *_newAnnotation;
	NSMutableArray *tour_annotations;
}
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) TourAnnotation *newAnnotation;
@property(nonatomic, retain) NSMutableArray *tour_annotations;
@end
