//
//  MarbleRunListProtocols.swift
//  ARMarbleRun
//

import Foundation
import UIKit

protocol MarbleRunListWireframeProtocol : class {
    static func createMarbleRunListModule(in mode: ARInteractionMode) -> UIViewController
    func presentARView(from view: MarbleRunListViewProtocol, with marblerun: MarbleRunEntity)
}

protocol MarbleRunListViewProtocol : class {
    var presenter : MarbleRunListPresenterProtocol? { get set }
    var canAddNew : Bool { get set }
    
    func reloadMarbleRunList(with marbleruns: [MarbleRunEntity])
}

protocol MarbleRunListPresenterProtocol : class {
    var view : MarbleRunListViewProtocol? { get set }
    var wireframe : MarbleRunListWireframeProtocol? { get set }
    var interactor : MarbleRunListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(marblerun: MarbleRunEntity, on view: MarbleRunListViewProtocol)
    func didSelectNew(with name: String, on view: MarbleRunListViewProtocol)
}

protocol MarbleRunListInteractorProtocol : class {
    func retrieveMarbleRuns(_ callback: ([MarbleRunEntity]) -> Void)
    func createNewMarbleRun(with name: String) -> MarbleRunEntity
}

