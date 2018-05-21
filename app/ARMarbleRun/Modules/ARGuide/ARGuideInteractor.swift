//
//  ARGuideInteractor.swift
//  ARMarbleRun
//

import Foundation

class ARGuideInteractor : ARGuideInteractorInputProtocol {
    var marbleRun: MarbleRunEntity?
    var builder : MarbleRunGuide?
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
            builder = MarbleRunGuide(run.elements)
            builder?.generate()
            output?.setAllElements(to: .faded)
            if let current = builder?.current() {
                output?.set(elementAt: current, to: .highlighted)
            }
        }
        print("restart")
    }
    
    func nextStep() {
        if builder == nil {
            resetGuide()
        } else {
            if let current = builder?.current() {
                output?.set(elementAt: current, to: .faded)
            }
            if let next = builder?.next() {
                output?.set(elementAt: next, to: .highlighted)
            }
        }
        print("next")
    }
    
    func previousStep() {
        if builder == nil {
            resetGuide()
        } else {
            if let current = builder?.current() {
                output?.set(elementAt: current, to: .faded)
            }
            if let next = builder?.previous() {
                output?.set(elementAt: next, to: .highlighted)
            }
        }
        print("previous")
    }
}
