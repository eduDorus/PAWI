//
//  ListView.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

class ListView: UIViewController, ListViewProtocol {
    @IBOutlet var collectionView: UICollectionView!
    var presenter: ListPresenterProtocol?
    var marblerunList: [Marblerun] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func reloadList(with marbleruns: [Marblerun]) {
        marblerunList = marbleruns
        collectionView.reloadData()
    }
}

extension ListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marblerunList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarblerunCell", for: indexPath)
        if let label = cell.contentView.subviews.first as? UILabel {
            label.text = marblerunList[indexPath.row].name
        }
        return cell
    }
}

extension ListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let marblerun = marblerunList[indexPath.row]
        presenter?.didSelect(marblerun: marblerun)
    }
}
