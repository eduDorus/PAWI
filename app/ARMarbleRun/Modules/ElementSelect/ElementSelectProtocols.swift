//
//  ElementSelectProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol ElementSelectWireframeProtocol : class {
    static func createElementSelectModule() -> UIViewController
    func dismissModule(from view: ElementSelectViewProtocol, with element: ElementEntity)
}

protocol ElementSelectViewProtocol : class {
    var presenter : ElementSelectPresenterProtocol? { get set }
    
    func reloadElementList(with elements: [ElementEntity])
}

protocol ElementSelectPresenterProtocol : class {
    var view : ElementSelectViewProtocol? { get set }
    var wireframe : ElementSelectWireframeProtocol? { get set }
    var interactor : ElementSelectInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(element: ElementEntity, on view: ElementSelectViewProtocol)
}

protocol ElementSelectInteractorProtocol : class {
    func getElements() -> [ElementEntity]
}

