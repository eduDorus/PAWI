//
//  ListInteractor.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class ListInteractor : ListInteractorProtocol {
    func retrieveMarbleruns(_ callback: ([Marblerun]) -> Void) {
        let runs = [Marblerun(), Marblerun()]
        callback(runs)
    }
}
