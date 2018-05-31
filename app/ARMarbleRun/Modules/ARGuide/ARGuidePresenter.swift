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
    
    func didPressStart() {
        interactor?.resetGuide()
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
    
    func set(elementAt location: Triple<Int, Int, Int>, to state: ElementState) {
        view?.set(elementAt: location, to: state)
    }
    
    func setAllElements(to state: ElementState) {
        view?.setRun(to: state)
    }
    
    func buttons(previousEnabled prev: Bool, nextEnabled next: Bool) {
        view?.previousButton(enabled: prev)
        view?.nextButton(enabled: next)
    }
}
