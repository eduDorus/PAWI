//
//  MarbleRunEntity.swift
//  ARMarbleRun
//
import Foundation

class MarbleRunEntity : NSObject, NSCoding {
    
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
    }
}
