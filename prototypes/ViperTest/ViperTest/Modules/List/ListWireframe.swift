//
//  ListWireframe.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

class ListWireframe : ListWireframeProtocol {
    
    static func createListModule(in mode: ARInteractionMode) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ListNavigationController")
        if let view = controller.childViewControllers.first as? ListViewProtocol {
            let presenter: ListPresenterProtocol = ListPresenter()
            let wireframe: ListWireframeProtocol = ListWireframe()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            
            return controller
        }
        return UINavigationController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func presentARView() {
    }
    
    func presentMenuView() {
    }
}
