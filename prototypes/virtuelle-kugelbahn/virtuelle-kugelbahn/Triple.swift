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
            let (a, b, c) = values
            return a.hashValue ^ b.hashValue ^ c.hashValue
        }
    }
    
    init(_ a: T, _ b: U, _ c: V) {
        values = (a, b, c)
    }
}

func ==<T:Hashable,U:Hashable,V:Hashable>(lhs: Triple<T,U,V>, rhs: Triple<T,U,V>) -> Bool {
    return lhs.values == rhs.values
}
