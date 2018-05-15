//
//  MarbleRunMap.swift
//  ARMarbleRun
//
//  Created by Dorus Janssens on 15.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class MarbleRunMap<E:Hashable> {
    private var map : [Triple<Int,Int,Int> : E] = [:]
    
    func add(element: E, atLocation key: Triple<Int,Int,Int>) {
        map[key] = element
    }
    
    func removeElement(at key: Triple<Int,Int,Int>) {
        map.removeValue(forKey: key)
    }
    
    func removeElement(element: E) {
        if let keys = getKeys(forElement: element).first {
            map.removeValue(forKey: keys)
        }
    }
    
    func getElement(at key: Triple<Int,Int,Int>) -> E? {
        return map[key]
    }
    
    func getElements(atLevel level: Int) -> [Triple<Int,Int,Int> : E] {
        return map.filter { $0.key.values.1 == level }
    }
    
    func getHorizontalNeighbors(ofElement key: Triple<Int,Int,Int>) -> [Triple<Int,Int,Int> : E] {
        var possibleNeighbors : [Triple<Int,Int,Int>] = []
        possibleNeighbors.append(Triple(key.values.0+1, key.values.1, key.values.2))
        possibleNeighbors.append(Triple(key.values.0-1, key.values.1, key.values.2))
        possibleNeighbors.append(Triple(key.values.0, key.values.1, key.values.2+1))
        possibleNeighbors.append(Triple(key.values.0, key.values.1, key.values.2-1))
        
        return map.filter { (element) -> Bool in
            possibleNeighbors.contains(element.key)
        }
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
