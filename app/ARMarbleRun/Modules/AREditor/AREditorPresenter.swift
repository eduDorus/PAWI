//
//  AREditorPresenter.swift
//  ARMarbleRun
//

import Foundation
import ARKit

class AREditorPresenter : AREditorPresenterProtocol {
    var wireframe: AREditorWireframeProtocol?
    weak var view: AREditorViewProtocol?
    var interactor: AREditorInteractorProtocol?
    var nextElement: ElementEntity = ElementEntity(type: 12, location: Triple(0,0,0))
    
    func viewDidLoad() {
        let mr = interactor?.retrieveMarbleRun()
        view?.add(elements: mr!)
    }
    
    func readyForMarbleRun() {
        view?.initializeMarbleRun()
        if let elements = interactor?.retrieveMarbleRun() {
            view?.add(elements: elements)
        }
    }
    
    func didPressAddButton(on view: AREditorViewProtocol) {
        wireframe?.presentSelectElement(from: view)
    }
    
    func didPressCancelButton() {
        view?.removeBoundingBoxes()
    }
    
    // MARK: - Menu actions
    
    func didPressChangeModeAction(from sceneView: ARSCNView) {
        if let run = interactor?.marbleRun {
            wireframe?.changeMode(with: run)
        }
    }
    
    func didPressLeaveAction() {
        wireframe?.presentSelectMode()
    }
    
    func didPressSaveAction() {
        interactor?.persist()
    }
    
    func setSelectedElement(element: ElementEntity) {
        nextElement = element
        getPossiblePositions()
    }
    
    func getPossiblePositions() {
        let positions = interactor?.getPossiblePositions()
        view?.addBoundingBoxes(at: positions!)
    }
    
    func buildElement(at location: Triple<Int, Int, Int>) {
        nextElement.set(location: location)
        interactor?.buildElement(element: nextElement)
        view?.add(element: nextElement)
        view?.removeBoundingBoxes()
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        // TODO: Check if remove is possible. Should not create a island :)
        if (interactor?.removeElement(at: location))! {
            view?.remove(at: location)
        }
    }
    
    func selectElement(at location: Triple<Int, Int, Int>) {
        interactor?.selectElement(at: location)
        view?.select(at: location)
    }
    
    func rotateElement(to direction: RotationDirection) {
        interactor?.rotateElement(to: direction)
    }
}
