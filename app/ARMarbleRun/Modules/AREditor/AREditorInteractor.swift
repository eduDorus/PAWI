//
//  AREditorInteractor.swift
//  ARMarbleRun
//

import Foundation


class AREditorInteractor : AREditorInteractorProtocol {
    var marbleRun: MarbleRunEntity?

    func retrieveMarbleRun() -> [ElementEntity] {
        if marbleRun != nil {
            return marbleRun!.elements
        } else {
            return []
        }
    }

    func getPossibleLocations() -> Set<Triple<Int, Int, Int>> {
        var result = Set<Triple<Int, Int, Int>>()

        result.formUnion(possibleBaselevelLocations())
        result.formUnion(possibleTopLocations())

        return result
    }

    private func possibleBaselevelLocations() -> Set<Triple<Int, Int, Int>> {
        var result = Set<Triple<Int, Int, Int>>()
        if let baseElementsLocations = getAllBaseElements(except: nil) {
            for pos in baseElementsLocations {
                let possibleNeighbors = neighborLocations(from: pos)
                for pn in possibleNeighbors {
                    if marbleRun!.getElement(at: pn) == nil {
                        result.insert(pn)
                    }
                }
            }
        }
        return result
    }

    private func possibleTopLocations() -> Set<Triple<Int, Int, Int>> {
        var result = Set<Triple<Int, Int, Int>>()
        for e in marbleRun!.elements {
            if !hasElementOnTop(of: e.location) {
                let (x,y,z) = e.location.values
                result.insert(Triple(x, y+1, z))
            }
        }
        return result
    }

    func buildElement(element: ElementEntity) {
        marbleRun!.elements.append(element)
    }

    func removeElement(at location: Triple<Int, Int, Int>) -> Bool {
        if hasElementOnTop(of: location) {
            return false
        }
        if (location.values.1 == 0 && !checkRemoveElement(at: location)) {
            return false
        }
        marbleRun!.removeElement(at: location)
        return true
    }

    private func hasElementOnTop(of location: Triple<Int, Int, Int>) -> Bool {
        for element in marbleRun!.elements {
            let (x,y,z) = location.values
            if element.location == Triple(x, y+1, z) {
                return true
            }
        }
        return false
    }

    func checkRemoveElement(at location: Triple<Int, Int, Int>) -> Bool {
        let elementLocations = getAllBaseElements(except: location)
        // make sure there is always at least one cube
        if elementLocations?.count == 0 { return false }

        var visited : [Triple<Int, Int, Int>] = []
        var next: [Triple<Int, Int, Int>] = []
        next.append((elementLocations?.first)!)

        while next.count != 0 {
            let nextElement = next.first
            let p: [Triple<Int, Int, Int>] = neighborLocations(from: nextElement)

            for e in p {
                if ((elementLocations?.contains(e))! && !visited.contains(e)) && !next.contains(e) {
                    next.append(e)
                }
            }
            visited.append(nextElement!)
            next.removeFirst()
        }
        return visited.count == elementLocations?.count
    }

    private func neighborLocations(from location: Triple<Int, Int, Int>?) -> [Triple<Int, Int, Int>] {
        let (x, y, z) = (location?.values)!
        return [
            Triple(x+1,y,z),
            Triple(x-1,y,z),
            Triple(x,y,z+1),
            Triple(x,y,z-1)
        ]
    }

    private func getAllBaseElements(except location: Triple<Int, Int, Int>?) -> [Triple<Int, Int, Int>]? {
        let elementLocations = marbleRun?.elements.filter({ (e) -> Bool in
                e.location.values.1 == 0 && e.location != location
            })
            .map({ (e) -> Triple<Int, Int, Int> in
                e.location
            })
        return elementLocations
    }

    func rotateElement(at location: Triple<Int, Int, Int>, rotate: (Float, Float, Float, Float)) {
        if let element = marbleRun?.getElement(at: location) {
            element.set(rotation: rotate)
        }
    }

    func persist() {
        MarbleRunDataManager.persist(marbleRun!)
    }
}
