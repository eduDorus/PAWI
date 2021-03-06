//
//  TrackBuilder.swift
//  MarbletrackBuildingGuide
//
//  Created by Lucas Schnüriger on 12.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class TrackBuilder {
    var currentLevel = 0
    var currentElement : BasicCube?
    let map : TrackMap<BasicCube>
    var stack : [BasicCube] = []
    var finished = false
    
    init(_ map: TrackMap<BasicCube>) {
        self.map = map
    }
    
    func start() {
        map.forEach { (key, element) in
            element.hide()
        }
        if let startElement = map.getElement(at: Triple(0,0,0)) {
            stack.append(startElement)
        }
    }
    
    func stop() {
        currentLevel = 0
        currentElement = nil
        stack = []
        finished = true
        map.forEach { (key, element) in
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
        currentElement!.set(state: .active)
    }
    
    private func deactivateCurrentElement() {
        guard currentElement != nil else { return }
        currentElement!.set(state: .built)
    }
    
    private func setNewCurrentElement() {
        currentElement = stack.popLast()
    }
    
    private func addNeighborsToQueue() {
        guard currentElement != nil else { return }
        let currentLocation = map.getKeys(forElement: currentElement!).first!
        let neighbors = map.getHorizontalNeighbors(ofElement: currentLocation)
        neighbors.forEach { (element) in
            if element.value.getState() == .normal {
                appendElement(element.value)
            }
        }
    }
    
    private func startNextLevel() {
        currentLevel += 1
        if let element = map.getElements(atLevel: currentLevel).first {
            appendElement(element.value)
        }
    }
    
    private func appendElement(_ element: BasicCube) {
        element.set(state: .planned)
        stack.append(element)
    }
    
}
