//
//  AREditorProtocols.swift
//  ARMarbleRun

import Foundation
import UIKit
import ARKit

protocol AREditorWireframeProtocol : class, ARWireframeProtocol {
    static func createAREditorModule(of marblerun: MarbleRunEntity) -> UIViewController
    
    func presentSelectElement(from view: AREditorViewProtocol)
    func presentSelectMode()
    func changeMode(with run: MarbleRunEntity)
}

protocol AREditorViewProtocol : class {
    var presenter : AREditorPresenterProtocol? { get set }
    var subview : ARViewController? { get set }
    
    func elementSelected(element: ElementEntity)
    func initializeMarbleRun()
    func add(element: ElementEntity)
    func add(elements: [ElementEntity])
    func select(at position: Triple<Int, Int, Int>)
    func remove(at position: Triple<Int, Int, Int>)
    
    func toggleAddCancel()
    
    func addBoundingBoxes(at positions: Set<Triple<Int, Int, Int>>)
    func removeBoundingBoxes()
}

protocol AREditorPresenterProtocol : class {
    var view : AREditorViewProtocol? { get set }
    var wireframe : AREditorWireframeProtocol? { get set }
    var interactor : AREditorInteractorProtocol? { get set }
    
    func viewDidLoad()
    func readyForMarbleRun()
    func didPressAddButton(on view: AREditorViewProtocol)
    func didPressCancelButton()
    
    func didPressSaveAction()
    func didPressChangeModeAction(from sceneview: ARSCNView)
    func didPressLeaveAction()
    
    func setNextElement(element: ElementEntity)
    func buildElement(at location: Triple<Int, Int, Int>)
    func removeElement(at location: Triple<Int, Int, Int>)
    func selectElement(element: ElementNode)
    func rotateElement(to direction: RotationDirection)
}

protocol AREditorInteractorProtocol : class {
    var marbleRun : MarbleRunEntity? { get set }
    
    func getPossiblePositions() -> Set<Triple<Int, Int, Int>>
    func buildElement(element: ElementEntity)
    func removeElement(at location: Triple<Int, Int, Int>) -> Bool
    func selectElement(at location: Triple<Int, Int, Int>)
    func rotateElement(to direction: RotationDirection)
    func persist()
    
   func retrieveMarbleRun() -> [ElementEntity]
}

enum RotationDirection {
    case left
    case right
    case up
    case down
}

