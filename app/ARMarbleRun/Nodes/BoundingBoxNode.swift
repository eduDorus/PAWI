//
//  BoundingBox.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class BoundingBoxNode: SCNNode {
    open let sidelength : CGFloat = 0.05
    private let edgeWidth : CGFloat = 0.001
    private let transparency : CGFloat = 0.3
    private var location = Triple(0, 0, 0)
    private var state = BoundingBoxState.planned
    
    
    init(location: Triple<Int, Int, Int>) {
        super.init()
        self.set(location: location)
    }
    
    override public init() {
        super.init()
        // this shader makes the (edge-)cube only show the lines on the sides and no diagonals
        let sm = "float u = _surface.diffuseTexcoord.x; \n" +
            "float v = _surface.diffuseTexcoord.y; \n" +
            "int u100 = int(u * 100); \n" +
            "int v100 = int(v * 100); \n" +
            "if (u100 % 99 == 0 || v100 % 99 == 0) { \n" +
            "  // do nothing \n" +
            "} else { \n" +
            "    discard_fragment(); \n" +
        "} \n"
        
        let boxGeometry = SCNBox(width: sidelength, height: sidelength, length: sidelength, chamferRadius: 0.001)
        boxGeometry.firstMaterial?.transparency = transparency
        geometry = boxGeometry
        let edgeBox = SCNBox(width: sidelength, height: sidelength, length: sidelength, chamferRadius: 0.0)
        edgeBox.firstMaterial?.shaderModifiers = [SCNShaderModifierEntryPoint.surface: sm]
        edgeBox.firstMaterial?.isDoubleSided = true
        addChildNode(SCNNode(geometry: edgeBox))
        set(color: UIColor.white)
        castsShadow = true
    }
    
    func set(state: BoundingBoxState) {
        self.state = state
        switch state {
        case .planned:
            set(color: UIColor.white)
        case .active:
            set(color: UIColor.red)
        case .built:
            set(color: UIColor.white)
        }
    }
    
    func getState() -> BoundingBoxState {
        return state
    }
    
    func set(location: Triple<Int, Int, Int>) {
        self.location = location
        self.position = SCNVector3(CGFloat(self.location.values.0) * self.sidelength, CGFloat(self.location.values.1) * self.sidelength, CGFloat(self.location.values.2) * self.sidelength)
    }
    
    func getLocation() -> Triple<Int, Int, Int> {
        return self.location
    }
    
    func remove() {
        // apparently it's not enough for the node to be removed itself, all its child nodes have to be removed as well
        // maybe there is another way, a different way to build these node so to make it work simpler
        enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        removeFromParentNode()
    }
    
    private func set(color: UIColor) {
        self.geometry?.firstMaterial?.diffuse.contents = color
        self.geometry?.firstMaterial?.specular.contents = color
        for child in self.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = color
            child.geometry?.firstMaterial?.emission.contents = color
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum BoundingBoxState {
    case planned
    case active
    case built
}
