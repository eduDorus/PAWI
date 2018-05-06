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
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ListViewController")
        if let view = controller as? ListViewProtocol {
            let presenter: ListPresenterProtocol = ListPresenter()
            let wireframe: ListWireframeProtocol = ListWireframe()
            let interactor: ListInteractorProtocol = ListInteractor()
            
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
    
    func presentARView(with marblerun: Marblerun) {
        // TODO: got to ARView
    }
}
