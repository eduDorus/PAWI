//
//  ListProtocols.swift
//  ViperTest
//
//  Created by Lucas Schnüriger on 06.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import UIKit

protocol ListWireframeProtocol : class {
    static func createListModule(in mode: ARInteractionMode) -> UIViewController
    func presentARView(with marblerun: Marblerun)
}

protocol ListViewProtocol : class {
    var presenter : ListPresenterProtocol? { get set }
    func reloadList(with marbleruns: [Marblerun])
}

protocol ListPresenterProtocol : class {
    var view : ListViewProtocol? { get set }
    var wireframe : ListWireframeProtocol? { get set }
    var interactor : ListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(marblerun: Marblerun)
}

protocol ListInteractorProtocol : class {
    func retrieveMarbleruns(_ callback: ([Marblerun]) -> Void)
}

