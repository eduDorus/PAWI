//
//  MarbleRunListInteractor.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListInteractor : MarbleRunListInteractorProtocol {
    
    func retrieveMarbleRuns(_ callback: ([MarbleRunEntity]) -> Void) {
        callback(MarbleRunDataManager().retrieveMarbleRunList())
    }
}
