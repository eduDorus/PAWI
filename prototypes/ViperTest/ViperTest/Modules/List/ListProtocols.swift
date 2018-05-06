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
    func presentARView()
    func presentMenuView()
}

protocol ListViewProtocol : class {
    var presenter : ListPresenterProtocol? { get set }
}

protocol ListPresenterProtocol : class {
    var view : ListViewProtocol? { get set }
    var wireframe : ListWireframeProtocol? { get set }
    var interactor : ListInteractorProtocol? { get set }
    
    func didSelectMarblerun()
}

protocol ListInteractorProtocol : class {
    func retrieveMarbleruns(for closure: ())
}

