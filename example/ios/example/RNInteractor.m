//
//  RNInteractor.m
//  example
//
//  Created by Livio Bieri on 15/03/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RNInteractor.h"

@implementation RNInteractor;


RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD(isRunning:(RCTResponseSenderBlock)callback)
{
	_interactor = [Interactor sharedInteractor];
	
	NSString* isRunning = @"Not Running";
	
	if (_interactor.isRunning) {
		isRunning = @"Running";
	}
	
	callback(@[isRunning]);
}

RCT_EXPORT_METHOD(setup)
{
	LBSConfig *config = [[LBSConfig alloc]init];
	config.server = @"https://interact-scaled.swisscom.com";
	config.apiKey = @"be2e33b1-dead-ff35-a8f9-bd6cdce1bef4";
	config.logging = YES;
	
	[[Interactor sharedInteractor] configureWithConfig:config];
	[[Interactor sharedInteractor] startInteractor];
	
	// Register to listen for all Events emitted
	[[Interactor sharedInteractor] registerEventListener: self];
	
	// Register to listen for all Beacons
	NSMutableSet * beacons = [[Interactor sharedInteractor] getAllBeacons];
	for (LBSBeacon * beacon in beacons) {
		[[Interactor sharedInteractor] registerBeaconListener: self forBeacon: beacon];
	}
}


-(void)eventTriggered:(LBSEvent *)data {
	
	[self.bridge.eventDispatcher sendAppEventWithName:@"eventTriggered"
																							 body:@{@"name":
																												data.name,
																											@"eventDescription":
																												data.eventDescription
																											}];
}

-(void)didRangeRegion:(LBSBeaconEvent *)event{
	
	NSString *rssi = [@(event.rssi) stringValue];
	[self.bridge.eventDispatcher sendAppEventWithName:@"didRangeRegion"
																							 body:@{@"rssi":rssi}];
}

@end
