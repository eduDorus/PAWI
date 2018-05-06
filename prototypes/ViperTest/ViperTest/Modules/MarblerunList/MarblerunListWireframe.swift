//
//  MarblerunListWireframe.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

class MarblerunListWireframe : MarblerunListWireframeProtocol {
    
    static func createMarblerunListModule(in mode: ARInteractionMode) -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "MarblerunListViewController")
        if let view = controller as? MarblerunListViewProtocol {
            let presenter: MarblerunListPresenterProtocol = MarblerunListPresenter()
            let wireframe: MarblerunListWireframeProtocol = MarblerunListWireframe()
            let interactor: MarblerunListInteractorProtocol = MarblerunListInteractor()
            
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
