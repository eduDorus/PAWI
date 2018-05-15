//
//  LocalDataManager.swift
//  ARMarbleRun
//

import Foundation
import os

class MarbleRunDataManager {
    let directory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    let marbleRunsFile = "MarbleRuns.dat"

    func retrieveMarbleRunList() -> [MarbleRunEntity]? {
        let filePath = directory.appendingPathComponent(marbleRunsFile)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath.path) as? [MarbleRunEntity]
    }
    
    func persist(_ runs: [MarbleRunEntity]) {
        let filePath = directory.appendingPathComponent(marbleRunsFile)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(runs, toFile: filePath.path)
        if isSuccessfulSave {
            os_log("MarbleRuns successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save MarbleRuns...", log: OSLog.default, type: .error)
        }
    }
    
    func persist(_ run: MarbleRunEntity) {
        let filePath = directory.appendingPathComponent(run.fileName)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(run, toFile: filePath.path)
        if isSuccessfulSave {
            os_log("MarbleRun successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save MarbleRun...", log: OSLog.default, type: .error)
        }
    }
}
