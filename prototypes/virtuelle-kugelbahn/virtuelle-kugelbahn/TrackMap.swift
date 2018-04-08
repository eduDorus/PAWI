//
//  TrackMap.swift
//  virtuelle-kugelbahn
//
//  Created by Lucas Schnüriger on 07.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class TrackMap<E:Hashable> {
    private var map : [Triple<Int,Int,Int> : E] = [:]
    
    func add(element: E, atLocation key: Triple<Int,Int,Int>) {
        map[key] = element
    }
    
    func removeElement(at key: Triple<Int,Int,Int>) {
        map.removeValue(forKey: key)
    }
    
    func getElement(at key: Triple<Int,Int,Int>) -> E? {
        return map[key]
    }
    
    func getElements(atLevel level: Int) -> [Triple<Int,Int,Int> : E] {
        return map.filter { $0.key.values.1 == level }
    }

    func getKeys(forElement element: E) -> [Triple<Int,Int,Int>] {
        return map.filter { $0.value == element }.map { $0.0 }
    }
    
    func forEach(_ f: (Triple<Int,Int,Int>, E) -> Void) {
        for (key, element) in map {
            f(key, element)
        }
    }
}
