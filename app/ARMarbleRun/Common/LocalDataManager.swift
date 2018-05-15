//
//  LocalDataManager.swift
//  ARMarbleRun
//
//  Created by Lucas Schnüriger on 15.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import os

class MarbleRunDataManager {
    let directory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    let marbleRunsFile = "MarbleRuns.dat"

    func retrieveMarbleRunList() -> [MarbleRun]? {
        let filePath = directory.appendingPathComponent(marbleRunsFile)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath.path) as? [MarbleRun]
    }
    
    func persist(_ runs: [MarbleRun]) {
        let filePath = directory.appendingPathComponent(marbleRunsFile)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(runs, toFile: filePath.path)
        if isSuccessfulSave {
            os_log("MarbleRuns successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save MarbleRuns...", log: OSLog.default, type: .error)
        }
    }
}
