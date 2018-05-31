//
//  DepthFirstSort.swift
//  ARMarbleRun
//

import Foundation

class DepthFirstSort {
    let nodes : [Triple<Int,Int,Int>]
    var result : [Triple<Int,Int,Int>] = []
    var currentPointer = 0

    init(_ elements : [Triple<Int,Int,Int>]) {
        self.nodes = elements
    }

    func generate() -> [Triple<Int,Int,Int>] {
        let start = startNode()
        search(from: start)
        var level = 0
        while result.count != nodes.count {
            if let missing = notFoundNode(onLevel: level) {
                search(from: missing)
            } else {
                level += 1
                search(from: locations(onLevel: level).first!)
            }
        }
        return result
    }

    // recursive depth-first function
    private func search(from node: Triple<Int,Int,Int>) {
        result.append(node)
        let neighbors = locations(nextTo: node)
        for n in neighbors {
            if !result.contains(n) && nodes.contains(n) {
                search(from: n)
            }
        }
        return
    }

    private func startNode() -> Triple<Int,Int,Int> {
        let zero = Triple(0,0,0)
        if nodes.contains(zero) {
            return zero
        }
        return locations(onLevel: 0).first!
    }

    private func locations(onLevel level: Int) -> [Triple<Int,Int,Int>] {
        var locations : [Triple<Int,Int,Int>] = []
        for n in nodes {
            if n.values.1 == level {
                locations.append(n)
            }
        }
        return locations
    }

    private func locations(nextTo location: Triple<Int,Int,Int>) -> [Triple<Int,Int,Int>] {
        let (x, y, z) = location.values
        return [
            Triple(x+1,y,z),
            Triple(x-1,y,z),
            Triple(x,y,z+1),
            Triple(x,y,z-1)
        ]
    }

    private func notFoundNode(onLevel level: Int) -> Triple<Int,Int,Int>? {
        for n in locations(onLevel: level) {
            if !result.contains(n) {
                return n
            }
        }
        return nil
    }
}
