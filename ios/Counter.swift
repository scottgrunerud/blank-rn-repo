//
//  Counter.swift
//  blankRNproject
//
//  Created by Scott Grunerud on 2023-01-25.
//

import Foundation


// The @objc(Counter) decorater exposes our "Counter" class to the Objective-C runtime
@objc(Counter)
class Counter: NSObject {
  
  private var count = 0;
  
  
//  We need to use a _ in the parameter definition because objective c doesn't have named parameters
  @objc
  func increment(_ callback:RCTResponseSenderBlock){
    count += 1;
    callback([count])
  }
  
  
  @objc
  func constantsToExport()->[String: Any]! {
    return ["count": count];
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
    }
  }
  
  
//  Important method essentially React Native that we want our native modulues to be
//  initalized on the main thread before any JS is executed - we want this to be true because it is needed for UI stuff
  @objc
  static func requiresMainQueueSetup()-> Bool {
    return true
  }
  

}
