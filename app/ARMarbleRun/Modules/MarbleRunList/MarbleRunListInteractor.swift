//
//  MarbleRunListInteractor.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListInteractor : MarbleRunListInteractorProtocol {
    
    func retrieveMarbleRuns(_ callback: ([MarbleRun]) -> Void) {
        var runs : [MarbleRun] = []
        for i in 0...12 {
            runs.append(MarbleRun(name: "Test\(i)"))
        }
        MarbleRunDataManager().persist(runs)

        if let runs = MarbleRunDataManager().retrieveMarbleRunList() {
            callback(runs)
        }
        
    }
}
