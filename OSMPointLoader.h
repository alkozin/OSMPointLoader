//
//  OSMPointLoader.h
//  Siberian
//
//  Copyright (c) 2014 Siberian. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface OSMPointLoader : NSObject

/**
*  Loads POIs for amenity nearest to coordinate with coordinate delta.
*  Query makes a box with center in 'coordinate' and delta in each direction equals to 'coordinateDelta'
*
*  @param amenity         Search for points with amenity equals to this value
*  @param coordinate      Coordinate for searching POI's nearest to
*  @param coordinateDelta Coordinate delta to create seaching box
*  @param completion      Block to invoke after request complete
*
*  @return An instance of OSMPointLoader
*/
+ (instancetype)loadPOIsForAmenity:(NSString *)amenity
                        coordinate:(CLLocationCoordinate2D)coordinate
                   coordinateDelta:(CLLocationDegrees)coordinateDelta
                        completion:(void (^)(NSArray *POIs, NSError *error))completion;

@end
