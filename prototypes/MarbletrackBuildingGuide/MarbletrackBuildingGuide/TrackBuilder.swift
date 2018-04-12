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
    var currentStep = 0
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
            startElement.set(state: .planned)
            queue.append(startElement)
        }
        step()
    }
    
    func step() {
        if currentElement != nil {
            currentElement!.set(state: .built)
        }
        currentElement = queue.popLast()
        if currentElement != nil {
            currentElement!.set(state: .active)
            let currentLocation = map.getKeys(forElement: currentElement!).first!
            let neighbors = map.getHorizontalNeighbors(ofElement: currentLocation)
            neighbors.forEach { (element) in
                if element.value.getState() == BasicCubeState.planned {
                    queue.append(element.value)
                }
            }
            if queue.isEmpty {
                currentLevel += 1
                if let element = map.getElements(atLevel: currentLevel).first {
                    queue.append(element.value)
                }
            }
        }
    }
    
}
