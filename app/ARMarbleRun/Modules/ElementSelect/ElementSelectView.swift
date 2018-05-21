//
//  ElementSelectView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ElementSelectView : UIViewController, ElementSelectViewProtocol {
    var presenter: ElementSelectPresenterProtocol?
    var elementList: [ElementEntity] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - ElementSelectViewProtocol
    
    func reloadElementList(with elements: [ElementEntity]) {
        elementList = elements
        collectionView.reloadData()
    }
    
    // MARK: - ElementSelectViewProtocol

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
