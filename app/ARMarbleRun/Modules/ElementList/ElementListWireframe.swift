//
//  ElementListWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

    
    
class ElementListWireframe : ElementListWireframeProtocol {
    
    static func createElementListModule() -> UIViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ElementListViewController")
        if let view = controller as? ElementListViewProtocol {
            let presenter: ElementListPresenterProtocol = ElementListPresenter()
            let wireframe: ElementListWireframeProtocol = ElementListWireframe()
            let interactor: ElementListInteractorProtocol = ElementListInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            
            return controller
        }
        return UICollectionViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func dismissModule(from view: ElementListViewProtocol , with element: ElementEntity) {
        
        if let vc = view as? UIViewController {
            if let parent = vc.presentingViewController as? AREditorViewProtocol {
                vc.dismiss(animated: true) {
                    parent.elementSelected(element: element)
                }
            }
        }
    }
}
