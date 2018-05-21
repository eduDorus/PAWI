//
//  ARGuideInteractor.swift
//  ARMarbleRun
//

import Foundation

class ARGuideInteractor : ARGuideInteractorInputProtocol {
    var marbleRun: MarbleRunEntity?
    var builder : MarbleRunBuilder?
    weak var output: ARGuideInteractorOutputProtocol?
    
    func retrieveMarbleRun() -> [ElementEntity] {
        //MarbleRunDataManager().retrieveMarbleRun(name: "TestingMe")
        if marbleRun != nil {
            return marbleRun!.elements
        } else {
            return []
        }
    }
    
    func resetGuide() {
        if let run = marbleRun {
            builder = MarbleRunBuilder(run.elements)
            builder?.start()
        }
        print("restart")
    }
    
    func nextStep() {
        if builder == nil {
            resetGuide()
        } else {
            builder!.step()
        }
        print("next")
    }
    
    func previousStep() {
        print("previous")
    }
}
