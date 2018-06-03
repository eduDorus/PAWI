//
//  ElementListProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol ElementListWireframeProtocol : class {
    static func createElementListModule() -> UIViewController
    func dismissModule(from view: ElementListViewProtocol, with element: ElementEntity)
}

protocol ElementListViewProtocol : class {
    var presenter : ElementListPresenterProtocol? { get set }
    
    func reloadElementList(with elements: [ElementEntity])
}

protocol ElementListPresenterProtocol : class {
    var view : ElementListViewProtocol? { get set }
    var wireframe : ElementListWireframeProtocol? { get set }
    var interactor : ElementListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(element: ElementEntity, on view: ElementListViewProtocol)
}

protocol ElementListInteractorProtocol : class {
    func getElements() -> [ElementEntity]
}

