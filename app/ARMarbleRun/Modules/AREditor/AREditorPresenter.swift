//
//  AREditorPresenter.swift
//  ARMarbleRun
//

import Foundation

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
    
    func didPressSaveAction(with marblerun: MarbleRun) {
        interactor?.persist(marblerun: marblerun)
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
