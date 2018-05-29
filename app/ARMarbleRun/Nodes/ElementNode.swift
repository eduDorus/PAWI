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
    let sideLength: CGFloat = 0.05
    let normalColor = UIColor(red: 0.98, green: 0.82, blue: 0.65, alpha: 1)

    init(type: Int, location: Triple<Int, Int, Int>) {
        super.init()
        self.type = type
        setGeometry()
        set(location: location)
        set(state: .normal)
    }

    func set(state: ElementState) {
        self.state = state
        var color = normalColor
        var transparency : CGFloat = 1.0
        switch self.state {
        case .faded:
            color = UIColor.white
            transparency = 0.3
        case .normal:
            transparency = 1
        case .highlighted:
            color = UIColor.red
            transparency = 0.5
        case .hidden:
            transparency = 0
        }
        set(color: color)
        set(transparency: transparency)
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
            CGFloat(x) * self.sideLength,
            CGFloat(y) * self.sideLength + (self.sideLength/2),
            CGFloat(z) * self.sideLength
        )
    }

    private func setGeometry() {
        if let cube = getNodeFromAssets() {
            // scaling and translation necessary, b/c the 3d models are in inches(?) and have their origin at the bottom left front corner
            let scalingFactor = Float(sideLength) / cube.boundingBox.max.x
            let translation = Float(sideLength) / 2 / scalingFactor
            self.pivot = SCNMatrix4MakeTranslation(translation, translation, translation)
            self.geometry = cube.geometry
            self.rotation = cube.rotation
            self.scale = SCNVector3(x: scalingFactor, y: scalingFactor, z: scalingFactor)
            for child in cube.childNodes {
                addChildNode(child)
            }
        } else {
            fatalError("cube \(type) has not been found")
        }
    }

    private func getNodeFromAssets() -> SCNNode? {
        let cubes = SCNScene(named: "art.scnassets/cuboro-set.scn")?.rootNode
        let cube = cubes?.childNodes[0].childNodes.filter({ $0.name == "instance_\(type)" }).first
        return cube
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
