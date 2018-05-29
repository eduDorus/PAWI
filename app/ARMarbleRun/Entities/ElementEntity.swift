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
    var rotation: (Float, Float, Float) = (0.0,0.0,0.0)
    
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
    
    func rotate(_ rotation: (Float, Float, Float)) {
        let (x,y,z) = rotation
        self.rotation.0 = (self.rotation.0 + x).remainder(dividingBy: (2 * .pi))
        self.rotation.1 = (self.rotation.1 + y).remainder(dividingBy: (2 * .pi))
        self.rotation.2 = (self.rotation.2 + z).remainder(dividingBy: (2 * .pi))
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = aDecoder.decodeInteger(forKey: "type")
        //self.rotation = aDecoder.decode(forKey: "rotation")
        let x = aDecoder.decodeInteger(forKey: "location0")
        let y = aDecoder.decodeInteger(forKey: "location1")
        let z = aDecoder.decodeInteger(forKey: "location2")
        self.location = Triple(x,y,z)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        //.encode(orientation, forKey: "orientation")
        aCoder.encode(location.values.0, forKey: "location0")
        aCoder.encode(location.values.1, forKey: "location1")
        aCoder.encode(location.values.2, forKey: "location2")
    }
}

enum ElementState {
    case highlighted
    case normal
    case faded
    case hidden
}
