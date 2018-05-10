//
//  AREditorProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol AREditorWireframeProtocol : class, ARWireframeProtocol {
    static func createAREditorModule(of marblerun: MarbleRun) -> UIViewController
    
    func presentSelectElement()
    func presentSelectMode()
    func changeMode(with view: ARSCNView)
}

protocol AREditorViewProtocol : class {
    var presenter : AREditorPresenterProtocol? { get set }
    
    func add(element: MarbleRunElement)
    func add(elements: [MarbleRunElement])
    func remove(elementAt position: Int)
    func removeAllElements()
    func set(elementAt position: Int, to status: ElementStatus)
    func set(elementAt position: Int, to orientation: Int)
}

protocol AREditorPresenterProtocol : class {
    var view : AREditorViewProtocol? { get set }
    var wireframe : AREditorWireframeProtocol? { get set }
    var interactor : AREditorInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didPressMenuButton()
    func didPressAddButton()
    func didPressCancelButton()
    func didPressSaveAction(with marblerun: MarbleRun)
}

protocol AREditorInteractorProtocol : class {
    func persist(marblerun: MarbleRun)
}

