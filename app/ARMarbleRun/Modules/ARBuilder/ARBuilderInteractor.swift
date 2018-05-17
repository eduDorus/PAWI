//
//  ARBuilderInteractor.swift
//  ARMarbleRun
//

import Foundation

class ARBuilderInteractor : ARBuilderInteractorProtocol {
    var marbleRun: MarbleRunEntity?
    
    func retrieveMarbleRun() -> [ElementEntity] {
        //MarbleRunDataManager().retrieveMarbleRun(name: "TestingMe")
        if marbleRun != nil {
            return marbleRun!.elements
        } else {
            return []
        }
    }
    
    func nextBuildingStep() {
        print("next")
    }
    
    func previousBuildingStep() {
        print("previous")
    }
}
