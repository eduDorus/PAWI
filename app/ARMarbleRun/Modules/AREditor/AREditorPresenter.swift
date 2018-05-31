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
        getPossibleLocations()
    }
    
    func getPossibleLocations() {
        let locations = interactor?.getPossibleLocations()
        view?.addBoundingBoxes(at: locations!)
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
            view?.deselect(at: selectedElement!)
        }
        selectedElement = location
        view?.select(at: location)
    }

    func rotateElement(to direction: UISwipeGestureRecognizerDirection, with cameraAngle: Float) {
        if let element = selectedElement {
            var rotation : SCNVector3
            switch direction {
            case .left:
                rotation = SCNVector3(0, -1, 0)
            case .right:
                rotation = SCNVector3(0, 1, 0)
            case .up:
                rotation = SCNVector3(-1, 0, 0)
            case .down:
                rotation = SCNVector3(1, 0, 0)
            default:
                rotation = SCNVector3(0, 0, 0)
            }

            if (direction == .up || direction == .down) {
                // looking at right face
                if (cameraAngle > Float.pi/4 && cameraAngle < Float.pi/4*3) {
                    (rotation.x, rotation.z) = (rotation.z, -rotation.x)
                }
                // looking at back face
                else if (cameraAngle > Float.pi/4*3 || cameraAngle < -Float.pi/4*3) {
                    rotation.x = -rotation.x
                }
                // looking at left face
                else if (cameraAngle > -Float.pi/4*3 && cameraAngle < -Float.pi/4) {
                    (rotation.x, rotation.z) = (rotation.z, rotation.x)
                }
            }

            view?.rotate(at: element, rotation: rotation) { (rotation) in
                self.interactor?.rotateElement(at: element, rotate: (rotation.x, rotation.y, rotation.z, rotation.w))
            }
        }
    }
    
    func deselectElement() {
        if selectedElement != nil {
            view?.deselect(at: selectedElement!)
            selectedElement = nil
        }
    }
}
