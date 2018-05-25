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
    
    func getPossiblePositions() -> Set<Triple<Int, Int, Int>> {
        var result = Set<Triple<Int, Int, Int>>()
        if marbleRun != nil {
            for element in marbleRun!.elements {
                let (x, y, z) = element.location.values
                if (y == 0) {
                    if marbleRun!.getElement(at: Triple(x, y, z + 1)) == nil {
                        result.insert(Triple(x,y,z + 1))
                    }
                    if marbleRun!.getElement(at: Triple(x, y, z - 1)) == nil {
                        result.insert(Triple(x,y,z - 1))
                    }
                    if marbleRun!.getElement(at: Triple(x + 1, y, z )) == nil {
                        result.insert(Triple(x + 1,y,z))
                    }
                    if marbleRun!.getElement(at: Triple(x - 1, y, z)) == nil {
                        result.insert(Triple(x - 1,y,z))
                    }
                }
                if marbleRun!.getElement(at: Triple(x, y + 1, z)) == nil {
                    result.insert(Triple(x,y + 1,z))
                }
            }
            return result
        }
        return result
    }
    
    func buildElement(element: ElementEntity) {
        marbleRun!.elements.append(element)
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) -> Bool {
        if hasElementOnTop(at: location) {
            return false
        }
        if (location.values.1 == 0 && !checkRemoveElement(at: location)) {
            return false
        }
        marbleRun!.removeElement(at: location)
        return true
    }
    
    func hasElementOnTop(at location: Triple<Int, Int, Int>) -> Bool {
        var elements = marbleRun?.elements
        for element in elements! {
            if element.location.values.1 == location.values.1 + 1 {
                return false
            }
        }
        return true
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
            let p: [Triple<Int, Int, Int>] = neighborPositions(from: nextElement)

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

    private func neighborPositions(from position: Triple<Int, Int, Int>?) -> [Triple<Int, Int, Int>] {
        let (x, y, z) = (position?.values)!
        var p: [Triple<Int, Int, Int>] = []
        p.append(Triple(x+1,y,z))
        p.append(Triple(x-1,y,z))
        p.append(Triple(x,y,z+1))
        p.append(Triple(x,y,z-1))
        return p
    }

    private func getAllBaseElements(except location: Triple<Int, Int, Int>) -> [Triple<Int, Int, Int>]? {
        let elementLocations = marbleRun?.elements.filter({ (e) -> Bool in
            e.location.values.1 == 0 && e.location != location
        })
        .map({ (e) -> Triple<Int, Int, Int> in
            e.location
        })
        return elementLocations
    }

    func selectElement(at location: Triple<Int, Int, Int>) {
    }
    
    func rotateElement(to direction: RotationDirection) {
    }
    
    func persist() {
        let dataManager = MarbleRunDataManager.init()
        dataManager.persist(marbleRun!)
    }
}
