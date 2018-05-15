//
//  ARInteractionMode.swift
//  ARMarbleRun
//

import Foundation
import UIKit

enum ARInteractionMode {
    case builder
    case editor
    
    func wireframe() -> ARWireframeProtocol.Type {
        switch self {
        case .builder:
            return ARBuilderWireframe.self
        case .editor:
            return AREditorWireframe.self
        }
    }
}

protocol ARWireframeProtocol {
    static func createModule(of marblerun: MarbleRunEntity) -> UIViewController
}
