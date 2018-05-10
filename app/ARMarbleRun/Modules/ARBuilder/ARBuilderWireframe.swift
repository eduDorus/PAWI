//
//  ARBuilderWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARBuilderWireframe : ARBuilderWireframeProtocol, ARWireframeProtocol {
    
    static func createARBuilderModule(of marblerun: MarbleRun) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ARBuilderViewController")
        if let view = controller as? ARBuilderViewProtocol {
            let presenter: ARBuilderPresenterProtocol = ARBuilderPresenter()
            let wireframe: ARBuilderWireframeProtocol = ARBuilderWireframe()
            let interactor: ARBuilderInteractorProtocol = ARBuilderInteractor()
            
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
    
    static func createModule(of marblerun: MarbleRun) -> UIViewController {
        return createARBuilderModule(of: marblerun)
    }
    
    func presentSelectMode() {
        //code
    }
    
    func changeMode(with view: ARSCNView) {
        //code
    }

}
