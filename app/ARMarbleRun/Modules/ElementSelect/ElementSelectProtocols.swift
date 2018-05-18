//
//  ElementSelectProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol ElementSelectWireframeProtocol : class {
    static func createElementSelectModule() -> UICollectionViewController
    func dismissModule(form view: ElementSelectViewProtocol, with type: Int)
}

protocol ElementSelectViewProtocol : class {
    var presenter : ElementSelectPresenterProtocol? { get set }
    
    func add(elements: [ElementEntity])
}

protocol ElementSelectPresenterProtocol : class {
    var view : ElementSelectViewProtocol? { get set }
    var wireframe : ElementSelectWireframeProtocol? { get set }
    var interactor : ElementSelectInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelectElement(id type: Int) -> Int
}

protocol ElementSelectInteractorProtocol : class {
    func getElements() -> [Int]
}

