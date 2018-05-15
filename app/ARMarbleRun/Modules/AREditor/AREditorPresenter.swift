//
//  AREditorPresenter.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class AREditorPresenter : AREditorPresenterProtocol {
    var wireframe: AREditorWireframeProtocol?
    weak var view: AREditorViewProtocol?
    var interactor: AREditorInteractorProtocol?
    
    func viewDidLoad() {
        
    }
    
    func didPressMenuButton() {
        // TODO: This should open the menu
    }
    
    func didPressAddButton() {
        // TODO: Open ElementSelect View
    }
    
    func didPressCancelButton() {
        interactor?.clearSelectedElement()
    }
    
    func didPressSaveAction(with marblerun: MarbleRunEntity) {
        interactor?.persist()
    }
    
    func didPressGoToLaunchscreen() {
        
    }
    
    func didPressSaveAction() {
        
    }
    
    func didSwipe(in direction: UISwipeGestureRecognizerDirection) {
        
    }
    
    func didTap(on element: MarbleRunElement) {
        
    }
    
    func didLongTap(on element: MarbleRunElement) {
        
    }
}
