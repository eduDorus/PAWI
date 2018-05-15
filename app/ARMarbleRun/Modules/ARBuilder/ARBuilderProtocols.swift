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
    func changeMode(with view: ARSCNView)
}

protocol ARBuilderViewProtocol : class {
    var presenter : ARBuilderPresenterProtocol? { get set }
    
    func add(element: MarbleRunElement)
    func add(elements: [MarbleRunElement])
    func remove(elementAt position: Int)
    func removeAllElements()
    func set(elementAt position: Int, to status: ElementStatus)
}

protocol ARBuilderPresenterProtocol : class {
    var view : ARBuilderViewProtocol? { get set }
    var wireframe : ARBuilderWireframeProtocol? { get set }
    var interactor : ARBuilderInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didPressMenuButton()
    func didPressNext()
    func didPressPrevious()
    func didPressRestartAction()
}

protocol ARBuilderInteractorProtocol : class {
    func nextBuildingStep()
    func previousBuildingStep()
}
