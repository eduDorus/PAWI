//
//  MenuWireframe.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//

import Foundation
import UIKit

class MenuWireframe : MenuWireframeProtocol {
    var navigationController : UINavigationController?
    
    static func createMenuModule() -> UIViewController {
        if let controller = mainStoryboard.instantiateViewController(withIdentifier: "MenuNavigationController") as? UINavigationController {
            if let view = controller.childViewControllers.first as? MenuViewProtocol {
                let presenter: MenuPresenterProtocol = MenuPresenter()
                let wireframe: MenuWireframeProtocol = MenuWireframe()
    
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
    
    func presentListView(from view: MenuViewProtocol, with mode: ARInteractionMode) {
        let listView = ListWireframe.createListModule(in: mode)
        if navigationController != nil {
            navigationController!.pushViewController(listView, animated: true)
        }
    }
}
