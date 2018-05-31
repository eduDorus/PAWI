//
//  LocalDataManager.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunDataManager {
    static let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    static func retrieveMarbleRunList() -> [MarbleRunEntity] {
        var runs : [MarbleRunEntity] = []

        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            for url in fileURLs {
                if let run = NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? MarbleRunEntity {
                    runs.append(run)
                }
            }
        } catch {
            print("Error while enumerating files \(directory.path): \(error.localizedDescription)")
        }

        return runs
    }
    
    static func persist(_ run: MarbleRunEntity) {
        let filePath = directory.appendingPathComponent(run.fileName)
        if NSKeyedArchiver.archiveRootObject(run, toFile: filePath.path) {
            print("MarbleRun '\(run.name)' successfully saved.")
        } else {
            print("Failed to save MarbleRun '\(run.name)'...")
        }
    }
    
    static func isDirectoryEmpty() -> Bool {
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            if fileURLs.count == 0 {
                return true
            } else {
                return false
            }
        } catch {
            print("Error while enumerating files \(directory.path): \(error.localizedDescription)")
            return true
        }
    }

}
