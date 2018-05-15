//
//  MarbleRun.swift
//  ARMarbleRun
//

import Foundation

class MarbleRun : NSObject, NSCoding {
    
    let name : String
    
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
