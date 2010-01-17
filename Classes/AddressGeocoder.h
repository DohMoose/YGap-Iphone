//
//  AddressGeocoder.h
//  Test
//
//  Created by Bill Dudney on 5/15/09.
//  Copyright 2009 Gala Factory Software LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AddressGeocoder : NSObject {
}

+ (CLLocationCoordinate2D)locationOfAddress:(NSString *)street 
									   city:(NSString *)city
									  state:(NSString *)state
										zip:(NSString *)zip
									country:(NSString *)country;

@end