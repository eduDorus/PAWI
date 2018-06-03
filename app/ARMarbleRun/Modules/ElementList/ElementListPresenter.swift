//
//  ElementListPresenter.swift
//  ARMarbleRun
//

import Foundation

class ElementListPresenter : ElementListPresenterProtocol {
    var wireframe: ElementListWireframeProtocol?
    weak var view: ElementListViewProtocol?
    var interactor: ElementListInteractorProtocol?
    
    func viewDidLoad() {
        let elements = interactor?.getElements()
        view?.reloadElementList(with: elements!)
    }

    func didSelect(element: ElementEntity, on view: ElementListViewProtocol) {
        wireframe?.dismissModule(from: view, with: element)
    }
}
