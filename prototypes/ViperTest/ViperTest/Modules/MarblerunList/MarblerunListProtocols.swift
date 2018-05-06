//
//  MarblerunListProtocols.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

protocol MarblerunListWireframeProtocol : class {
    static func createMarblerunListModule(in mode: ARInteractionMode) -> UIViewController
    func presentARView(with marblerun: Marblerun)
}

protocol MarblerunListViewProtocol : class {
    var presenter : MarblerunListPresenterProtocol? { get set }
    func reloadMarblerunList(with marbleruns: [Marblerun])
}

protocol MarblerunListPresenterProtocol : class {
    var view : MarblerunListViewProtocol? { get set }
    var wireframe : MarblerunListWireframeProtocol? { get set }
    var interactor : MarblerunListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(marblerun: Marblerun)
}

protocol MarblerunListInteractorProtocol : class {
    func retrieveMarbleruns(_ callback: ([Marblerun]) -> Void)
}

