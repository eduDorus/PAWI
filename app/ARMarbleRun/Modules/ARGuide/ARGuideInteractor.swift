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
            output?.setAllElements(to: .hidden)
            if let current = builder?.current() {
                output?.set(elementAt: current, to: .highlighted)
            }
        }
        checkGuideBoundaries()
    }
    
    func nextStep() {
        if builder == nil {
            resetGuide()
        } else {
            if let current = builder!.current() {
                output?.set(elementAt: current, to: .faded)
            }
            if let next = builder!.next() {
                output?.set(elementAt: next, to: .highlighted)
            }
            checkGuideBoundaries()
        }
    }
    
    func previousStep() {
        if builder == nil {
            resetGuide()
        } else {
            if let current = builder!.current() {
                output?.set(elementAt: current, to: .hidden)
            }
            if let next = builder!.previous() {
                output?.set(elementAt: next, to: .highlighted)
            }
            checkGuideBoundaries()
        }
    }
    
    private func checkGuideBoundaries() {
        if builder != nil {
            output?.buttons(
                previousEnabled: builder!.hasPrevious(),
                nextEnabled: builder!.hasNext()
            )
        }
    }
}
