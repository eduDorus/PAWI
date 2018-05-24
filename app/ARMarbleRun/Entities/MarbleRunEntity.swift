//
//  MarbleRunEntity.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunEntity : NSObject, NSCoding {
    
    let name : String
    let countKey = "size"
    public var elements : [ElementEntity] = []
    
    var fileName : String {
        get {
            return self.name.lowercased() + ".dat"
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func getElement(at location: Triple<Int, Int, Int>) -> ElementEntity? {
        var foundElement: ElementEntity?
        for element in elements {
            if element.location == location {
                foundElement = element
            }
        }
        return foundElement
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        for (index, element) in elements.enumerated() {
            if element.location == location {
                elements.remove(at: index)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        //self.elements = aDecoder.decodeObject(forKey: "elements") as? [ElementEntity] ?? []
        let count = aDecoder.decodeInteger(forKey: countKey)
        for _ in 0...count {
            if let element = aDecoder.decodeObject() as? ElementEntity {
                elements.append(element)
            }
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        //aCoder.encode(elements, forKey: "elements")
        aCoder.encode(elements.count, forKey: countKey)
        for element in elements {
            aCoder.encode(element)
        }
    }
}
