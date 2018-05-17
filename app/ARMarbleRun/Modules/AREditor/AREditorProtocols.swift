//
//  AREditorProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol AREditorWireframeProtocol : class, ARWireframeProtocol {
    static func createAREditorModule(of marblerun: MarbleRunEntity) -> UIViewController
    
    func presentSelectElement()
    func presentSelectMode()
    func changeMode(with view: ARSCNView)
}

protocol AREditorViewProtocol : class {
    var presenter : AREditorPresenterProtocol? { get set }
    
    func add(element: ElementEntity)
    func add(elements: [ElementEntity])
    func remove(elementAt position: Int)
    func removeAllElements()
    func removeAllElemetns(with status: ElementState)
    func set(elementAt position: Int, to status: ElementState)
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
    func didPressGoToLaunchscreen()
    func didPressSaveAction()
    
    func buildElement(at location: Triple<Int, Int, Int>)
    func removeElement(at location: Triple<Int, Int, Int>)
    func selectElement(at location: Triple<Int, Int, Int>)
    func rotateElement(to direction: RotationDirection)
}

protocol AREditorInteractorProtocol : class {
    func getPossiblePositions() -> Set<Triple<Int, Int, Int>>
    func buildElement(at location: Triple<Int, Int, Int>)
    func removeElement(at location: Triple<Int, Int, Int>)
    func selectElement(at location: Triple<Int, Int, Int>)
    func rotateElement(to direction: RotationDirection)
    func persist()
}

enum RotationDirection {
    case left
    case right
    case up
    case down
}

