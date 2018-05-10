//
//  ARBuilderView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARBuilderView : UIViewController, ARBuilderViewProtocol {
    
    var presenter: ARBuilderPresenterProtocol?
    
    // MARK: - IBActions
    
    @IBAction func didPressPrevious(_ sender: Any) {
        presenter?.didPressPrevious()
    }
    
    @IBAction func didPressNext(_ sender: Any) {
        presenter?.didPressNext()
    }
    
    // MARK: - ARBuilderViewProtocol

    func add(element: MarbleRunElement) {
    }
    
    func add(elements: [MarbleRunElement]) {
    }
    
    func remove(elementAt position: Int) {
    }
    
    func removeAllElements() {
    }
    
    func set(elementAt position: Int, to status: ElementStatus) {
    }
}
