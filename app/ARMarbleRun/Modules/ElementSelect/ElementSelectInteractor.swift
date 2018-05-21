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
                    let r = name.index(name.startIndex, offsetBy: 9)..<name.endIndex
                    let result = name[r]
                    let type = Int(result)
                    elements.append(ElementEntity.)
                }
            }
        }
        return cubeIDs
    }
}
