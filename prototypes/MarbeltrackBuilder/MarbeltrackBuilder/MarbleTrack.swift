//
//  MarbleTrack.swift
//  virtuelle-kugelbahn
//
//  Created by Lucas Schnüriger on 12.04.2018
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class MarbleTrack: SCNNode {
    
    private let tracks = [
        [(0,0,0)]
    ]
    private var currentTrack = 0
    private var map = TrackMap<BasicCube>()
    
    override init() {
        super.init()
        let cube = addCube(x: 0, y: 0, z: 0)
        cube.set(color: UIColor.yellow)
        cube.name = "basecube"
        //loadTrack(number: currentTrack)
    }
    
    // Positions a new BasicCube at the given location in blocks (origin block is at 0,0,0 while 0,1,0 would be a block on top of it)
    @discardableResult
    func addCube(x: Int, y: Int, z: Int) -> BasicCube {
        let cube = BasicCube()
        let pos = SCNVector3(CGFloat(x) * cube.sidelength, CGFloat(y) * cube.sidelength, CGFloat(z) * cube.sidelength)
        cube.set(position: pos)
        addChildNode(cube)
        map.add(element: cube, atLocation: Triple(x, y, z))
        return cube
    }
    
    func removeCube(cube: BasicCube) {
        map.removeElement(element: cube)
        cube.remove()
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
    
    // remove all BasicCube nodes from the track
    private func clearTrack() {
        map.forEach { (position, cube) in
            if cube.name != "basecube" {
                cube.remove()
                map.removeElement(at: position)
            }
        }
    }
    
    private func hideTrack() {
        map.forEach { (_, cube) in
            cube.hide()
        }
    }
    
    func loadTrack(number index: Int) {
        currentTrack = index
        clearTrack()
        if tracks.indices.contains(index) {
            for block in tracks[index] {
                addCube(x: block.0, y: block.1, z: block.2)
            }
        } else {
            print("track \(index) does not exist")
        }
    }
    
    func getMap() -> TrackMap<BasicCube> {
        return map
    }
    
    
    private func clearHighlights() {
        map.forEach { (_, cube) in
            cube.set(color: UIColor.white)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
