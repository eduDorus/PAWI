//
//  ElementListView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ElementListView : UIViewController, ElementListViewProtocol {
    var presenter: ElementListPresenterProtocol?
    var elementList: [ElementEntity] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - ElementListViewProtocol
    
    func reloadElementList(with elements: [ElementEntity]) {
        elementList = elements
        collectionView.reloadData()
    }
}


extension ElementListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elementList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementCell", for: indexPath)
        if let label = cell.contentView.subviews[0] as? UILabel {
            label.text = String(elementList[indexPath.row].type)
        }
        if let image = cell.contentView.subviews[1] as? UIImageView {
            image.image = elementList[indexPath.row].image
        }
        return cell
    }
}

extension ElementListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = elementList[indexPath.row]
        presenter?.didSelect(element: element, on: self)
    }
}
