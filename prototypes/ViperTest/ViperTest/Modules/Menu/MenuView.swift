//
//  MenuView.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

class MenuView : UIViewController, MenuViewProtocol {
    var presenter: MenuPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editorButtonPressed(_ sender: UIButton) {
        presenter?.didPressEditorButton(on: self)
    }
    
    @IBAction func builderButtonPressed(_ sender: UIButton) {
        presenter?.didPressBuilderButton(on: self)
    }
}
