//
//  ARBuilderPresenter.swift
//  ARMarbleRun
//

import Foundation
import ARKit

class ARBuilderPresenter : ARBuilderPresenterProtocol {
    
    var wireframe: ARBuilderWireframeProtocol?
    weak var view: ARBuilderViewProtocol?
    var interactor: ARBuilderInteractorProtocol?
    
    func viewDidLoad() {
        let mr = interactor?.retrieveMarbleRun()
        view?.add(elements: mr!)  // WTF? why optional
    }
    
    func readyForMarbleRun() {
        view?.initializeMarbleRun()
        if let elements = interactor?.retrieveMarbleRun() {
            view?.add(elements: elements)
        }
    }
    
    func didPressNext() {
        interactor?.nextStep()
    }
    
    func didPressPrevious() {
        interactor?.previousStep()
    }
    
    func didPressRestartAction() {
        interactor?.resetGuide()
    }
    
    func didPressChangeModeAction(from sceneView: ARSCNView) {
        if let run = interactor?.marbleRun {
            wireframe?.changeMode(with: run)
        }
    }
    
    func didPressLeaveAction() {
        wireframe?.presentSelectMode()
    }
    
}
