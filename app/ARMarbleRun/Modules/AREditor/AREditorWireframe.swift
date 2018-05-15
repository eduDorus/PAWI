//
//  AREditorWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

    
    
class AREditorWireframe : AREditorWireframeProtocol, ARWireframeProtocol {
   
    static func createAREditorModule(of marblerun: MarbleRunEntity) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "AREditorViewController")
        if let view = controller as? AREditorViewProtocol {
            let presenter: AREditorPresenterProtocol = AREditorPresenter()
            let wireframe: AREditorWireframeProtocol = AREditorWireframe()
            let interactor: AREditorInteractorProtocol = AREditorInteractor(with: marblerun)
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            
            return controller
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule(of marblerun: MarbleRunEntity) -> UIViewController {
        return createAREditorModule(of: marblerun)
    }

    func presentSelectElement() {
    }
    
    func presentSelectMode() {
    }
    
    func changeMode(with view: ARSCNView) {
    }
}
