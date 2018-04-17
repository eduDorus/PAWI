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
    var queue : [BasicCube] = []
    
    init(_ map: TrackMap<BasicCube>) {
        self.map = map
    }
    
    func start() {
        map.forEach { (key, element) in
            element.hide()
        }
        if let startElement = map.getElement(at: Triple(0,0,0)) {
            queue.append(startElement)
        }
    }
    
    func step() {
        deactivateCurrentElement()
        setNewCurrentElement()
        activateCurrentElement()
        addNeighborsToQueue()
        if queue.isEmpty {
            startNextLevel()
        }
    }
    
    private func activateCurrentElement() {
        if currentElement != nil {
            currentElement!.set(state: .active)
        }
    }
    
    private func deactivateCurrentElement() {
        if currentElement != nil {
            currentElement!.set(state: .built)
        }
    }
    
    private func setNewCurrentElement() {
        currentElement = queue.popLast()
    }
    
    private func addNeighborsToQueue() {
        if currentElement != nil {
            let currentLocation = map.getKeys(forElement: currentElement!).first!
            let neighbors = map.getHorizontalNeighbors(ofElement: currentLocation)
            neighbors.forEach { (element) in
                if element.value.getState() == .normal {
                    appendElement(element.value)
                }
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
        queue.append(element)
    }
    
}
