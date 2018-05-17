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
    
    func resetGuide() {
        print("restart")
    }
    
    func nextStep() {
        print("next")
    }
    
    func previousStep() {
        print("previous")
    }
}
