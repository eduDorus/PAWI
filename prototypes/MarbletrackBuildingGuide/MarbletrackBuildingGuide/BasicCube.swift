//
//  BasicCube.swift
//  SceneKit Kugelbahn Prototype
//
//  Created by Lucas Schnüriger on 12.04.2018
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class BasicCube: SCNNode {
    open let sidelength : CGFloat = 0.05
    private let edgeWidth : CGFloat = 0.001
    private let transparency : CGFloat = 0.3
    
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
    
    convenience init(with color: UIColor) {
        self.init()
        set(color: color)
    }
    
    public func set(color: UIColor) {
        self.geometry?.firstMaterial?.diffuse.contents = color
        self.geometry?.firstMaterial?.specular.contents = color
        for child in self.childNodes {
            child.geometry?.firstMaterial?.diffuse.contents = color
            child.geometry?.firstMaterial?.emission.contents = color
        }
    }
    
    public func set(position vector: SCNVector3) {
        position = vector
        position.y = vector.y + Float(sidelength / 2)
    }
    
    public func set(rotation vector: SCNVector3) {
        eulerAngles = vector
    }
    
    public func remove() {
        // apparently it's not enough for the node to be removed itself, all its child nodes have to be removed as well
        // maybe there is another way, a different way to build these node so to make it work simpler
        enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        removeFromParentNode()
    }
    
    func hide() {
        self.geometry?.firstMaterial?.transparency = 0.1
        enumerateChildNodes { (node, _) in
            node.geometry?.firstMaterial?.transparency = 0.1
        }
    }
    
    func show() {
        self.geometry?.firstMaterial?.transparency = transparency
        enumerateChildNodes { (node, _) in
            node.geometry?.firstMaterial?.transparency = 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
