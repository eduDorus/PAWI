//
//  Triple.swift
//  virtuelle-kugelbahn
//
//  Created by Lucas Schnüriger on 07.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

struct Triple<T:Hashable,U:Hashable,V:Hashable> : Hashable {
    let values: (T, U, V)

    var hashValue: Int {
        get {
            // based on: https://stackoverflow.com/a/5730232
            let (x, y, z) = values
            var result = Int(x.hashValue ^ (x.hashValue >> 32))
            result = 31 * result + Int(y.hashValue ^ (y.hashValue >> 32))
            result = 31 * result + Int(z.hashValue ^ (z.hashValue >> 32))
            return result;
        }
    }
    
    init(_ a: T, _ b: U, _ c: V) {
        values = (a, b, c)
    }
}

func ==<T:Hashable,U:Hashable,V:Hashable>(lhs: Triple<T,U,V>, rhs: Triple<T,U,V>) -> Bool {
    return lhs.values == rhs.values
}
