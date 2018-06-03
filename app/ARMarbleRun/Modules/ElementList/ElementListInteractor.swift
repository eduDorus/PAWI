//
//  ElementListInteractor.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementListInteractor : ElementListInteractorProtocol {

    func getElements() -> [ElementEntity] {
        var elements = [ElementEntity]()
        guard let cubes = SCNScene(named: "art.scnassets/cuboro-set.scn")?.rootNode else {
            return elements
        }
        for cube in cubes.childNodes[0].childNodes {
            if let name = cube.name, let type = Int(name.split(separator: "_")[1]) {
                elements.append(ElementEntity(type: type, location: Triple(0,0,0)))
            }
        }
        return elements
    }
}
