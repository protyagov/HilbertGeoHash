//
//  HilbertOrder.swift
//  HilbertGeoHash
//
//  Created by Alex on 7/5/17.
//  Copyright © 2017 Alex Protyagov. All rights reserved.
//

import Foundation


// This implementation of calculating Hilbert Curve Distance is taken from post on SlackOverflow
// https://stackoverflow.com/a/313964/1689733
// It  implements "Encoding and decoding the Hilbert order" by Xian Lu and Gunther Schrack,
// published in Software: Practice and Experience Vol. 26 pp 1335-46 (1996).
// I simply converted it from Java to Swift 4
public class HilbertOrder{

    static func encode(x: Int, y: Int, r: Int) -> Int {
        
        let mask = (1 << r) - 1
        var hodd = 0
        let heven = x ^ y
        let notx = ~x & mask
        let noty = ~y & mask
        let temp = notx ^ y
        
        var v0 = 0
        var v1 = 0
        for k in 1..<r {
            v1 = ((v1 & heven) | ((v0 ^ noty) & temp)) >> 1;
            v0 = ((v0 & (v1 ^ notx)) | (~v0 & (v1 ^ noty))) >> 1;
        }
        hodd = (~v0 & (v1 ^ x)) | (v0 & (v1 ^ noty));
        
        var res = interleaveBits(odd: hodd, even: heven);
        return res
    }
    
    /**
     * Interleave the bits from two input integer values
     * @param odd integer holding bit values for odd bit positions
     * @param even integer holding bit values for even bit positions
     * @return the integer that results from interleaving the input bits
     *
     * @todo: I'm sure there's a more elegant way of doing this !
     */
    static func interleaveBits(odd: Int, even: Int) -> Int {
        var val = 0
        var m = max(odd, even)
        var n = 0
        
        while m > 0 {
            n += 1
            m >>= 1
        }
        
        for i in 0..<n {
            let bitMask = 1 << i;
            let a = (even & bitMask) > 0 ? (1 << (2 * i)) : 0;
            let b = (odd & bitMask) > 0 ? (1 << (2 * i + 1)) : 0;
            val += a + b;
        }
        
        return val;
    }
}
