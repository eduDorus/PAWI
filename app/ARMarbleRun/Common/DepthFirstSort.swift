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
                search(from: positions(onLevel: level).first!)
            }
        }
        return result
    }

    // recursive depth-first function
    private func search(from node: Triple<Int,Int,Int>) {
        result.append(node)
        let neighbors = positions(nextTo: node)
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
        return positions(onLevel: 0).first!
    }

    private func positions(onLevel level: Int) -> [Triple<Int,Int,Int>] {
        var positions : [Triple<Int,Int,Int>] = []
        for n in nodes {
            if n.values.1 == level {
                positions.append(n)
            }
        }
        return positions
    }

    private func positions(nextTo position: Triple<Int,Int,Int>) -> [Triple<Int,Int,Int>] {
        let (x, y, z) = position.values
        return [
            Triple(x+1,y,z),
            Triple(x-1,y,z),
            Triple(x,y,z+1),
            Triple(x,y,z-1)
        ]
    }

    private func notFoundNode(onLevel level: Int) -> Triple<Int,Int,Int>? {
        for n in positions(onLevel: level) {
            if !result.contains(n) {
                return n
            }
        }
        return nil
    }
}
