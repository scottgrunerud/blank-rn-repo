//
//  Counter.swift
//  blankRNproject
//
//  Created by Scott Grunerud on 2023-01-25.
//

import Foundation


// The @objc(Counter) decorater exposes our "Counter" class to the Objective-C runtime
@objc(Counter)
class Counter: RCTEventEmitter {
  
  private var count = 0;
  
  
//  We need to use a _ in the parameter definition because objective c doesn't have named parameters
  @objc
  func increment(_ callback:RCTResponseSenderBlock){
    count += 1;
    callback([count])
    sendEvent(withName: "onIncrement", body: ["count": count])
  }
  
  
//  When using event emitters we are forced to override this function
  @objc
 override func constantsToExport()->[AnyHashable: Any]! {
    return ["count": count];
  }
  
//  We need to register which events are supported, they should match the value of the "withName" parameter defined in the sendEvent() method
  override func supportedEvents() -> [String]! {
    return ["onIncrement", "onDecrement"]
  }
  
  
//  Async Function
  @objc
  func decrement(_ resolve:RCTPromiseResolveBlock, reject: RCTPromiseRejectBlock) {
    if(count == 0){
      let error = NSError(domain: "", code: 400, userInfo: nil)
      reject("ERROR_COUNT", "count cannot be negative", error)
    } else {
      count -= 1;
      resolve([count])
      sendEvent(withName: "onDecrement", body: ["count": count])
    }
  }
  
  
//  Important method essentially React Native that we want our native modulues to be
//  initalized on the main thread before any JS is executed - we want this to be true because it is needed for UI stuff
  @objc
  override static func requiresMainQueueSetup()-> Bool {
    return true
  }
  

}
