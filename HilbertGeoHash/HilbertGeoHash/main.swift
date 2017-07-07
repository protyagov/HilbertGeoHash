//
//  main.swift
//  HilbertGeoHash
//
//  Created by Alex on 7/5/17.
//  Copyright © 2017 Alex Protyagov. All rights reserved.
//

import Foundation

var box = 100

measureRunTime("\nHibert Cruve algorithm by Ningtao Chen\n Data size: \(box)") {
    let s = box
    for n in 0..<s {
        let rr2 = HilbertCoder.hashForXY(n, n)
    }
}

measureRunTime("\nHilbert Cruve algorithm by Xian Lu\n Data size: \(box)") {
    let s = box
    for n in 0..<s {
        let rr2 = HilbertOrder.encode(x: n, y: n, r: box)
    }
}

box = 1000
measureRunTime("\nHibert Cruve algorithm by Ningtao Chen\n Data size: \(box)") {
    let s = box
    for n in 0..<s {
        let rr2 = HilbertCoder.hashForXY(n, n)
    }
}

measureRunTime("\nHilbert Cruve algorithm by Xian Lu\n Data size: \(box)") {
    let s = box
    for n in 0..<s {
        let rr2 = HilbertOrder.encode(x: n, y: n, r: box)
    }
}

print("---------------")
