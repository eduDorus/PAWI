//
//  MarbleRunListPresenter.swift
//  ARMarbleRun
//

import Foundation

class MarbleRunListPresenter : MarbleRunListPresenterProtocol {
    
    var wireframe: MarbleRunListWireframeProtocol?
    weak var view: MarbleRunListViewProtocol?
    var interactor: MarbleRunListInteractorProtocol?

    func viewDidLoad() {
        interactor?.retrieveMarbleRuns { (marbleruns) -> Void in
            view?.reloadMarbleRunList(with: marbleruns)
        }
    }
    
    func didSelect(marblerun: MarbleRunEntity, on view: MarbleRunListViewProtocol) {
        wireframe?.presentARView(from: view, with: marblerun)
    }
}
