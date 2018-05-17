//
//  ARBuilderView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARBuilderView : UIViewController, ARBuilderViewProtocol, ARSCNViewDelegate {
    
    var presenter: ARBuilderPresenterProtocol?
    var sceneView: ARSCNView?
    var marbleRun: MarbleRunNode?
    
    // MARK: - IBActions
    
    @IBAction func didPressPrevious(_ sender: Any) {
        presenter?.didPressPrevious()
    }
    
    @IBAction func didPressNext(_ sender: Any) {
        presenter?.didPressNext()
    }
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ARViewController, segue.identifier == "ARSCNViewSegue" {
            self.sceneView = vc.sceneView
            self.sceneView?.delegate = self
        }
    }
    
    // MARK: - ARBuilderViewProtocol
    
    func initializeMarbleRun() {
        marbleRun = MarbleRunNode()
        sceneView?.scene.rootNode.addChildNode(marbleRun!)
    }

    func add(element: ElementEntity) {
        marbleRun?.addChildNode(ElementNode(id: element.id, location: element.location))
    }
    
    func add(elements: [ElementEntity]) {
        for e in elements {
            add(element: e)
        }
    }
    
    func remove(elementAt position: Int) {
    }
    
    func removeAllElements() {
    }
    
    func set(elementAt position: Int, to status: ElementState) {
    }
}
