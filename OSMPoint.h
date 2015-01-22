//
//  OSMPoint.h
//  Siberian
//
//  Copyright (c) 2014 Siberian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface OSMPoint : NSObject

@property (nonatomic) NSUInteger uid;
@property (nonatomic, copy) NSString *name;
@property (strong, nonatomic) CLLocation *location;

/**
 *  Returns parsed OSMPoint object
 *
 *  @param dictionary Reply from  Xapi
 *
 *  @return OSMPoint object
 */
+ (instancetype)pointFromDictionary:(NSDictionary *)dictionary;

@end
