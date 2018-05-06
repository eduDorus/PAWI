//
//  SelectModePresenter.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation

class SelectModePresenter : SelectModePresenterProtocol {
    var wireframe: SelectModeWireframeProtocol?
    weak var view: SelectModeViewProtocol?

    func didPressBuilderButton(on view: SelectModeViewProtocol) {
        wireframe?.presentMarblerunListView(from: view, with: .builder)
    }
    
    func didPressEditorButton(on view: SelectModeViewProtocol) {
        wireframe?.presentMarblerunListView(from: view, with: .editor)
    }
}
