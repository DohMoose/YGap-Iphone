//
//  TourAnnotation.m
//  YGap
//
//  Created by Donald Buchanan on 10/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import "TourAnnotation.h"


@implementation TourAnnotation
@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize visited;

+ (id)annotationWithCoordinate:(CLLocationCoordinate2D)coordinate {
	return [[[[self class] alloc] initWithCoordinate:coordinate] autorelease];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
	self = [super init];
	if(nil != self) {
		self.coordinate = coordinate;
	}
	return self;
}

@end
