//
//  AREditorInteractor.swift
//  ARMarbleRun
//

import Foundation


class AREditorInteractor : AREditorInteractorProtocol {
    let marbleRun: MarbleRunEntity
    
    init(with marbleRun: MarbleRunEntity) {
        self.marbleRun = marbleRun
    }
    
    func getPossiblePositions() -> Set<Triple<Int, Int, Int>> {
        var result = Set<Triple<Int, Int, Int>>()
        for element in marbleRun.elements {
            let (x, y, z) = element.location.values
            if marbleRun.getElement(at: Triple(x, y, z + 1)) == nil {
                result.insert(Triple(x,y,z + 1))
            }
            if marbleRun.getElement(at: Triple(x, y, z - 1)) == nil {
                result.insert(Triple(x,y,z - 1))
            }
            if marbleRun.getElement(at: Triple(x + 1, y, z )) == nil {
                result.insert(Triple(x + 1,y,z))
            }
            if marbleRun.getElement(at: Triple(x - 1, y, z)) == nil {
                result.insert(Triple(x - 1,y,z))
            }
            if marbleRun.getElement(at: Triple(x, y + 1, z)) == nil {
                result.insert(Triple(x,y + 1,z))
            }
        }
        return result
    }
    
    func buildElement(at location: Triple<Int, Int, Int>) {
        
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
    }
    
    func selectElement(at location: Triple<Int, Int, Int>) {
    }
    
    func rotateElement(to direction: RotationDirection) {
        
    }
    
    func persist() {
        
    }
}
