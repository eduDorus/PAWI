//
//  ElementNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class ElementNode : SCNNode, ElementProtocol {
    var state = ElementState.normal
    var id = 12
    var location = Triple(0, 0, 0)
    let sidelength: CGFloat = 0.05
    
    init(id: Int, location: Triple<Int, Int, Int>) {
        super.init()
        self.id = id
        self.set(location: location)
        setGeometry()
    }
    
    func set(state: ElementState) {
        self.state = state
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    func set(location: Triple<Int, Int, Int>) {
        self.location = location
        updatePosition()
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
    
    private func updatePosition() {
        self.position = SCNVector3(CGFloat(self.location.values.0) * self.sidelength, CGFloat(self.location.values.1) * self.sidelength + (self.sidelength/2), CGFloat(self.location.values.2) * self.sidelength)
    }
    
    private func setGeometry() {
        if let cubes = SCNScene(named: "art.scnassets/cuboro-set.scn")?.rootNode {
            if let cube = cubes.childNodes[0].childNodes.filter({ $0.name == "instance_\(id)" }).first {
                cube.position = SCNVector3(-0.025,-0.025,0.025)
                cube.scale = SCNVector3(x: 0.00127, y: 0.00127, z: 0.00127)
                addChildNode(cube)
            }
        } else {
            fatalError("cube \(id) has not been found")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
