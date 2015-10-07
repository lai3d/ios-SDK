//
//  Presence.h
//  backendlessAPI
/*
 * *********************************************************************************************************************
 *
 *  BACKENDLESS.COM CONFIDENTIAL
 *
 *  ********************************************************************************************************************
 *
 *  Copyright 2015 BACKENDLESS.COM. All Rights Reserved.
 *
 *  NOTICE: All information contained herein is, and remains the property of Backendless.com and its suppliers,
 *  if any. The intellectual and technical concepts contained herein are proprietary to Backendless.com and its
 *  suppliers and may be covered by U.S. and Foreign Patents, patents in process, and are protected by trade secret
 *  or copyright law. Dissemination of this information or reproduction of this material is strictly forbidden
 *  unless prior written permission is obtained from Backendless.com.
 *
 *  ********************************************************************************************************************
 */

#import <Foundation/Foundation.h>

@protocol IResponder, IPresenceListener;
@class Fault, BeaconTracker;

@interface Presence : NSObject

// async methods with responder
+(void)startMonitoring:(id<IResponder>)responder;
+(void)startMonitoring:(BOOL)runDiscovery responder:(id<IResponder>)responder;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency responder:(id<IResponder>)responder;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency listener:(id<IPresenceListener>)listener responder:(id<IResponder>)responder;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency listener:(id<IPresenceListener>)listener distanceChange:(double)distanceChange responder:(id<IResponder>)responder;

// async methods with block-based callbacks
+(void)startMonitoring:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
+(void)startMonitoring:(BOOL)runDiscovery response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency listener:(id<IPresenceListener>)listener response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;
+(void)startMonitoring:(BOOL)runDiscovery frequency:(int)frequency listener:(id<IPresenceListener>)listener distanceChange:(double)distanceChange response:(void(^)(id))responseBlock error:(void(^)(Fault *))errorBlock;

// async methods
+(void)stopMonitoring;

@end
