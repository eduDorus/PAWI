//
//  ElementSelectWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

    
    
class ElementSelectWireframe : ElementSelectWireframeProtocol {
    static func createElementSelectModule() -> UICollectionViewController {
        let controller = mainStoryboard.instantiateViewController(withIdentifier: "ElementSelectViewController")
        if let view = controller as? ElementSelectViewProtocol {
            let presenter: ElementSelectPresenterProtocol = ElementSelectPresenter()
            let wireframe: ElementSelectWireframeProtocol = ElementSelectWireframe()
            let interactor: ElementSelectInteractorProtocol = ElementSelectInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireframe = wireframe
            presenter.interactor = interactor
            
            return controller as! UICollectionViewController
        }
        return UICollectionViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func dismissModule(form view: ElementSelectViewProtocol , with type: Int) {
        if let vc = view as? UIViewController {
            vc.dismiss(animated: true) {
                
            }
        }
    }
}
