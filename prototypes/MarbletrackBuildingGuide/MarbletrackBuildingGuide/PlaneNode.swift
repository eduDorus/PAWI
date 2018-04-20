//
//  Plane.swift
//  MarbletrackBuildingGuide
//
//  Created by Lucas Schnüriger on 17.04.18.
//  Based heavily on https://stackoverflow.com/a/47364341
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class PlaneNode: SCNNode {
    
    init(planeAnchor: ARPlaneAnchor) {
        super.init()
        let planeGeometry = SCNPlane(width:CGFloat(planeAnchor.extent.x), height:CGFloat(planeAnchor.extent.z))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/checkerboard.png")
        material.transparent.contents = UIImage(named: "art.scnassets/checkerboard-alpha.png")
        material.transparencyMode = .rgbZero
        // set repeat mode in both direction otherwise the patern is stretched!
        material.diffuse.wrapS = .repeat
        material.diffuse.wrapT = .repeat
        material.transparent.wrapS = .repeat
        material.transparent.wrapT = .repeat
        // apply material
        planeGeometry.materials = [material];
        // make a node for it
        self.geometry = planeGeometry
        // Planes in SceneKit are vertical by default so we need to rotate
        // 90 degrees to match planes in ARKit
        transform =  SCNMatrix4MakeRotation(-Float.pi / 2.0, 1.0, 0.0, 0.0);
        // set the things, that also need to be set on update
        update(planeAnchor: planeAnchor)
    }
    
    func update(planeAnchor: ARPlaneAnchor) {
        guard let planeGeometry = geometry as? SCNPlane else {
            fatalError("update(planeAnchor: ARPlaneAnchor) called on node that has no SCNPlane geometry")
        }
        // update the size
        planeGeometry.width = CGFloat(planeAnchor.extent.x)
        planeGeometry.height = CGFloat(planeAnchor.extent.z)
        // and material properties
        // the scale gives the number of times the image is repeated
        // ARKit gives the width and height in meters, in this case we want to repeat
        // the pattern each 2cm = 0.02m so we divide the width/height to find the number of patterns
        let scaleX = (Float(planeGeometry.width)  / 0.02)
        let scaleY = (Float(planeGeometry.height) / 0.02)
        // we then apply the scaling
        planeGeometry.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(scaleX, scaleY, 0)
        planeGeometry.firstMaterial?.transparent.contentsTransform = SCNMatrix4MakeScale(scaleX, scaleY, 0)
        // Move the plane to the position reported by ARKit
        position.x = planeAnchor.center.x
        position.y = 0
        position.z = planeAnchor.center.z
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
