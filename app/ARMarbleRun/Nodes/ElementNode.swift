//
//  ElementNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementNode : SCNNode, ElementProtocol {
    var state = ElementState.normal
    
    func set(state: ElementState) {
        self.state = state
    }
    
    func getState() -> ElementState {
        return self.state
    }
}
