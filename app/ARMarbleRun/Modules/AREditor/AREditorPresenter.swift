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
    var selectedElement: ElementNode?
    
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
    
    func setNextElement(element: ElementEntity) {
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
        view?.toggleAddCancel()
    }
    
    func removeElement(at location: Triple<Int, Int, Int>) {
        // TODO: Check if remove is possible. Should not create a island :)
        if interactor?.removeElement(at: location) == true {
            view?.remove(at: location)
        }
    }
    
    func selectElement(element: ElementNode) {
        if selectedElement != nil {
            selectedElement?.set(state: .normal)
        }
        selectedElement = element
        selectedElement?.set(state: .highlighted)
    }
    
    func rotateElement(to direction: UISwipeGestureRecognizerDirection) {
        var rotation: CGFloat = 0.0
        if direction == .left {
            rotation = CGFloat(-(Double.pi/2))
        }
        if direction == .right {
            rotation = CGFloat(Double.pi/2)
        }
        
        view?.rotate(element: selectedElement!, rotation: rotation)
    }
}
