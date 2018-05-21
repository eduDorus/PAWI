//
//  ARGuideProtocols.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

protocol ARGuideWireframeProtocol : class, ARWireframeProtocol {
    static func createARGuideModule(of marblerun: MarbleRunEntity) -> UIViewController
    
    func presentSelectMode()
    func changeMode(with run: MarbleRunEntity)
}

protocol ARGuideViewProtocol : class {
    var presenter : ARGuidePresenterProtocol? { get set }
    var subview : ARViewController? { get set }
    
    func initializeMarbleRun()
    func add(element: ElementEntity)
    func add(elements: [ElementEntity])
    func remove(elementAt position: Int)
    func removeAllElements()
    func set(elementAt position: Int, to status: ElementState)
}

protocol ARGuidePresenterProtocol : class {
    var view : ARGuideViewProtocol? { get set }
    var wireframe : ARGuideWireframeProtocol? { get set }
    var interactor : ARGuideInteractorProtocol? { get set }
    
    func viewDidLoad()
    func readyForMarbleRun()
    func didPressNext()
    func didPressPrevious()
    func didPressRestartAction()
    func didPressChangeModeAction(from sceneview: ARSCNView)
    func didPressLeaveAction()
}

protocol ARGuideInteractorProtocol : class {
    var marbleRun : MarbleRunEntity? { get set }
    func resetGuide()
    func nextStep()
    func previousStep()
    func retrieveMarbleRun() -> [ElementEntity]
}
