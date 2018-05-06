//
//  MenuWireframe.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//

import Foundation
import UIKit

class MenuWireframe : MenuWireframeProtocol {
    
    static func createMenuModule() -> UIViewController {

        let controller = mainStoryboard.instantiateViewController(withIdentifier: "MenuViewController")
        if let view = controller as? MenuViewProtocol {
            let presenter: MenuPresenterProtocol = MenuPresenter()
            let wireframe: MenuWireframeProtocol = MenuWireframe()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe

            return controller
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentListView(from view: MenuViewProtocol, with mode: ARInteractionMode) {
        let listView = ListWireframe.createListModule(in: mode)
        if let sourceView = view as? UIViewController {
            sourceView.present(listView, animated: true, completion: nil)
        }
    }
}
