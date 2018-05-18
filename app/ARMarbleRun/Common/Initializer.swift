//
//  Initializer.swift
//  ARMarbleRun
//
//  Created by Lucas Schnüriger on 18.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class Initializer {
    static func makeDefaultRuns() {
        let run = MarbleRunEntity(name: "Pawi Run")
        let elements = [
            ElementEntity(id: 10, location: Triple(1,0,0)),
            ElementEntity(id: 7, location: Triple(0,1,0)),
            ElementEntity(id: 3, location: Triple(0,0,1)),
            ElementEntity(id: 4, location: Triple(1,0,1)),
            ElementEntity(id: 4, location: Triple(-1,0,0)),
            ElementEntity(id: 12, location: Triple(0,0,0))
        ]
        
        run.elements.append(contentsOf: elements)
        
        MarbleRunDataManager().persist(run)
    }
}
