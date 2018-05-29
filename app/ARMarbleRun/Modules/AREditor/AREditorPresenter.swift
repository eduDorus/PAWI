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
    var selectedElement: Triple<Int, Int, Int>?
    
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
    
    func selectElement(at location: Triple<Int, Int, Int>) {
        if selectedElement != nil {
            view?.unselect(at: selectedElement!)
        }
        selectedElement = location
        view?.select(at: location)
    }
    
    func rotateElement(to direction: UISwipeGestureRecognizerDirection) {
       if let element = selectedElement {
            var rotation: CGFloat = 0.0
            if direction == .left {
                rotation = CGFloat(-(Double.pi/2))
            }
            if direction == .right {
                rotation = CGFloat(Double.pi/2)
            }
            interactor?.rotateElement(at: element, rotate: (Float(0), Float(rotation), Float(0)))
            view?.rotate(at: element, rotation: (0, rotation, 0))
        }
    }
    
    func unselectElement() {
        if selectedElement != nil {
            view?.unselect(at: selectedElement!)
            selectedElement = nil
        }
    }
}
