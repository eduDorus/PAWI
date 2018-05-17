//
//  ARBuilderPresenter.swift
//  ARMarbleRun
//

import Foundation

class ARBuilderPresenter : ARBuilderPresenterProtocol {
    
    var wireframe: ARBuilderWireframeProtocol?
    weak var view: ARBuilderViewProtocol?
    var interactor: ARBuilderInteractorProtocol?
    
    func viewDidLoad() {
        let mr = interactor?.retrieveMarbleRun()
        view?.add(elements: mr!)  // WTF? why optional
    }
    
    func didPressMenuButton() {
    }
    
    func didPressNext() {
        interactor?.nextBuildingStep()
    }
    
    func didPressPrevious() {
        interactor?.previousBuildingStep()
    }
    
    func didPressRestartAction() {
    }
    
    
}
