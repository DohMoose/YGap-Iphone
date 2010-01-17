//
//  TourController.m
//  YGap
//
//  Created by Donald Buchanan on 10/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import "TourController.h"
#import "TourAnnotation.h"
#import "AddressGeocoder.h"

@implementation TourController
@synthesize mapView = _mapView;
@synthesize newAnnotation = _newAnnotation;
@synthesize tour_annotations;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(NSMutableArray *)tour_annotations {
	if(nil == tour_annotations) {
		tour_annotations = [[NSMutableArray alloc] init];
	}
	return tour_annotations;
}
- (void)setCurrentLocation:(CLLocation *)location {
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center = location.coordinate;
	region.span.longitudeDelta = 0.15f;
	region.span.latitudeDelta = 0.15f;
	[self.mapView setRegion:region animated:YES];
}

- (void)recenterMap {
	NSArray *coordinates = [self.mapView valueForKeyPath:@"annotations.coordinate"];
	CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
	CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
	for(NSValue *value in coordinates) {
		CLLocationCoordinate2D coord = {0.0f, 0.0f};
		[value getValue:&coord];
		if(coord.longitude > maxCoord.longitude) {
			maxCoord.longitude = coord.longitude;
		}
		if(coord.latitude > maxCoord.latitude) {
			maxCoord.latitude = coord.latitude;
		}
		if(coord.longitude < minCoord.longitude) {
			minCoord.longitude = coord.longitude;
		}
		if(coord.latitude < minCoord.latitude) {
			minCoord.latitude = coord.latitude;
		}
	}
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
	region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
	region.span.longitudeDelta = maxCoord.longitude - minCoord.longitude;
	region.span.latitudeDelta = maxCoord.latitude - minCoord.latitude;
	[self.mapView setRegion:region animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	NSURL *locations = [NSURL URLWithString:@"http://dl.dropbox.com/u/1534657/locations.xml"];
	NSError *error = nil;
	
	CXMLDocument *locationsParser = [[[CXMLDocument alloc] initWithContentsOfURL:locations options:0 error:nil] autorelease];
	
    NSArray *resultNodes = NULL;
	
    resultNodes = [locationsParser nodesForXPath:@"//location" error:&error];
	CLLocationCoordinate2D coordinate = {0.0f,0.0f};
  
	for (CXMLElement *resultElement in resultNodes) {
		NSMutableDictionary *mapItem = [[NSMutableDictionary alloc] init];
		int counter;
		
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
			CXMLElement *childNode = (CXMLElement *)[resultElement childAtIndex:counter];
			
			if ([[resultElement childAtIndex:counter] stringValue]	 != nil){
				// Add each field to the blogItem Dictionary with the node name as key and node value as the value
				[mapItem setObject:[childNode stringValue] forKey:[childNode name]];
			}
		}
		self.newAnnotation = [TourAnnotation annotationWithCoordinate: coordinate];
		self.newAnnotation.title = [mapItem valueForKey:@"city"];
		self.newAnnotation.visited = [[mapItem valueForKey:@"visited"] boolValue];
		NSString *latitudeString = [mapItem valueForKey:@"latitude"];
		if (latitudeString != nil) {
			coordinate.latitude = [latitudeString floatValue];
			coordinate.longitude = [[mapItem valueForKey:@"longitude"] floatValue];
			self.newAnnotation.coordinate = coordinate;
		}
		else {
			self.newAnnotation.coordinate = [AddressGeocoder locationOfAddress:nil city:[mapItem valueForKey:@"city"] state:[mapItem valueForKey:@"state"] zip:nil country:@"Australia"];
		}

		NSLog(@"%@-%@=%f*%f", [mapItem valueForKey:@"city"], [mapItem valueForKey:@"state"], self.newAnnotation.coordinate.latitude,self.newAnnotation.coordinate.longitude); 
		if(self.newAnnotation != nil) {
		    [self.tour_annotations addObject:self.newAnnotation];
			self.newAnnotation = nil;
		} 
		[mapItem release];
		
	}

}

- (void)viewDidAppear:(BOOL)animated { 
	[super viewDidAppear:animated];
	TourAnnotation *annotation;
	for (annotation in self.tour_annotations){
		[self.mapView addAnnotation: annotation];
	}
	[self recenterMap];
}
		 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	NSUInteger colour = MKPinAnnotationColorGreen;
	if ([(TourAnnotation *)annotation visited]) {
		colour = MKPinAnnotationColorPurple;
	}
	
	MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
	if(view == nil) {
		view = [[[MKPinAnnotationView alloc]
				 initWithAnnotation:annotation reuseIdentifier:@"identifier"]
				autorelease];
	}
	[view setPinColor:colour];
	[view setCanShowCallout:YES];
	[view setAnimatesDrop:YES];
	return view;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
}


- (void)dealloc {
	self.mapView = nil;
	self.newAnnotation = nil;
    [super dealloc];
}


@end
