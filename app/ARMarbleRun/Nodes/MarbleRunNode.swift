//
//  MarbleRunNode.swift
//  ARMarbleRun
//

import Foundation
import SceneKit

class MarbleRunNode : SCNNode {
    
    var isLocked = false
    
    override init() {
        super.init()
    }
    
    // MARK: - Setters
    
    func set(position vector: SCNVector3) {
        position = vector
    }
    
    func set(rotation vector: SCNVector3) {
        eulerAngles = vector
    }
    
    // MARK: - Logic
    
    // Positions a new Element at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    func addElement(type: Int, at location: Triple<Int, Int, Int>, with rotation: SCNVector4) {
        let element = ElementNode(type: type, at: location, with: rotation)
        addChildNode(element)
    }
    
    // MARK: - Elements
    
    func getElement(at location: Triple<Int, Int, Int>) -> ElementNode? {
        var elementNode: ElementNode?
        enumerateChildNodes { (node, _) in
            if let element = node as? ElementNode, element.location == location {
                elementNode = element
            }
        }
        return elementNode
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        enumerateChildNodes { (node, _) in
            if let element = node as? ElementNode, element.location == location {
                element.remove()
            }
        }
    }
    
    // MARK: - Bounding Box
    
    // Positions a new BoudingBox at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    func addBoundingBox(location: Triple<Int, Int, Int>) {
        let boundingBox = BoundingBoxNode(location: location)
        addChildNode(boundingBox)
    }
    
    // remove all BoundingBox nodes from the track
    func removeBoundingBoxes() {
        enumerateChildNodes { (node, _) in
            if let box = node as? BoundingBoxNode {
                box.remove()
            }
        }
    }
    
    // Makes the track always facing the camera by rotating around the Y axis
    func constraintToCamera() {
        let constraint = SCNBillboardConstraint()
        constraint.freeAxes = SCNBillboardAxis.Y
        constraints = [constraint]
        isLocked = true
    }
    
    func removeConstraints() {
        constraints = []
        isLocked = false
    }
    
    func toggleConstraints() {
        if isLocked {
            removeConstraints()
        } else {
            constraintToCamera()
        }
    }
    
    
    
    func setRun(to state: ElementState) {
        enumerateChildNodes{ (node, _) in
            if let element = node as? ElementProtocol {
                element.set(state: state)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
