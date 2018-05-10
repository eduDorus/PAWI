//
//  MarbleRunListProtocols.swift
//  ARMarbleRun
//

import Foundation
import UIKit

protocol MarbleRunListWireframeProtocol : class {
    static func createMarbleRunListModule(in mode: ARInteractionMode) -> UIViewController
    func presentARView(from view: MarbleRunListViewProtocol, with marblerun: MarbleRun)
}

protocol MarbleRunListViewProtocol : class {
    var presenter : MarbleRunListPresenterProtocol? { get set }
    func reloadMarbleRunList(with marbleruns: [MarbleRun])
}

protocol MarbleRunListPresenterProtocol : class {
    var view : MarbleRunListViewProtocol? { get set }
    var wireframe : MarbleRunListWireframeProtocol? { get set }
    var interactor : MarbleRunListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func didSelect(marblerun: MarbleRun, on view: MarbleRunListViewProtocol)
}

protocol MarbleRunListInteractorProtocol : class {
    func retrieveMarbleRuns(_ callback: ([MarbleRun]) -> Void)
}

