//
//  TrackBuilder.swift
//  MarbletrackBuildingGuide
//
//  Created by Lucas Schnüriger on 12.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import SceneKit

class TrackEditor {
    var selected: BasicCube?
    let marbleTrack : MarbleTrack
    
    init(_ marbleTrack: MarbleTrack) {
        self.marbleTrack = marbleTrack
    }
    
    func start() {
        let currentElements = marbleTrack.getMap()
        currentElements.forEach { (key, basicCube) in
            showNewPossibilities(cube: basicCube)
        }
    }
    
    func removeCube(cube: BasicCube) {
        marbleTrack.removeCube(cube: cube)
    }
    
    func updateSelected(cube: BasicCube) {
        if cube.getState() == BasicCubeState.planned {
            cube.set(state: BasicCubeState.built)
            cube.show()
            showNewPossibilities(cube: cube)
        } else {
            selected?.set(state: BasicCubeState.built)
            selected = cube
            selected?.set(state: BasicCubeState.active)
        }
    }
    
    func showNewPossibilities(cube: BasicCube) {
        let key = marbleTrack.getMap().getKeys(forElement: cube).first
        if let (x, y, z) = key?.values {
            if marbleTrack.getMap().getElement(at: Triple(x + 1, y, z)) == nil {
                marbleTrack.addCube(x: x + 1,y: y,z: z).set(state: BasicCubeState.planned)
            }
            if marbleTrack.getMap().getElement(at: Triple(x - 1, y, z)) == nil {
                marbleTrack.addCube(x: x - 1,y: y,z: z).set(state: BasicCubeState.planned)
            }
            if marbleTrack.getMap().getElement(at: Triple(x, y, z + 1)) == nil {
                marbleTrack.addCube(x: x,y: y,z: z + 1).set(state: BasicCubeState.planned)
            }
            if marbleTrack.getMap().getElement(at: Triple(x, y, z - 1)) == nil {
                marbleTrack.addCube(x: x,y: y,z: z - 1).set(state: BasicCubeState.planned)
            }
        }
    }
    
    func rotateRight() {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi/2), z: 0, duration: 0.5)
        selected?.runAction(action, forKey: "rotate")
        selected?.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
    }
    
    func rotateLeft() {
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(-(Double.pi/2)), z: 0, duration: 0.5)
        selected?.runAction(action, forKey: "rotate")
        selected?.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
    }
    
    func rotateUp(currentAngle: Float?) {
        var action: SCNAction!
        if (currentAngle! > Float(0.785) && currentAngle! < Float(2.356)) {
            action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(Double.pi/2), duration: 0.5)
        }
        else if (currentAngle! > Float(2.356) || currentAngle! < Float(-2.356)) {
            action = SCNAction.rotateBy(x: CGFloat(Double.pi/2), y: 0, z: 0, duration: 0.5)
        }
        else if (currentAngle! > Float(-2.356) && currentAngle! < Float(-0.785)) {
            action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(-(Double.pi/2)), duration: 0.5)
        }
        else if (currentAngle! > Float(-0.785) && currentAngle! < Float(0.785)) {
            action = SCNAction.rotateBy(x: CGFloat(-(Double.pi/2)), y: 0, z: 0, duration: 0.5)
        }
        selected?.runAction(action, forKey: "rotate")
        selected?.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
    }
    
    func rotateDown(currentAngle: Float?) {
        var action: SCNAction!
        if (currentAngle! > Float(0.785) && currentAngle! < Float(2.356)) {
            action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(-(Double.pi/2)), duration: 0.5)
        }
        else if (currentAngle! > Float(2.356) || currentAngle! < Float(-2.356)) {
            action = SCNAction.rotateBy(x: CGFloat(-(Double.pi/2)), y: 0, z: 0, duration: 0.5)
        }
        else if (currentAngle! > Float(-2.356) && currentAngle! < Float(-0.785)) {
            action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(Double.pi/2), duration: 0.5)
        }
        else if (currentAngle! > Float(-0.785) && currentAngle! < Float(0.785)) {
            action = SCNAction.rotateBy(x: CGFloat(Double.pi/2), y: 0, z: 0, duration: 0.5)
        }
        selected?.runAction(action, forKey: "rotate")
        selected?.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
    }
    
}
