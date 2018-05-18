//
//  ElementSelectPresenter.swift
//  ARMarbleRun
//

import Foundation

class ElementSelectPresenter : ElementSelectPresenterProtocol {
    var wireframe: ElementSelectWireframeProtocol?
    weak var view: ElementSelectViewProtocol?
    var interactor: ElementSelectInteractorProtocol?
    
    func viewDidLoad() {
    }

    func didSelectElement(id type: Int) -> Int {
        // TODO: Return with elementtype
        return 0
    }
    
    func didPressBackButton() {
        // TODO: Hide view
    }
}
