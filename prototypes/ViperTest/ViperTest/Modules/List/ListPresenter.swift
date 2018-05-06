//
//  ListPresenter.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class ListPresenter : ListPresenterProtocol {
    var wireframe: ListWireframeProtocol?
    var view: ListViewProtocol?
    var interactor: ListInteractorProtocol?

    func viewDidLoad() {
        interactor?.retrieveMarbleruns { (marbleruns) -> Void in
            view?.reloadList(with: marbleruns)
        }
    }
    
    func didSelectMarblerun() {
    }
}
