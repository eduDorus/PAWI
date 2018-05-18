//
//  ARBuilderWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARBuilderWireframe : ARBuilderWireframeProtocol, ARWireframeProtocol {
    
    static func createARBuilderModule(of marblerun: MarbleRunEntity) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ARBuilderViewController")
        if let view = controller as? ARBuilderViewProtocol {
            let presenter: ARBuilderPresenterProtocol = ARBuilderPresenter()
            let wireframe: ARBuilderWireframeProtocol = ARBuilderWireframe()
            let interactor: ARBuilderInteractorProtocol = ARBuilderInteractor()
            
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
        return createARBuilderModule(of: marblerun)
    }
    
    func presentSelectMode() {
        let selectMode = SelectModeWireframe.createSelectModeModule()
        UIApplication.shared.keyWindow?.rootViewController = selectMode
    }
    
    func changeMode(with marblerun: MarbleRunEntity) {
        let arview = AREditorWireframe.createAREditorModule(of: marblerun)
        UIApplication.shared.keyWindow?.rootViewController = arview
    }

}