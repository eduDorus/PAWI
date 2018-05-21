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
    
    @IBAction func guideButtonPressed(_ sender: UIButton) {
        presenter?.didPressGuideButton(on: self)
    }
}
