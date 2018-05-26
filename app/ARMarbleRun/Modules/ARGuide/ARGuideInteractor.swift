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
        guard builder != nil else {
            resetGuide()
            return
        }
        setCurrent(to: .faded)
        highlight(element: builder?.next())
        checkGuideBoundaries()
    }

    func previousStep() {
        guard builder != nil else {
            resetGuide()
            return
        }
        setCurrent(to: .hidden)
        highlight(element: builder?.previous())
        checkGuideBoundaries()
    }

    private func setCurrent(to state: ElementState) {
        if let current = builder!.current() {
            output?.set(elementAt: current, to: state)
        }
    }

    private func highlight(element: Triple<Int,Int,Int>?) {
        if let pos = element {
            output?.set(elementAt: pos, to: .highlighted)
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
