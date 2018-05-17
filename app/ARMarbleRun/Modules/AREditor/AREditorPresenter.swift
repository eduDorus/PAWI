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
        
    }
    
    func didPressAddButton() {
        
    }
    
    func didPressCancelButton() {
        
    }
    
    func didPressGoToLaunchscreen() {
        
    }
    
    func didPressSaveAction() {
        
    }
    
    func getPossiblePositions() {
        
    }
    
    func buildElement(at location: Triple<Int, Int, Int>) {
        interactor?.buildElement(at: location)
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        interactor?.removeElement(at: location)
    }
    
    func selectElement(at location: Triple<Int, Int, Int>) {
        interactor?.selectElement(at: location)
    }
    
    func rotateElement(to direction: RotationDirection) {
        interactor?.rotateElement(to: direction)
    }
    
}
