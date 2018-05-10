//
//  MarbleRunListInteractor.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListInteractor : MarbleRunListInteractorProtocol {
    
    func retrieveMarbleRuns(_ callback: ([MarbleRun]) -> Void) {
        var runs : [MarbleRun] = []
        for _ in 0...12 {
            runs.append(MarbleRun())
        }
        callback(runs)
    }
}
