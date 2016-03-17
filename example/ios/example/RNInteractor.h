//
//  RNInteractor.h
//  example
//
//  Created by Livio Bieri on 15/03/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "RCTBridgeModule.h"
#import "RCTEventDispatcher.h"
#import <Interactor_static/Interactor.h>

@interface RNInteractor : NSObject<RCTBridgeModule, BeaconListener, EventListener>

@property (strong, nonatomic) Interactor *interactor;
- (void)eventTriggered:(LBSEvent *)data;
- (void)didRangeRegion:(LBSBeaconEvent *)event;
- (void) yolo;
@end
