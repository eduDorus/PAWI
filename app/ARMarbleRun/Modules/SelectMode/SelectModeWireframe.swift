//
//  SelectModeWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class SelectModeWireframe : SelectModeWireframeProtocol {
    
    var navigationController : UINavigationController?
    
    static func createSelectModeModule() -> UIViewController {
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "SelectModeNavigationController") as? UINavigationController {
            if let view = controller.childViewControllers.first as? SelectModeViewProtocol {
                let presenter: SelectModePresenterProtocol = SelectModePresenter()
                let wireframe: SelectModeWireframeProtocol = SelectModeWireframe()
    
                view.presenter = presenter
                presenter.view = view
                presenter.wireframe = wireframe
                wireframe.navigationController = controller

                return controller
            }
        }
        return UINavigationController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentMarbleRunListView(from view: SelectModeViewProtocol, with mode: ARInteractionMode) {
        let listView = MarbleRunListWireframe.createMarbleRunListModule(in: mode)
        if navigationController != nil {
            navigationController!.pushViewController(listView, animated: true)
        }
    }
}
