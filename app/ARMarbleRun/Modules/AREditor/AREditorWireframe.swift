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
            let interactor: AREditorInteractorProtocol = AREditorInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            interactor.marbleRun = marblerun
            
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
        // TODO: Open Element Select view
    }
    
    func presentSelectMode() {
        let selectMode = SelectModeWireframe.createSelectModeModule()
        UIApplication.shared.keyWindow?.rootViewController = selectMode
    }
    
    func changeMode(with marblerun: MarbleRunEntity) {
        let arview = ARBuilderWireframe.createARBuilderModule(of: marblerun)
        UIApplication.shared.keyWindow?.rootViewController = arview
    }
}
