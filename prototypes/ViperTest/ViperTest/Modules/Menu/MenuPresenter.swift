//
//  MenuPresenter.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class MenuPresenter : MenuPresenterProtocol {
    var wireframe: MenuWireframeProtocol?
    weak var view: MenuViewProtocol?

    func didPressBuilderButton(on view: MenuViewProtocol) {
        wireframe?.presentListView(from: view, with: .builder)
    }
    
    func didPressEditorButton(on view: MenuViewProtocol) {
        wireframe?.presentListView(from: view, with: .editor)
    }
}
