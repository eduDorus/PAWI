//
//  ARBuilderProtocols.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

protocol ARBuilderWireframeProtocol : class, ARWireframeProtocol {
    static func createARBuilderModule(of marblerun: MarbleRunEntity) -> UIViewController
    
    func presentSelectMode()
    func changeMode(with run: MarbleRunEntity)
}

protocol ARBuilderViewProtocol : class {
    var presenter : ARBuilderPresenterProtocol? { get set }
    var subview : ARViewController? { get set }
    
    func initializeMarbleRun()
    func add(element: ElementEntity)
    func add(elements: [ElementEntity])
    func remove(elementAt position: Int)
    func removeAllElements()
    func set(elementAt position: Int, to status: ElementState)
}

protocol ARBuilderPresenterProtocol : class {
    var view : ARBuilderViewProtocol? { get set }
    var wireframe : ARBuilderWireframeProtocol? { get set }
    var interactor : ARBuilderInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didPressNext()
    func didPressPrevious()
    func didPressRestartAction()
    func didPressChangeModeAction(from sceneview: ARSCNView)
    func didPressLeaveAction()
}

protocol ARBuilderInteractorProtocol : class {
    var marbleRun : MarbleRunEntity? { get set }
    func resetGuide()
    func nextStep()
    func previousStep()
    func retrieveMarbleRun() -> [ElementEntity]
}
