//
//  OSMPoint.m
//  Siberian
//
//  Copyright (c) 2014 Siberian. All rights reserved.
//

#import "OSMPoint.h"

@import CoreLocation;

@implementation OSMPoint

+ (instancetype)pointFromDictionary:(NSDictionary *)dictionary
{
    OSMPoint *point;

    CLLocation *location = [[CLLocation alloc] initWithLatitude:[dictionary[@"_lat"] doubleValue]
                                                      longitude:[dictionary[@"_lon"] doubleValue]];
    NSArray *tagsArray = dictionary[@"tag"];
    NSDictionary *tags = [NSDictionary dictionaryWithObjects:[tagsArray valueForKey:@"_v"]
                                                     forKeys:[tagsArray valueForKey:@"_k"]];

    point = [OSMPoint new];
    [point setUid:(NSUInteger)[dictionary[@"_id"] integerValue]];
    [point setName:tags[@"name"]];
    [point setLocation:location];

    return point;
}

@end
