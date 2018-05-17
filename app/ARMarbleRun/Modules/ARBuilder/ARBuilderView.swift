//
//  ARBuilderView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARBuilderView : UIViewController, ARBuilderViewProtocol, ARSCNViewDelegate {
    
    var presenter: ARBuilderPresenterProtocol?
    var subview: ARViewController?
    var marbleRun: MarbleRunNode?
    var state = ARBuilderState.planeSelection
    
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
            self.subview = vc
            //self.sceneView?.delegate = self
        }
    }
    
    // MARK: - ARBuilderViewProtocol
    
    func initializeMarbleRun() {
        marbleRun = MarbleRunNode()
        subview?.sceneView.scene.rootNode.addChildNode(marbleRun!)
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
    
    // MARK: - Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .planeSelection {
            let touch = touches.first!
            let location = touch.location(in: subview?.sceneView)
            if subview!.selectExistingPlane(location: location) {
                state = .runPlacement
                print("here we go")
            }
        } else if state == .runPlacement {
            marbleRun?.toggleConstraints()
        }
    }

}

enum ARBuilderState {
    case planeSelection
    case runPlacement
    case buildProcess
}
