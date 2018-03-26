//
//  BasicCube.swift
//  SceneKit Kugelbahn Prototype
//
//  Created by Lucas Schnüriger on 26.03.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class BasicCube: SCNNode {
    open let sidelength : CGFloat = 0.05
    let edgeWidth : CGFloat = 0.001
    
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
        boxGeometry.firstMaterial?.transparency = 0.2
        geometry = boxGeometry
        let edgeBox = SCNBox(width: sidelength, height: sidelength, length: sidelength, chamferRadius: 0.0)
        edgeBox.firstMaterial?.shaderModifiers = [SCNShaderModifierEntryPoint.surface: sm]
        edgeBox.firstMaterial?.isDoubleSided = true
        addChildNode(SCNNode(geometry: edgeBox))
        set(color: UIColor.red)
        castsShadow = true
    }
    
    convenience init(withColor color: UIColor) {
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
