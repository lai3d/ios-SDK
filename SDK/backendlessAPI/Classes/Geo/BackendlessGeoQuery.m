//
//  BackendlessGeoQuery.m
//  backendlessAPI
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2012 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

#import "BackendlessGeoQuery.h"
#import "DEBUG.h"

#define DEFAULT_PAGE_SIZE 20
#define DEFAULT_OFFSET 0
#define CLUSTER_SIZE_DEFAULT_VALUE 100

@interface BackendlessGeoQuery () {
    UNITS queryUnits;
}
@end

@implementation BackendlessGeoQuery

-(void)defaultInit {
    
    self.latitude = @0.0;
    self.longitude = @0.0;
    self.radius = @0.0;
    self.units = nil;
    self.categories = nil;
    self.includeMeta = @NO;
    self.metadata = nil;
    self.searchRectangle = nil;
    self.pageSize = @((int)DEFAULT_PAGE_SIZE);
    self.offset = @((int)DEFAULT_OFFSET);
    self.whereClause = nil;
    self.relativeFindPercentThreshold = @0.0;
    self.relativeFindMetadata = nil;
    self.dpp = nil;
    self.clusterGridSize = nil;
    
    queryUnits = -1;
}

-(id)init {
	
    if ( (self=[super init]) ) {
        [self defaultInit];
	}
	return self;
}

-(id)initWithCategories:(NSArray *)categories {
	
    if ( (self=[super init]) ) {
        [self defaultInit];
        [self categories:categories];
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point {
	
    if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point pageSize:(int)pageSize offset:(int)offset {
	
    if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
        self.pageSize = @(pageSize);
        self.offset = @(offset);
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point categories:(NSArray *)categories {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
        [self categories:categories];
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
        self.radius = @(radius);
        [self units:(int)units];
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units categories:(NSArray *)categories {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
        self.radius = @(radius);
        [self units:(int)units];
        [self categories:categories];
	}
	return self;
}

-(id)initWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units categories:(NSArray *)categories metadata:(NSDictionary *)metadata {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        self.latitude = @(point.latitude);
        self.longitude = @(point.longitude);
        self.radius = @(radius);
        [self units:(int)units];
        [self categories:categories];
        [self metadata:metadata];
	}
	return self;
}

-(id)initWithRect:(GEO_POINT)nordWest southEast:(GEO_POINT)southEast {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        [self searchRectangle:nordWest southEast:southEast];
	}
	return self;
}

-(id)initWithRect:(GEO_POINT)nordWest southEast:(GEO_POINT)southEast categories:(NSArray *)categories {
    
	if ( (self=[super init]) ) {
        [self defaultInit];
        [self searchRectangle:nordWest southEast:southEast];
        [self categories:categories];
	}
	return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"BackendlessGeoQuery: latitude:%@, lonitude:%@, radius:%@, units:%@, searchRectangle:%@, categories:%@, includeMeta:%@, metadata:%@, pageSize:%@, offset:%@, whereClause:\'%@\', dpp:%@, clusterGridSize:%@, relativeFindPercentThreshold:%@, relativeFindMetadata:%@", self.latitude, self.longitude, self.radius, self.units, self.searchRectangle, self.categories, self.includeMeta, self.metadata, self.pageSize, self.offset, self.whereClause, self.dpp, self.clusterGridSize, self.relativeFindPercentThreshold, self.relativeFindMetadata];
}

+(id)query {
    return [[BackendlessGeoQuery new] autorelease];
}

+(id)queryWithCategories:(NSArray *)categories {
    return [[[BackendlessGeoQuery alloc] initWithCategories:categories] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point pageSize:(int)pageSize offset:(int)offset {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point pageSize:pageSize offset:offset] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point categories:(NSArray *)categories {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point categories:categories] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point radius:radius units:units] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units categories:(NSArray *)categories {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point radius:radius units:units categories:categories] autorelease];
}

+(id)queryWithPoint:(GEO_POINT)point radius:(double)radius units:(UNITS)units categories:(NSArray *)categories metadata:(NSDictionary *)metadata {
    return [[[BackendlessGeoQuery alloc] initWithPoint:point radius:radius units:units categories:categories metadata:metadata] autorelease];
}

+(id)queryWithRect:(GEO_POINT)nordWest southEast:(GEO_POINT)southEast {
    return [[[BackendlessGeoQuery alloc] initWithRect:nordWest southEast:southEast] autorelease];
}

+(id)queryWithRect:(GEO_POINT)nordWest southEast:(GEO_POINT)southEast categories:(NSArray *)categories {
    return [[[BackendlessGeoQuery alloc] initWithRect:nordWest southEast:southEast categories:categories] autorelease];
}

-(void)dealloc {
	
	[DebLog logN:@"DEALLOC BackendlessGeoQuery: %@", self];
    
    [self.latitude release];
    [self.longitude release];
    [self.radius release];
    [self.units release];
    [self.categories release];
    [self.includeMeta release];
    [self.metadata release];
    [self.searchRectangle release];
    [self.pageSize release];
    [self.offset release];
	[self.whereClause release];
    [self.relativeFindPercentThreshold release];
    [self.relativeFindMetadata release];
    [self.dpp release];
    [self.clusterGridSize release];
    
    [super dealloc];
}

#pragma mark -
#pragma mark Public Methods

-(double)valLatitude {
    return _latitude.doubleValue;
}

-(void)latitude:(double)latitude {
    self.latitude = @(latitude);
}

-(double)valLongitude {
    return _longitude.doubleValue;
}

-(void)longitude:(double)longitude {
    self.longitude = @(longitude);
}

-(double)valRadius {
    return _radius.doubleValue;
}

-(void)radius:(double)radius {
    self.radius = @(radius);
}

-(UNITS)valUnits {
    return queryUnits;
}

static const char * const backendless_geo_query_units[] = { "METERS", "MILES", "YARDS", "KILOMETERS", "FEET" };

-(void)units:(UNITS)units {
    queryUnits = units;
    self.units = [NSString stringWithUTF8String:backendless_geo_query_units[(int)units]];
}

-(NSArray *)valCategories {
    return _categories;
}

-(void)categories:(NSArray *)categories {
    [self.categories removeAllObjects];
    self.categories = categories? [NSMutableArray arrayWithArray:categories] : nil;
}

-(BOOL)valIncludeMeta {
    return _includeMeta.boolValue;
}

-(void)includeMeta:(BOOL)includeMeta {
    self.includeMeta = @(includeMeta);
}

-(NSDictionary *)valMetadata {
    return _metadata;
}

-(void)metadata:(NSDictionary *)metadata {
    if (metadata && metadata.count) [self includeMeta:YES];
    [self.metadata removeAllObjects];
    self.metadata = metadata? [NSMutableDictionary dictionaryWithDictionary:metadata] : nil;
}

-(NSArray *)valSearchRectangle {
    return _searchRectangle;
}

-(void)searchRectangle:(NSArray *)searchRectangle {
    self.searchRectangle = searchRectangle;
}

-(int)valPageSize {
    return _pageSize.intValue;
}

-(void)pageSize:(int)pageSize {
    self.pageSize = @(pageSize);
}

-(int)valOffset {
    return _offset.intValue;
}

-(void)offset:(int)offset {
    self.offset = @(offset);
}

-(double)valRelativeFindPercentThreshold {
    return _relativeFindPercentThreshold.doubleValue;
}

-(void)relativeFindPercentThreshold:(double)percent {
    self.relativeFindPercentThreshold = @(percent);
}

-(double)valDpp {
    return _dpp.doubleValue;
}

-(void)dpp:(double)dpp {
    self.dpp = @(dpp);
}

-(int)valClusterGridSize {
    return _clusterGridSize.intValue;
}

-(void)clusterGridSize:(int)size {
    self.clusterGridSize = @(size);
}

-(void)searchRectangle:(GEO_POINT)nordWest southEast:(GEO_POINT)southEast {
    [self searchRectangle:@[@(nordWest.latitude), @(nordWest.longitude), @(southEast.latitude), @(southEast.longitude)]];
}

-(BOOL)addCategory:(NSString *)category {
    
    if (!category)
        return NO;
    
    _categories? [_categories addObject:category] : [self categories:@[category]];
    return YES;
}

-(BOOL)putMetadata:(NSString *)key value:(id)value {
    
    if (!key || !value)
        return NO;
    
    _metadata? [_metadata setValue:value forKey:key] : [self metadata:@{key:value}];
    return YES;
}

-(BOOL)putRelativeFindMetadata:(NSString *)key value:(id)value {
    
    if (!key || !value)
        return NO;
    
    if (_relativeFindMetadata) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:_relativeFindMetadata];
        [dict setValue:value forKey:key];
        self.relativeFindMetadata = dict;
    }
    else {
        self.relativeFindMetadata = @{key:value};
    }
    return YES;
}

-(void)setClusteringParams:(double)degreePerPixel clusterGridSize:(int)size {
    self.dpp = @(degreePerPixel);
    self.clusterGridSize = @(size);
}

-(void)setClusteringParams:(double)westLongitude eastLongitude:(double)eastLongitude mapWidth:(int)mapWidth {
    [self setClusteringParams:westLongitude eastLongitude:eastLongitude mapWidth:mapWidth clusterGridSize:CLUSTER_SIZE_DEFAULT_VALUE];
}

-(void)setClusteringParams:(double)westLongitude eastLongitude:(double)eastLongitude mapWidth:(int)mapWidth clusterGridSize:(int)clusterGridSize {
    
    double longDiff = eastLongitude - westLongitude;
    if( longDiff < 0 ) {
        longDiff += 360;
    }
    
    double degreePerPixel = longDiff/mapWidth;
    [self setClusteringParams:degreePerPixel clusterGridSize:clusterGridSize];
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    
    BackendlessGeoQuery *query = [BackendlessGeoQuery query];
    query.latitude = _latitude.copy;
    query.longitude = _longitude.copy;
    query.radius = _radius.copy;
    query.units = _units.copy;
    query.categories = _categories.copy;
    query.includeMeta = _includeMeta.copy;
    query.metadata = _metadata.copy;
    query.searchRectangle = _searchRectangle.copy;
    query.pageSize = _pageSize.copy;
    query.offset = _offset.copy;
    query.whereClause = _whereClause.copy;
    query.relativeFindPercentThreshold = _relativeFindPercentThreshold.copy;
    query.relativeFindMetadata = _relativeFindMetadata.copy;
    query.dpp = _dpp.copy;
    query.clusterGridSize = _clusterGridSize.copy;
    return query;
}

@end
