//
//  MarbleRunListWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class MarbleRunListWireframe : MarbleRunListWireframeProtocol {
    
    let mode : ARInteractionMode
    
    static func createMarbleRunListModule(in mode: ARInteractionMode) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "MarbleRunListViewController")
        if let view = controller as? MarbleRunListViewProtocol {
            let presenter: MarbleRunListPresenterProtocol = MarbleRunListPresenter()
            let wireframe: MarbleRunListWireframeProtocol = MarbleRunListWireframe(with: mode)
            let interactor: MarbleRunListInteractorProtocol = MarbleRunListInteractor()
            
            view.presenter = presenter
            view.canAddNew = (mode == .editor)
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
    
    init(with mode: ARInteractionMode) {
        self.mode = mode
    }
    
    func presentARView(from view: MarbleRunListViewProtocol, with marblerun: MarbleRunEntity) {
        let arview = mode.wireframe().createModule(of: marblerun)
        UIApplication.shared.keyWindow?.rootViewController = arview
    }
}
