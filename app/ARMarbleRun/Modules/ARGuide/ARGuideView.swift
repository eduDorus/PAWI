//
//  ARGuideView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class ARGuideView : UIViewController, ARGuideViewProtocol, ARSCNViewDelegate {

    var presenter: ARGuidePresenterProtocol?
    var subview: ARViewController?
    var marbleRun: MarbleRunNode?
    var state : ARModeState = .planeSelection
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var startButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func didPressPrevious(_ sender: Any) {
        presenter?.didPressPrevious()
    }
    
    @IBAction func didPressNext(_ sender: Any) {
        presenter?.didPressNext()
    }
    
    @IBAction func didPressMenu(_ sender: Any) {
        menuAction()
    }
    
    @IBAction func didPressStart(_ sender: Any) {
        presenter?.didPressStart()
        state = .buildProcess
        startButton.isHidden = true
        previousButton.isHidden = false
        nextButton.isHidden = false
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
    
    // MARK: - ARGuideViewProtocol
    
    func initializeMarbleRun() {
        marbleRun = MarbleRunNode()
        subview?.sceneView.scene.rootNode.addChildNode(marbleRun!)
        marbleRun!.constraintToCamera()
        updateMarbleRunPosition()
        subview?.sceneView.delegate = self
    }

    func add(element: ElementEntity) {
        marbleRun?.addChildNode(ElementNode(type: element.type, location: element.location))
    }
    
    func add(elements: [ElementEntity]) {
        for e in elements {
            add(element: e)
        }
    }
    
    func remove(elementAt position: Triple<Int, Int, Int>) {
    }
    
    func removeAllElements() {
    }
    
    func set(elementAt position: Triple<Int, Int, Int>, to state: ElementState) {
        if let element = marbleRun?.getElement(at: position) {
            element.set(state: state)
        }
    }
    
    func setRun(to state: ElementState) {
        marbleRun?.setRun(to: state)
    }
    
    func previousButton(enabled: Bool) {
        previousButton.isEnabled = enabled
    }
    
    func nextButton(enabled: Bool) {
        nextButton.isEnabled = enabled
    }
    
    // MARK: - Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case .planeSelection:
            let touch = touches.first!
            let location = touch.location(in: subview?.sceneView)
            if subview!.selectExistingPlane(location: location) {
                state = .runPlacement(.unlocked)
                startButton.isHidden = false
                startButton.isEnabled = false
                presenter?.readyForMarbleRun()
            }
        case .runPlacement(.unlocked):
            marbleRun?.removeConstraints()
            startButton.isEnabled = true
            state = .runPlacement(.locked)
        case .runPlacement(.locked):
            marbleRun?.constraintToCamera()
            startButton.isEnabled = false
            state = .runPlacement(.unlocked)
        default: break
        }
    }
    
    func menuAction() {
        // Create the action buttons for the alert.
        let restartAction = UIAlertAction(title: "Restart Guide", style: .default) { (action) in
            self.presenter?.didPressRestartAction()
        }
        let changeModeAction = UIAlertAction(title: "Change to Editor", style: .default) { (action) in
            if let sceneView = self.subview?.sceneView {
                self.presenter?.didPressChangeModeAction(from: sceneView)
            }
        }
        let leaveAction = UIAlertAction(title: "Leave", style: .destructive) { (action) in
            self.presenter?.didPressLeaveAction()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        alert.addAction(restartAction)
        alert.addAction(changeModeAction)
        alert.addAction(leaveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func updateMarbleRunPosition() {
        if let hitResult = subview?.hitTestCenter() {
            let coords = hitResult.worldTransform.columns.3
            marbleRun?.set(position: SCNVector3(coords.x, coords.y, coords.z))
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        switch state {
        case .runPlacement(.unlocked):
            updateMarbleRunPosition()
        default: return
        }
    }
}
