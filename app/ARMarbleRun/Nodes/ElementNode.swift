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
    
    public func remove() {
        // apparently it's not enough for the node to be removed itself, all its child nodes have to be removed as well
        // maybe there is another way, a different way to build these node so to make it work simpler
        enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        removeFromParentNode()
    }
}
