//
//  MarbleTrack.swift
//  virtuelle-kugelbahn
//
//  Created by Lucas Schnüriger on 03.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class MarbleTrack: SCNNode {

    let tracks = [
        [(-1,0,0), (-1,0,-1), (0,0,-1), (-3,0,-2), (-2,0,-2), (-1,0,-2), (0,0,-2), (1,0,-2), (2,0,-2), (3,0,-2), (4,0,-2), (3,0,-1), (2,0,0), (3,0,0), (4,0,0), (3,0,1), (4,0,1), (-1,0,-3), (-1,0,-4),
        (0,1,0), (-1,1,0), (-1,1,-1), (0,1,-1), (-3,1,-2), (-2,1,-2), (-1,1,-2), (0,1,-2), (1,1,-2), (2,1,-2), (3,1,-2), (4,1,-2), (-1,1,-3), (-1,1,-4),
        (0,2,0), (-1,2,0), (-1,2,-1), (0,2,-1), (-3,2,-2), (-2,2,-2), (-1,2,-2), (0,2,-2), (-1,2,-3), (-1,2,-4),
        (-3,3,-2), (-2,3,-2), (-1,3,-2), (-1,3,-3), (-1,3,-4),
        (-3,4,-2)]
    ]

    override public init() {
        super.init()
        addCube(x: 0, y: 0, z: 0)
        loadTrack(number: 0)
    }
    
    // Positions a new BasicCube at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    public func addCube(x: Int, y: Int, z: Int) {
        let cube = BasicCube()
        let pos = SCNVector3(CGFloat(x) * cube.sidelength, CGFloat(y) * cube.sidelength, CGFloat(z) * cube.sidelength)
        cube.set(position: pos)
        addChildNode(cube)
    }
    
    public func set(position vector: SCNVector3) {
        position = vector
    }
    
    public func set(rotation vector: SCNVector3) {
        eulerAngles = vector
    }
    
    func loadTrack(number index: Int) {
        if tracks.count > index {
            for block in tracks[index] {
                addCube(x: block.0, y: block.1, z: block.2)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
