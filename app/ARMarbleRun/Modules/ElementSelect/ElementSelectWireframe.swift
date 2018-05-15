//
//  ElementSelectWireframe.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

    
    
class ElementSelectWireframe : ElementSelectWireframeProtocol, ARWireframeProtocol {
    
    static func createElementSelectModule(of marblerun: MarbleRunEntity) -> UICollectionViewController {
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
    
    static func createModule(of marblerun: MarbleRunEntity) -> UIViewController {
        return createElementSelectModule(of: marblerun)
    }
    
    func presentSelectElement() {
        
    }
    
    func presentSelectMode() {
        
    }
    
    func changeMode(with view: ARSCNView) {
        
    }
}
