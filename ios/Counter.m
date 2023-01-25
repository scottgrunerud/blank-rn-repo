//
//  Counter.m
//  blankRNproject
//
//  Created by Scott Grunerud on 2023-01-25.
//

#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

//A macro that externalizes the class to react native
@interface RCT_EXTERN_MODULE(Counter, RCTEventEmitter)

//A macro that exports the method to react native
RCT_EXTERN_METHOD(increment:(RCTResponseSenderBlock)callback)

//A macro that exports another (but this time async) method
RCT_EXTERN_METHOD(decrement:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject)

@end
