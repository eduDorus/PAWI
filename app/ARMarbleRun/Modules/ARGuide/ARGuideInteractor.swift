//
//  ARGuideInteractor.swift
//  ARMarbleRun
//

import Foundation

class ARGuideInteractor : ARGuideInteractorInputProtocol {
    var marbleRun: MarbleRunEntity?
    var guide: [Triple<Int,Int,Int>] = []
    var currentPointer = 0
    let pastElementState = ElementState.faded
    let futureElementState = ElementState.hidden
    weak var output: ARGuideInteractorOutputProtocol?

    func retrieveMarbleRun() -> [ElementEntity] {
        if marbleRun != nil {
            return marbleRun!.elements
        } else {
            return []
        }
    }

    func resetGuide() {
        if let run = marbleRun {
            var pos : [Triple<Int,Int,Int>] = []
            for e in run.elements {
                pos.append(e.location)
            }
            let builder = DepthFirstSort(pos)
            guide = builder.generate()
            output?.setAllElements(to: futureElementState)
            output?.set(elementAt: guide[0], to: .highlighted)
        }
        checkGuideBoundaries()
    }

    func nextStep() {
        if hasNext() {
            setCurrent(to: pastElementState)
            currentPointer += 1
            setCurrent(to: .highlighted)
            checkGuideBoundaries()
        }
    }

    func previousStep() {
        if hasPrevious() {
            setCurrent(to: futureElementState)
            currentPointer -= 1
            setCurrent(to: .highlighted)
            checkGuideBoundaries()
        }
    }

    private func hasNext() -> Bool {
        return currentPointer+1 < guide.endIndex
    }

    private func hasPrevious() -> Bool {
        return currentPointer-1 >= guide.startIndex
    }

    private func setCurrent(to state: ElementState) {
        output?.set(elementAt: guide[currentPointer], to: state)
    }

    private func checkGuideBoundaries() {
        output?.buttons(
            previousEnabled: hasPrevious(),
            nextEnabled: hasNext()
        )
    }
}
