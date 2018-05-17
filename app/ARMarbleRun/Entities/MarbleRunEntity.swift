//
//  MarbleRunEntity.swift
//  ARMarbleRun
//
import Foundation

class MarbleRunEntity : NSObject, NSCoding {
    
    let name : String
    public var elements : [ElementEntity]
    
    var fileName : String {
        get {
            return self.name.lowercased() + ".dat"
        }
    }
    
    init(name: String) {
        self.name = name
        self.elements = []
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
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.elements = aDecoder.decodeObject(forKey: "elements") as? [ElementEntity] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(elements, forKey: "elements")
    }
}
