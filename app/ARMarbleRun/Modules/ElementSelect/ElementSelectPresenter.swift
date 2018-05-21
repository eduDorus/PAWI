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
        let elements = interactor?.getElements()
        view?.reloadElementList(with: elements!)
    }

    func didSelect(element: ElementEntity, on view: ElementSelectViewProtocol) {
        wireframe?.dismissModule(from: view, with: element)
    }
}
