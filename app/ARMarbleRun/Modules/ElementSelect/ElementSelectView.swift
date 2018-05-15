//
//  ElementSelectView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ElementSelectView : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ElementSelectViewProtocol {
    
    var presenter: ElementSelectPresenterProtocol?
    
    // MARK: - IBActions
    
    @IBAction func pressedCancel(_ sender: Any) {
    }
    
    @IBAction func pressedAdd(_ sender: Any) {
    }
    
    // MARK: - ElementSelectViewProtocol
    
    func add(element: ElementEntity) {
    }
    
    func add(elements: [ElementEntity]) {
    }
    
    func remove(elementAt position: Int) {
    }
    
    func removeAllElements() {
    }
    
    func set(elementAt position: Int, to status: ElementState) {
    }
    
    func set(elementAt position: Int, to orientation: Int) {
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
