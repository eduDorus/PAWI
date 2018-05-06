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
    var presenter: ListPresenterProtocol?
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarblerunCell", for: indexPath)
        return cell
    }
}
