//
//  MarblerunListView.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

class MarblerunListView: UIViewController, MarblerunListViewProtocol {
    @IBOutlet var collectionView: UICollectionView!
    var presenter: MarblerunListPresenterProtocol?
    var marblerunMarblerunList: [Marblerun] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func reloadMarblerunList(with marbleruns: [Marblerun]) {
        marblerunMarblerunList = marbleruns
        collectionView.reloadData()
    }
}

extension MarblerunListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marblerunMarblerunList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarblerunCell", for: indexPath)
        if let label = cell.contentView.subviews.first as? UILabel {
            label.text = marblerunMarblerunList[indexPath.row].name
        }
        return cell
    }
}

extension MarblerunListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let marblerun = marblerunMarblerunList[indexPath.row]
        presenter?.didSelect(marblerun: marblerun)
    }
}
