//
//  SelectModeView.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class SelectModeView : UIViewController, SelectModeViewProtocol {
    
    var presenter: SelectModePresenterProtocol?

    // MARK: - IBActions
    
    @IBAction func editorButtonPressed(_ sender: UIButton) {
        presenter?.didPressEditorButton(on: self)
    }
    
    @IBAction func builderButtonPressed(_ sender: UIButton) {
        presenter?.didPressBuilderButton(on: self)
    }
}
