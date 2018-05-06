//
//  MarblerunListInteractor.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class MarblerunListInteractor : MarblerunListInteractorProtocol {
    
    func retrieveMarbleruns(_ callback: ([Marblerun]) -> Void) {
        var runs : [Marblerun] = []
        for _ in 0...12 {
            runs.append(Marblerun())
        }
        callback(runs)
    }
}
