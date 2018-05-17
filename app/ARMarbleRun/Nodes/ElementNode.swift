//
//  ElementNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementNode : SCNNode, ElementProtocol {
    var state = ElementState.normal
    let sidelength: CGFloat = 0.05
    
    func set(state: ElementState) {
        self.state = state
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    func set(position vector: SCNVector3) {
        let pos = SCNVector3(CGFloat(vector.x) * self.sidelength, CGFloat(vector.y) * self.sidelength, CGFloat(vector.z) * self.sidelength)
        self.position = pos
    }
    
    func getPosition() -> SCNVector3 {
        return self.position
    }
}
