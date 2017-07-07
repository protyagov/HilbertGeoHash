//
//  PerformanceMeasure.swift
//  HilbertGeoHash
//
//  Created by Alex on 7/5/17.
//  Copyright © 2017 Alex Protyagov. All rights reserved.
//

import Foundation


func measureRunTime(_ name: String, _ block: () -> ())  {
    var info = mach_timebase_info()
    guard mach_timebase_info(&info) == KERN_SUCCESS else { return }
    
    let start = mach_absolute_time()
    block()
    let end = mach_absolute_time()
    
    let elapsed = end - start
    
    let nanos = elapsed * UInt64(info.numer) / UInt64(info.denom)
    let st = TimeInterval(nanos) / TimeInterval(NSEC_PER_MSEC)
    
    print("\(name) -> \(st) msec")
}
