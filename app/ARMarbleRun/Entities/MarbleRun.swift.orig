//
//  MarbleRun.swift
//  ARMarbleRun
//
import Foundation
import SceneKit

<<<<<<< HEAD
import Foundation

class MarbleRun : NSObject, NSCoding {
    
    let name : String
    var fileName : String {
        get {
            return self.name.lowercased() + ".dat"
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
=======
class MarbleRun: SCNNode {
    
    
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
>>>>>>> e075c6a85a78be3d05849225545c552fd0c7d685
    }
}
