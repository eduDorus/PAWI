//
//  MarbleRunNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class MarbleRunNode : SCNNode {
    let map = MarbleRunMap<ElementProtocol>()
    
    override init() {
        super.init()
        let element = addElement(x: 0, y: 0, z: 0, type: 0)
        element.set(state: .highlighted)
        element.name = "element"
        //loadTrack(number: currentTrack)
    }
    
    // Positions a new BoundingBox at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    @discardableResult
    func addElement(x: Int, y: Int, z: Int, type: Int) -> ElementNode {
        let element = ElementNode()
        let pos = SCNVector3(CGFloat(x) * element.sidelength, CGFloat(y) * element.sidelength, CGFloat(z) * element.sidelength)
        element.set(position: pos)
        addChildNode(element)
        map.add(element: element, atLocation: Triple(x, y, z))
        return element
    }
    
    // Positions a new BoundingBox at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    @discardableResult
    func addBoundingBox(x: Int, y: Int, z: Int) -> BoundingBoxNode {
        let boundingBox = BoundingBoxNode()
        let pos = SCNVector3(CGFloat(x) * element.sidelength, CGFloat(y) * element.sidelength, CGFloat(z) * element.sidelength)
        boundingBox.set(position: pos)
        addChildNode(boundingBox)
        map.add(element: boundingBox, atLocation: Triple(x, y, z))
        return boundingBox
    }
    
    func removeElement(element: ElementNode) {
        map.removeElement(element: element)
        element.remove()
    }
    
    func set(position vector: SCNVector3) {
        position = vector
    }
    
    func set(rotation vector: SCNVector3) {
        eulerAngles = vector
    }
    
    // Makes the track always facing the camera by rotating around the Y axis
    func constraintToCamera() {
        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y
        constraints = [constraint]
    }
    
    func removeConstraints() {
        constraints = []
    }
    
    // remove all BoundingBox nodes from the track
    private func removeBoundingBoxes() {
        map.forEach { (position, element) in
            if element.name != "boundingBox" {
                element.remove()
                map.removeElement(at: position)
            }
        }
    }
    
    // remove all BoundingBox nodes from the track
    private func clearTrack() {
        map.forEach { (position, cube) in
            if cube.name != "boundingBox" {
                cube.remove()
                map.removeElement(at: position)
            }
        }
    }
    
    private func hideTrack() {
        map.forEach { (_, element) in
            element.hide()
        }
    }
    
    
    func getMap() -> MarbleRunMap<ElementNode> {
        return map
    }
    
    
    private func clearHighlights() {
        map.forEach { (_, element) in
            element.set(state: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
