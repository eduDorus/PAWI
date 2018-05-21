//
//  MarbleRunListView.swift
//  ARMarbleRun
//

import Foundation
import UIKit

class MarbleRunListView: UIViewController, MarbleRunListViewProtocol {
    
    var presenter: MarbleRunListPresenterProtocol?
    var marblerunMarbleRunList: [MarbleRunEntity] = []
    var canAddNew: Bool = false
    
    // MARK: - IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: - MarbleRunListViewProtocol
    
    func reloadMarbleRunList(with marbleruns: [MarbleRunEntity]) {
        marblerunMarbleRunList = marbleruns
        collectionView.reloadData()
    }
    
    private func showNewDialogue() {
        let alert = UIAlertController(title: "Create new Marble Run", message: "Enter the name of your new Marble Run below.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
            if let text = alert.textFields![0].text {
                self.presenter?.didSelectNew(with: text, on: self)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField()
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MarbleRunListView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = marblerunMarbleRunList.count
        if canAddNew { count += 1 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var index = indexPath.row
        if canAddNew { index -= 1}
        if canAddNew && indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewRunCell", for: indexPath)
            if let label = cell.contentView.subviews.first as? UILabel {
                label.text = "Create new!"
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarbleRunCell", for: indexPath)
            if let label = cell.contentView.subviews.first as? UILabel {
                label.text = marblerunMarbleRunList[index].name
            }
            return cell
        }
    }
}

extension MarbleRunListView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var index = indexPath.row
        if canAddNew { index -= 1}
        if canAddNew && indexPath.row == 0 {
            showNewDialogue()
        } else {
            let marblerun = marblerunMarbleRunList[index]
            presenter?.didSelect(marblerun: marblerun, on: self)
        }
    }
}
