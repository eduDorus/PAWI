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
