//
//  MarbleRunListInteractor.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListInteractor : MarbleRunListInteractorProtocol {
    
    func retrieveMarbleRuns(_ callback: ([MarbleRunEntity]) -> Void) {
        callback(MarbleRunDataManager.retrieveMarbleRunList())
    }
    
    func createNewMarbleRun(with name: String) -> MarbleRunEntity {
        let marbleRun = MarbleRunEntity(name: name)
        let baseElement = ElementEntity(type: 12, location: Triple(0,0,0))
        marbleRun.elements.append(baseElement)
        MarbleRunDataManager.persist(marbleRun)
        return marbleRun
    }
}
