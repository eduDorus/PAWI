//
//  MarbleRunListInteractor.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListInteractor : MarbleRunListInteractorProtocol {
    
    func retrieveMarbleRuns(_ callback: ([MarbleRunEntity]) -> Void) {
        var runs : [MarbleRunEntity] = []
        for i in 0...12 {
            runs.append(MarbleRunEntity(name: "Test\(i)"))
        }
        MarbleRunDataManager().persist(runs)

        if let runs = MarbleRunDataManager().retrieveMarbleRunList() {
            callback(runs)
        }
        
    }
}
