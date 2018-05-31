//
//  ElementEntity.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class ElementEntity : NSObject, ElementProtocol, NSCoding {
    public var location : Triple<Int, Int, Int>
    var state = ElementState.normal
    public var type = 12
    var rotation: (Float, Float, Float, Float) = (0.0, 0.0, 0.0, 0.0)
    
    var image : UIImage? {
        get {
            return UIImage(named: "element-\(type)")
        }
    }
    
    init(type: Int, location: Triple<Int, Int, Int>) {
        self.type = type
        self.location = location
    }

    func set(state: ElementState) {
        self.state = state
    }
    
    func set(location: Triple<Int, Int, Int>) {
        self.location = location
    }
    
    func set(rotation: (Float, Float, Float, Float)) {
        self.rotation = rotation
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = aDecoder.decodeInteger(forKey: "type")
        let x = aDecoder.decodeInteger(forKey: "location0")
        let y = aDecoder.decodeInteger(forKey: "location1")
        let z = aDecoder.decodeInteger(forKey: "location2")
        self.location = Triple(x,y,z)
        let rx = aDecoder.decodeFloat(forKey: "rotationX")
        let ry = aDecoder.decodeFloat(forKey: "rotationY")
        let rz = aDecoder.decodeFloat(forKey: "rotationZ")
        let rw = aDecoder.decodeFloat(forKey: "rotationW")
        self.rotation = (rx, ry, rz, rw)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(location.values.0, forKey: "location0")
        aCoder.encode(location.values.1, forKey: "location1")
        aCoder.encode(location.values.2, forKey: "location2")
        aCoder.encode(rotation.0, forKey: "rotationX")
        aCoder.encode(rotation.1, forKey: "rotationY")
        aCoder.encode(rotation.2, forKey: "rotationZ")
        aCoder.encode(rotation.3, forKey: "rotationW")
    }
}

enum ElementState {
    case highlighted
    case normal
    case faded
    case hidden
}
