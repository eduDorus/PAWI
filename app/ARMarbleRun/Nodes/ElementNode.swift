//
//  ElementNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementNode : SCNNode, ElementProtocol {
    var state = ElementState.normal
    var type = 12
    var location = Triple(0, 0, 0)
    let sidelength: CGFloat = 0.05
    let normalColor = UIColor(red: 0.98, green: 0.82, blue: 0.65, alpha: 1)
    
    init(type: Int, location: Triple<Int, Int, Int>) {
        super.init()
        self.type = type
        self.set(location: location)
        self.set(state: .normal)
        setGeometry()
    }
    
    func set(state: ElementState) {
        self.state = state
        switch self.state {
        case .faded:
            set(color: UIColor.white)
            set(transparency: 0.3)
        case .normal:
            set(color: normalColor)
            set(transparency: 1)
        case .highlighted:
            set(color: UIColor.red)
            set(transparency: 0.5)
        case .hidden:
            set(transparency: 0)
        }
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    func set(location: Triple<Int, Int, Int>) {
        self.location = location
        updatePosition()
    }
    
    func set(color: UIColor) {
        self.geometry?.firstMaterial?.diffuse.contents = color
        self.geometry?.firstMaterial?.specular.contents = color
        enumerateChildNodes { (node, _) in
            node.geometry?.firstMaterial?.diffuse.contents = color
            node.geometry?.firstMaterial?.specular.contents = color
        }
    }
    
    func set(transparency: CGFloat) {
        self.geometry?.firstMaterial?.transparency = transparency
        enumerateChildNodes { (node, _) in
            node.geometry?.firstMaterial?.transparency = transparency
        }
    }
    
    func getLocation() -> Triple<Int, Int, Int> {
        return self.location
    }
    
    func remove() {
        // apparently it's not enough for the node to be removed itself, all its child nodes have to be removed as well
        // maybe there is another way, a different way to build these node so to make it work simpler
        enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        removeFromParentNode()
    }
    
    private func updatePosition() {
        let (x,y,z) = self.location.values
        self.position = SCNVector3(
            CGFloat(x) * self.sidelength - (self.sidelength/2),
            CGFloat(y) * self.sidelength,
            CGFloat(z) * self.sidelength + (self.sidelength/2)
        )
    }
    
    private func setGeometry() {
        if let cubes = SCNScene(named: "art.scnassets/cuboro-set.scn")?.rootNode {
            if let cube = cubes.childNodes[0].childNodes.filter({ $0.name == "instance_\(type)" }).first {
                self.geometry = cube.geometry
                self.rotation = cube.rotation
                self.scale = SCNVector3(x: 0.00127, y: 0.00127, z: 0.00127)
                for child in cube.childNodes {
                    addChildNode(child)
                }
            }
        } else {
            fatalError("cube \(type) has not been found")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
