//
//  ElementSelectProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol ElementSelectWireframeProtocol : class, ARWireframeProtocol {
    static func createElementSelectModule(of marblerun: MarbleRunEntity) -> UICollectionViewController
    
    func presentSelectElement()
    func presentSelectMode()
    func changeMode(with view: ARSCNView)
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
    func didPressElement()
    func didPressCancelButton()
    func didPressGoToLaunchscreen()
}

protocol ElementSelectInteractorProtocol : class {
    func getElements()
}

