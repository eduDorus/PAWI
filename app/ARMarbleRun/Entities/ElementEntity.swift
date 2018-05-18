//
//  ElementEntity.swift
//  ARMarbleRun
//
import Foundation

class ElementEntity : NSObject, ElementProtocol, NSCoding {
    public var location : Triple<Int, Int, Int>
    var state = ElementState.normal
    public var id = 12
    var orientation = 5
    
    init(id: Int, location: Triple<Int, Int, Int>) {
        self.id = id
        self.location = location
    }

    func set(state: ElementState) {
        self.state = state
    }
    
    func getState() -> ElementState {
        return self.state
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeInteger(forKey: "id")
        self.orientation = aDecoder.decodeInteger(forKey: "orientation")
        let x = aDecoder.decodeInteger(forKey: "location0")
        let y = aDecoder.decodeInteger(forKey: "location1")
        let z = aDecoder.decodeInteger(forKey: "location2")
        self.location = Triple(x,y,z)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(orientation, forKey: "orientation")
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
