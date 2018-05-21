//
//  SelectModePresenter.swift
//  ARMarbleRun
//

import Foundation

class SelectModePresenter : SelectModePresenterProtocol {
    
    var wireframe: SelectModeWireframeProtocol?
    weak var view: SelectModeViewProtocol?

    func didPressGuideButton(on view: SelectModeViewProtocol) {
        wireframe?.presentMarbleRunListView(from: view, with: .builder)
    }
    
    func didPressEditorButton(on view: SelectModeViewProtocol) {
        wireframe?.presentMarbleRunListView(from: view, with: .editor)
    }
}
