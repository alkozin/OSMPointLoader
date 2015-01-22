//
//  OSMPointLoader.m
//  Siberian
//
//  Copyright (c) 2014 Siberian. All rights reserved.
//

#import "OSMPointLoader.h"

#import "OSMPoint.h"
#import <XMLDictionary.h>

@implementation OSMPointLoader

+ (instancetype)loadPOIsForAmenity:(NSString *)amenity
                        coordinate:(CLLocationCoordinate2D)coordinate
                   coordinateDelta:(CLLocationDegrees)coordinateDelta
                        completion:(void (^)(NSArray *POIs, NSError *error))completion
{
    OSMPointLoader *loader= [OSMPointLoader new];
    [loader loadPOIsForAmenity:amenity
                    coordinate:coordinate
               coordinateDelta:coordinateDelta
                    completion:completion];

    return loader;
}

- (void)loadPOIsForAmenity:(NSString *)amenity
                coordinate:(CLLocationCoordinate2D)coordinate
           coordinateDelta:(CLLocationDegrees)coordinateDelta
                completion:(void (^)(NSArray *POIs, NSError *error))completion
{
    NSAssert(completion, @"Completion can't be nil. How you hope to see results?!");

    CLLocationDegrees lat = coordinate.latitude;
    CLLocationDegrees lon = coordinate.longitude;

    // Sample URL
    // http://www.overpass-api.de/api/xapi?node[amenity=fuel][bbox=82.84241,54.93661,83.07037,55.03274]
    NSString *URLString = [NSString stringWithFormat:@"http://www.overpass-api.de/api/xapi?node[amenity=%@][bbox=%f,%f,%f,%f]",
                           amenity,
                           lon - coordinateDelta,
                           lat - coordinateDelta,
                           lon + coordinateDelta,
                           lat + coordinateDelta];

    NSURL *url = [NSURL URLWithString:URLString];

    NSURLSessionDataTask *task;
    task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           if (error) {
                                               completion(nil, error);
                                           } else {
                                               XMLDictionaryParser *parser = [XMLDictionaryParser new];
                                               NSDictionary *reply = [parser dictionaryWithData:data];

                                               NSArray *points = [self pointsFromReply:reply];
                                               completion(points, nil);
                                           }
                                       }];
    [task resume];
}

- (NSArray *)pointsFromReply:(NSDictionary *)reply
{
    Class classToParse = [self pointClass];
    NSArray *pointsSource = reply[@"node"];

    NSMutableArray *points = [NSMutableArray arrayWithCapacity:pointsSource.count];
    for (NSDictionary *pointSource in pointsSource) {
        OSMPoint *point = [classToParse pointFromDictionary:pointSource];
        [points addObject:point];
    }

    return points;
}

// Point to override class to parse reply
// You can create subclass from OSMPointLoader and return some subclass of OSMPoint in this method
- (Class)pointClass
{
    return [OSMPoint class];
}

@end
