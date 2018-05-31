//
//  Initializer.swift
//  ARMarbleRun
//

import Foundation

class Initializer {
    static func makeDefaultRuns() {
        let run = MarbleRunEntity(name: "Pawi Run")
        let elements = [
            ElementEntity(type: 10, location: Triple(1,0,0)),
            ElementEntity(type: 7, location: Triple(0,1,0)),
            ElementEntity(type: 3, location: Triple(0,0,1)),
            ElementEntity(type: 4, location: Triple(1,0,1)),
            ElementEntity(type: 4, location: Triple(-1,0,0)),
            ElementEntity(type: 12, location: Triple(0,0,0))
        ]
        
        run.elements.append(contentsOf: elements)
        
        MarbleRunDataManager.persist(run)        
    }
}
