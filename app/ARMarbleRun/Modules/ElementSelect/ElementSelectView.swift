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
    
    
    
    // MARK: - ElementSelectViewProtocol
    
    func add(elements: [ElementEntity]) {
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
