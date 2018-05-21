//
//  ElementSelectInteractor.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementSelectInteractor : ElementSelectInteractorProtocol {

    func getElements() -> [ElementEntity] {
        var elements = [ElementEntity]()
        if let cubes = SCNScene(named: "art.scnassets/cuboro-set.scn")?.rootNode {
            for cube in cubes.childNodes[0].childNodes {
                if let name = cube.name {
                    let r = name.split(separator: "_")
                    if let type = Int(r[1]) {
                        elements.append(ElementEntity.init(type: type, location: Triple(0,0,0)))
                    }
                }
            }
        }
        return elements
    }
}
