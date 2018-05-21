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
                if marbleRun!.getElement(at: Triple(x, y + 1, z)) == nil {
                    result.insert(Triple(x,y + 1,z))
                }
            }
            return result
        }
        return result
    }
    
    func buildElement(type: Int, at location: Triple<Int, Int, Int>) {
        let element = ElementEntity.init(type: type, location: location)
        marbleRun!.elements.append(element)
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) -> Bool{
        // TODO: Check if remove is valid
        marbleRun!.removeElement(at: location)
        return true
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
