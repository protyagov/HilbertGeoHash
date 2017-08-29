//
//  HilbertCoder.swift
//  HilbertGeoHash
//
//  Created by Alex on 7/5/17.
//  Copyright © 2017 Alex Protyagov. All rights reserved.
//

import Foundation

//---------------------------------------------------------------------------------------------------
// My implementation is based on fast Hilbert value calculation invented by Ningtao Chen
// School of Computer Science and Technology, Huazhong University of Science and Technology,
// People’s Republic of China
//
// Published: SOFTWARE—PRACTICE AND EXPERIENCESoftw. Pract. Exper. 2007; 37:897–908
// After reading paper I just wanted to iplement that in code and see how it performs in Swift 4
class HilbertCoder {
    // (x,y) are zero based -- bottom left is (0,0)
    static func hashForXY(_ x: Int, _ y: Int) -> String {
        let m = max(x, y)
        if m == 0 { return "0" }
        
        var h = ""
        var x = Int64(x)
        var y = Int64(y)
        var t: Int64!
        
        var rm = Int(floor(log2(Double(m))) + 1)
        var w = Int64(2) << (rm - 2)
        
        while rm != 0 {
            let m = (2 << (rm - 1)) >> 1
            
            if x >= m && y >= m {
                h += "2"
                x -= w
                y -= w
            } else if x < m && y < m {
                h += "0"
                x = x ^ y
                y = x ^ y
                x = x ^ y
            } else if x < m && y >= m {
                if rm & 1 == 0 {
                    h += "3"
                    t = w - x - 1
                    y = w << 1 - y - 1
                    x = t
                } else {
                    h += "1"
                    t = y - w
                    y = x
                    x = t
                }
            } else if rm & 1 == 0 {
                h += "1"
                t = y
                y = x - w
                x = t
                
            } else {
                h += "3"
                t = w << 1 - x - 1
                y = w - y - 1
                x = t
            }
            rm -= 1
            w >>= 1
        }
        return h
    }
}
