//
//  AREditorWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class AREditorWireframe : AREditorWireframeProtocol, ARWireframeProtocol {
    
    static func createAREditorModule(of marblerun: MarbleRun) -> UIViewController {
        return UIViewController()
    }
    
    static func createModule(of marblerun: MarbleRun) -> UIViewController {
        return createAREditorModule(of: marblerun)
    }
    
    func presentSelectElement() {
    }
    
    func presentSelectMode() {
    }
    
    func changeMode(with view: ARSCNView) {
    }
}
