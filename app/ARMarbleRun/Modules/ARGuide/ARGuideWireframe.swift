//
//  ARGuideWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARGuideWireframe : ARGuideWireframeProtocol, ARWireframeProtocol {
    
    static func createARGuideModule(of marblerun: MarbleRunEntity) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ARGuideViewController")
        if let view = controller as? ARGuideViewProtocol {
            let presenter = ARGuidePresenter()
            let wireframe: ARGuideWireframeProtocol = ARGuideWireframe()
            let interactor: ARGuideInteractorInputProtocol = ARGuideInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            interactor.marbleRun = marblerun
            interactor.output = presenter
            
            return controller
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func createModule(of marblerun: MarbleRunEntity) -> UIViewController {
        return createARGuideModule(of: marblerun)
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
