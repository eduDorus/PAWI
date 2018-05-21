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
}


extension ElementSelectView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCell", for: indexPath)
        if let label = cell.contentView.subviews.first as? UILabel {
            label.text = String(elementList[indexPath.row].type)
        }
        return cell
    }
}

extension ElementSelectView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = elementList[indexPath.row]
        presenter?.didSelect(element: element, on: self)
    }
}
