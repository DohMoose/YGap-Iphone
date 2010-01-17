//
//  AddressGeocoder.m
//  Test
//
//  Created by Bill Dudney on 5/15/09.
//  Copyright 2009 Gala Factory Software LLC. All rights reserved.
//

#import "AddressGeocoder.h"
#import "CXMLNode_XPathExtensions.h"
#import "CXMLDocument.h"

NSString *MAPS_API_KEY = @"ABQIAAAATejoI1-rG9VOa4T5f3ppWRRYQtG-vnXKOEpkBE1rl0xG1xYLZBTYfFQvZDnVp0yQINRy-HPV5AeNaA";

@implementation AddressGeocoder

+ (NSURL *)urlForAddress:(NSString *)street 
                    city:(NSString *)city
                   state:(NSString *)state
                     zip:(NSString *)zip
                 country:(NSString *)country {
	NSString *wholeAddress = [NSString stringWithFormat:@"%@ %@ %@ %@ %@", 
							  street, city, state, zip, country];
	NSString *firstHalf = @"http://maps.google.com/maps/geo?q=";
	NSString *secondHalf = @"&output=xml&sensor=false&key=";
	NSString *unEscapedURL = [NSString stringWithFormat:@"%@%@%@%@", 
							  firstHalf, wholeAddress, secondHalf, 
							  MAPS_API_KEY];
	NSString *urlString = [unEscapedURL 
						   stringByAddingPercentEscapesUsingEncoding:
						   NSUTF8StringEncoding];
	return [NSURL URLWithString:urlString];
}

//START:code.geocode.impl
+ (BOOL)geocodeStreetAddress:(NSString *)street 
                        city:(NSString *)city
                       state:(NSString *)state
                         zip:(NSString *)zip
                     country:(NSString *)country
                intoLocation:(CLLocationCoordinate2D *)location {
	BOOL success = NO;
	NSURL *url = [self urlForAddress:street city:city state:state
								 zip:zip country:country]; // <label id="code.geocode.geturl"/>
	NSError *error = nil;
	CXMLDocument *doc = [[CXMLDocument alloc] 
						 initWithContentsOfURL:url 
						 options:CXMLDocumentTidyXML error:&error]; // <label id="code.geocode.getdoc"/>
	CXMLElement *element = [doc rootElement];
	NSDictionary *namespaceMappings = 
	[NSDictionary dictionaryWithObject:@"http://earth.google.com/kml/2.0"
								forKey:@"kml"];  // <label id="code.geocode.setNS"/>
	NSArray *status = [element nodesForXPath:@"//kml:Status/kml:code" 
						   namespaceMappings:namespaceMappings
									   error:&error]; // <label id="code.geocode.getStatus"/>
	if([@"200" isEqualToString:[[status objectAtIndex:0] stringValue]]) {
		NSArray *coordElements = [element nodesForXPath:@"//kml:coordinates"
									  namespaceMappings:namespaceMappings
												  error:&error]; // <label id="code.geocode.getcoords"/>
		NSString *coords = [[coordElements objectAtIndex:0] stringValue];
		NSArray *components = [coords componentsSeparatedByString:@","];
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		NSNumber *longitude = 
        [formatter numberFromString:[components objectAtIndex:0]];
		NSNumber *latitude = 
        [formatter numberFromString:[components objectAtIndex:1]];
		location->longitude = [longitude floatValue];
		location->latitude = [latitude floatValue];
		[formatter release];
		success = YES;
	}
	return success;
}
//END:code.geocode.impl

+ (CLLocationCoordinate2D)locationOfAddress:(NSString *)street 
									   city:(NSString *)city
									  state:(NSString *)state
										zip:(NSString *)zip
									country:(NSString *)country {
	CLLocationCoordinate2D location = {0.0f, 0.0f};
	if(nil == street || [street length] == 0) {
		street = @"";
	}
	if(nil == city || [city length] == 0) {
		city = @"";
	}
	if(nil == state || [state length] == 0) {
		state = @"";
	}
	if(nil == zip || [zip length] == 0) {
		zip = @"";
	}
	if(nil == country || [country length] == 0) {
		country = @"";
	}
	
	if(![self geocodeStreetAddress:street city:city
							 state:state zip:zip country:country
					  intoLocation:&location]) {
		[self geocodeStreetAddress:@"" city:city state:state zip:zip
						   country:country intoLocation:&location];
	}
	
	return location;
}

@end