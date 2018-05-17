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
    override var prefersStatusBarHidden: Bool { // TODO: that's not all yet …
        return true
    }
    @IBOutlet var buttonContainer: UIStackView!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func didPressPrevious(_ sender: Any) {
        presenter?.didPressPrevious()
    }
    
    @IBAction func didPressNext(_ sender: Any) {
        presenter?.didPressNext()
    }
    
    @IBAction func didPressMenu(_ sender: Any) {
        presenter?.didPressMenuButton()
        menuAction()
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
                buttonContainer.isHidden = false
                print("here we go")
            }
        } else if state == .runPlacement {
            marbleRun?.toggleConstraints()
        }
    }
    
    @IBAction func menuAction() {
        // Create the action buttons for the alert.
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
                                            // Respond to user selection of the action.
        }
        let changeModeAction = UIAlertAction(title: "Change to Build Mode", style: .default) { (action) in
                                            // Respond to user selection of the action.
        }
        let leaveAction = UIAlertAction(title: "Back to Menu", style: .destructive) { (action) in
                                            // Respond to user selection of the action.
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                                            // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        alert.addAction(saveAction)
        alert.addAction(changeModeAction)
        alert.addAction(leaveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }

}

enum ARBuilderState {
    case planeSelection
    case runPlacement
    case buildProcess
}
