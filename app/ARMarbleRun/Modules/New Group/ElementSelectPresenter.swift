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

}
