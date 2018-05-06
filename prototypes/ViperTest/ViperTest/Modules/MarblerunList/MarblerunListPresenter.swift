//
//  MarblerunListPresenter.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class MarblerunListPresenter : MarblerunListPresenterProtocol {
    var wireframe: MarblerunListWireframeProtocol?
    var view: MarblerunListViewProtocol?
    var interactor: MarblerunListInteractorProtocol?

    func viewDidLoad() {
        interactor?.retrieveMarbleruns { (marbleruns) -> Void in
            view?.reloadMarblerunList(with: marbleruns)
        }
    }
    
    func didSelect(marblerun: Marblerun) {
        wireframe?.presentARView(with: marblerun)
    }
}
