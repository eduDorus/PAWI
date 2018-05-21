//
//  ARGuidePresenter.swift
//  ARMarbleRun
//

import Foundation
import ARKit

class ARGuidePresenter : ARGuidePresenterProtocol, ARGuideInteractorOutputProtocol {
    
    var wireframe: ARGuideWireframeProtocol?
    weak var view: ARGuideViewProtocol?
    var interactor: ARGuideInteractorInputProtocol?
    
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
    
    // MARK: - ARGuideInteractorOutputProtocol
    
    func set(elementAt position: Triple<Int, Int, Int>, to state: ElementState) {
        view?.set(elementAt: position, to: state)
    }
    
    func setAllElements(to state: ElementState) {
        view?.setRun(to: state)
    }
    
}
