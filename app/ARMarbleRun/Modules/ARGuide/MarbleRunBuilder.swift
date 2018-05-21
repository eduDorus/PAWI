//
//  MarbleRunBuilder.swift
//  ARMarbleRun
//
//  Created by Lucas Schnüriger on 21.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class MarbleRunBuilder {
    var currentLevel = 0
    var currentElement : ElementEntity?
    let elements : [ElementEntity]
    var stack : [ElementEntity] = []
    var finished = false
    
    init(_ elements: [ElementEntity]) {
        self.elements = elements
    }
    
    func start() {
        elements.forEach { (e) in
            e.set(state: .hidden)
            if e.location == Triple(0,0,0) {
                stack.append(e)
            }
        }
    }
    
    func stop() {
        currentLevel = 0
        currentElement = nil
        stack = []
        finished = true
        elements.forEach { (element) in
            element.set(state: .normal)
        }
    }
    
    func step() -> Bool {
        if stack.isEmpty {
            stop()
            return false
        }
        deactivateCurrentElement()
        setNewCurrentElement()
        activateCurrentElement()
        addNeighborsToQueue()
        if stack.isEmpty { startNextLevel() }
        return true
    }
    
    private func activateCurrentElement() {
        guard currentElement != nil else { return }
        currentElement!.set(state: .highlighted)
    }
    
    private func deactivateCurrentElement() {
        guard currentElement != nil else { return }
        currentElement!.set(state: .faded)
    }
    
    private func setNewCurrentElement() {
        currentElement = stack.popLast()
    }
    
    private func addNeighborsToQueue() {
        guard currentElement != nil else { return }
        if let (x,y,z) = currentElement?.location.values {
            var possibleNeighbors : [Triple<Int,Int,Int>] = []
            possibleNeighbors.append(Triple(x+1, y, z))
            possibleNeighbors.append(Triple(x-1, y, z))
            possibleNeighbors.append(Triple(x, y, z+1))
            possibleNeighbors.append(Triple(x, y, z-1))

            elements.forEach { (e) in
                if possibleNeighbors.contains(e.location) && e.getState() == .normal {
                    appendElement(e)
                }
            }
        }
    }
    
    private func startNextLevel() {
        currentLevel += 1
        elements.forEach { (e) in
            if e.location.values.1 == currentLevel {
                appendElement(e)
                return
            }
        }
    }
    
    private func appendElement(_ element: ElementEntity) {
        element.set(state: .normal)
        stack.append(element)
    }
    
}
