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
        // TODO: Open menu
    }
    
    func didPressAddButton() {
        // TODO: Open element select view
    }
    
    func didPressCancelButton() {
        // TODO: Update view
        // TODO: Clear selected element
    }
    
    func didPressGoToLaunchscreen() {
        // TODO: Mabe ask user
        interactor?.persist()
        // TODO: Navigate to home screen
    }
    
    func didPressSaveAction() {
        interactor?.persist()
    }
    
    func getPossiblePositions() {
        // TODO: Show possible bouding boxes
    }
    
    func buildElement(at location: Triple<Int, Int, Int>) {
        // TODO: Update type with selected form select element
        interactor?.buildElement(type: 12, at: location)
        view?.addElement(type: 12, at: location)
        view?.removeBoundingBoxes()
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        // TODO: Check if remove is possible. Should not create a island :)
        interactor?.removeElement(at: location)
        view?.removeElement(at: location)
    }
    
    func selectElement(at location: Triple<Int, Int, Int>) {
        interactor?.selectElement(at: location)
        view?.selectElement(at: location)
    }
    
    func rotateElement(to direction: RotationDirection) {
        interactor?.rotateElement(to: direction)
    }
    
}
