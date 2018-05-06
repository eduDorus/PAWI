//
//  MenuProtocols.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//

import Foundation
import UIKit

protocol MenuWireframeProtocol : class {
    var navigationController : UINavigationController? { get set }
    static func createMenuModule() -> UIViewController
    func presentListView(from view: MenuViewProtocol, with mode: ARInteractionMode)
}

protocol MenuViewProtocol : class {
    var presenter : MenuPresenterProtocol? { get set }
}

protocol MenuPresenterProtocol : class {
    var view : MenuViewProtocol? { get set }
    var wireframe : MenuWireframeProtocol? { get set }
    
    func didPressBuilderButton(on view: MenuViewProtocol)
    func didPressEditorButton(on view: MenuViewProtocol)
}

