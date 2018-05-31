//
//  AREditorView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class AREditorView : UIViewController, AREditorViewProtocol, ARSCNViewDelegate {

    var presenter: AREditorPresenterProtocol?
    var subview: ARViewController?
    var marbleRun: MarbleRunNode?
    var state : ARModeState = .planeSelection
    var marbleRunAngle : Float = 0.0
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    // MARK: - IBActions
    
    @IBAction func didPressCancel(_ sender: Any) {
        cancelButton.isHidden = true
        addButton.isHidden = false
        presenter?.didPressCancelButton()
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        presenter?.didPressAddButton(on: self)
    }
    
    @IBAction func didPressMenu(_ sender: Any) {
        menuAction()
    }
    
    @IBAction func didPressStart(_ sender: Any) {
        state = .editorMode
        startButton.isHidden = true
        startButton.isEnabled = false
        addButton.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add functionality
        addTapGestureToSceneView()
        addLongTapGestureToSceneView()
        addSwipeGestureToSceneView()
        
        presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ARViewController, segue.identifier == "ARSCNViewSegue" {
            self.subview = vc
        }
    }
    
    func toggleAddCancel() {
        addButton.isHidden = !addButton.isHidden
        cancelButton.isHidden = !cancelButton.isHidden
    }

    // MARK: - Tap Gestures

    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        subview?.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addLongTapGestureToSceneView() {
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        subview?.sceneView.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    func addSwipeGestureToSceneView() {
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeRightGesture.direction = .right
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeLeftGesture.direction = .left
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeUpGesture.direction = .up
        
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeDownGesture.direction = .down
        
        subview?.sceneView.addGestureRecognizer(swipeLeftGesture)
        subview?.sceneView.addGestureRecognizer(swipeRightGesture)
        subview?.sceneView.addGestureRecognizer(swipeUpGesture)
        subview?.sceneView.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        switch state {
        case .planeSelection:
            let location = recognizer.location(in: subview?.sceneView)
            if subview!.selectExistingPlane(location: location) {
                state = .runPlacement(.unlocked)
                presenter?.readyForMarbleRun()
                startButton.isHidden = false
            }
            
        case .runPlacement(.unlocked):
            marbleRun?.removeConstraints()
            marbleRunAngle = subview?.sceneView.session.currentFrame?.camera.eulerAngles.y ?? 0.0
            state = .runPlacement(.locked)
            startButton.isEnabled = true
            
        case .runPlacement(.locked):
            marbleRun?.constraintToCamera()
            state = .runPlacement(.unlocked)
            startButton.isEnabled = false
            
        case .editorMode:
            selectElement(recognizer)
            
        default: return
        }
    }

    private func selectElement(_ recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: subview?.sceneView)
        let hitTestResults = subview?.sceneView.hitTest(tapLocation)

        guard let node = hitTestResults?.first?.node else {
            presenter?.unselectElement()
            return
        }

        if let element = node as? ElementNode {
            presenter?.selectElement(at: element.location)
        } else if let element = node.parent as? ElementNode {
            presenter?.selectElement(at: element.location)
        } else if let boundingBox = node as? BoundingBoxNode {
            presenter?.buildElement(at: boundingBox.getLocation())
        } else {
            presenter?.unselectElement()
        }
    }

    @objc
    func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let longPressLocation = recognizer.location(in: subview?.sceneView)
        let hitTestResults = subview?.sceneView.hitTest(longPressLocation)
        
        guard let node = hitTestResults?.first?.node else { return }
        
        if let element = node as? ElementNode {
            presenter?.removeElement(at: element.getLocation())
        } else if let element = node.parent as? ElementNode {
            presenter?.removeElement(at: element.getLocation())
        }
    }
    
    @objc
    func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        if var cameraAngle = subview?.sceneView.session.currentFrame?.camera.eulerAngles.y {
            cameraAngle = (cameraAngle - marbleRunAngle).truncatingRemainder(dividingBy: Float.pi)
            presenter?.rotateElement(to: gesture.direction, with: cameraAngle)
        }
    }

    func rotate(at position: Triple<Int, Int, Int>, rotation: SCNVector3) {
        if let element = marbleRun?.getElement(at: position) {
            if element.hasActions { return }
            let action = SCNAction.rotate(by: .pi/2, around: rotation, duration: 0.2)
            element.runAction(action, forKey: "rotate")
        }
    }

    // MARK: - AREditorViewProtocol
    
    func elementSelected(element: ElementEntity) {
        toggleAddCancel()
        presenter?.setNextElement(element: element)
    }

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
    
    func select(at position: Triple<Int, Int, Int>) {
        let element = marbleRun?.getElement(at: position)
        element?.set(state: .highlighted)
    }
    
    func unselect(at position: Triple<Int, Int, Int>) {
        let element = marbleRun?.getElement(at: position)
        element?.set(state: .normal)
    }
    
    func remove(at position: Triple<Int, Int, Int>) {
        marbleRun?.removeElement(at: position)
    }
    
    func addBoundingBoxes(at positions: Set<Triple<Int, Int, Int>>) {
        for position in positions {
            marbleRun?.addBoundingBox(location: position)
        }
    }
    
    func removeBoundingBoxes() {
        marbleRun?.removeBoundingBoxes()
    }
    
    // MARK: - Menu Action
    
    func menuAction() {
        // Create the action buttons for the alert.
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            self.presenter?.didPressSaveAction()
        }
        let changeModeAction = UIAlertAction(title: "Change to Guide", style: .default) { (action) in
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
        alert.addAction(saveAction)
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
