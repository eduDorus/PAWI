//
//  AREditorView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class AREditorView : UIViewController, AREditorViewProtocol {
    
    
    var presenter: AREditorPresenterProtocol?
    
    // MARK: - IBActions
    
    @IBAction func didPressCancel(_ sender: Any) {
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
    }
    
    // MARK: - AREditorViewProtocol

    func add(element: ElementEntity) {
        
    }
    
    func add(elements: [ElementEntity]) {
        
    }
    
    func remove(elementAt position: Int) {
        
    }
    
    func removeAllElements() {
        
    }
    
    func removeAllElemetns(with status: ElementState) {
        
    }
    
    func set(elementAt position: Int, to status: ElementState) {
        
    }
    
    func set(elementAt position: Int, to orientation: Int) {
        
    }
}
