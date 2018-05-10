//
//  MarbleRunListView.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class MarbleRunListView: UIViewController, MarbleRunListViewProtocol {
    
    var presenter: MarbleRunListPresenterProtocol?
    var marblerunMarbleRunList: [MarbleRun] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - MarbleRunListViewProtocol
    
    func reloadMarbleRunList(with marbleruns: [MarbleRun]) {
        marblerunMarbleRunList = marbleruns
        collectionView.reloadData()
    }
}

extension MarbleRunListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marblerunMarbleRunList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarbleRunCell", for: indexPath)
        if let label = cell.contentView.subviews.first as? UILabel {
            label.text = marblerunMarbleRunList[indexPath.row].name
        }
        return cell
    }
}

extension MarbleRunListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let marblerun = marblerunMarbleRunList[indexPath.row]
        presenter?.didSelect(marblerun: marblerun, on: self)
    }
}
