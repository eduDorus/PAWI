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
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        self.elements = aDecoder.decodeObject(forKey: "elements") as? [ElementEntity] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(elements, forKey: "elements")
    }
}
