//
//  AREditorWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

    
    
class AREditorWireframe : AREditorWireframeProtocol, ARWireframeProtocol {
    
    static func createAREditorModule(of marblerun: MarbleRun) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "AREditorViewController")
        if let view = controller as? AREditorViewProtocol {
            let presenter: AREditorPresenterProtocol = AREditorPresenter()
            let wireframe: AREditorWireframeProtocol = AREditorWireframe()
            let interactor: AREditorInteractorProtocol = AREditorInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            interactor.marblerun = marblerun
            
            return controller
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule(of marblerun: MarbleRun) -> UIViewController {
        return createAREditorModule(of: marblerun)
    }
}
