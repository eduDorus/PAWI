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
    func changeMode(with run: MarbleRunEntity?)
}

protocol AREditorViewProtocol : class {
    var presenter : AREditorPresenterProtocol? { get set }
    var subview : ARViewController? { get set }
    
    func addElement(type: Int, at position: Triple<Int, Int, Int>)
    func selectElement(at position: Triple<Int, Int, Int>)
    func removeElement(at position: Triple<Int, Int, Int>)
    
    func addBoundingBoxes(at positions: Set<Triple<Int, Int, Int>>)
    func removeBoundingBoxes()
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
    func buildElement(type: Int, at location: Triple<Int, Int, Int>)
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

