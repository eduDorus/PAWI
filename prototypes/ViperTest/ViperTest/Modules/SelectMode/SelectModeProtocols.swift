//
//  SelectModeProtocols.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//

import Foundation
import UIKit

protocol SelectModeWireframeProtocol : class {
    var navigationController : UINavigationController? { get set }
    static func createSelectModeModule() -> UIViewController
    func presentMarblerunListView(from view: SelectModeViewProtocol, with mode: ARInteractionMode)
}

protocol SelectModeViewProtocol : class {
    var presenter : SelectModePresenterProtocol? { get set }
}

protocol SelectModePresenterProtocol : class {
    var view : SelectModeViewProtocol? { get set }
    var wireframe : SelectModeWireframeProtocol? { get set }
    
    func didPressBuilderButton(on view: SelectModeViewProtocol)
    func didPressEditorButton(on view: SelectModeViewProtocol)
}

