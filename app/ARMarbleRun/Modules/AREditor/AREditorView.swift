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
    var status = EditorStatus.show
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - IBActions
    
    @IBAction func didPressCancel(_ sender: Any) {
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        
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

    // Tap gestures
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
        let tapLocation = recognizer.location(in: subview?.sceneView)
        let hitTestResults = subview?.sceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults?.first?.node else {return}
        
        if let element = node as? ElementNode {
            presenter?.selectElement(at: element.getLocation())
        }
        
        if let boundingBox = node as? BoundingBoxNode {
            presenter?.buildElement(at: boundingBox.getLocation())
        }
    }
    
    @objc
    func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let longPressLocation = recognizer.location(in: subview?.sceneView)
        let hitTestResults = subview?.sceneView.hitTest(longPressLocation)
        
        guard let node = hitTestResults?.first?.node else { return }
        
        // TODO: Test if not in add mode
        if let element = node as? ElementNode {
            presenter?.removeElement(at: element.getLocation())
        }
    }
    
    @objc
    func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        let currentAngle = subview?.sceneView.session.currentFrame?.camera.eulerAngles.y
        
        if gesture.direction == .right {
            presenter?.rotateElement(to: .right)
        }
        else if gesture.direction == .left {
            presenter?.rotateElement(to: .left)
        }
        else if gesture.direction == .up {
            presenter?.rotateElement(to: .up)
        }
        else if gesture.direction == .down {
            presenter?.rotateElement(to: .down)
        }
    }
    
    // MARK: - AREditorViewProtocol

    func addElement(type: Int, at position: Triple<Int, Int, Int>) {
        marbleRun?.addElement(type: type, location: position)
    }
    
    func selectElement(at position: Triple<Int, Int, Int>) {
        // TODO: Unhighlight the previouse selected
        let element = marbleRun?.getElement(at: position)
        element?.set(state: .highlighted)
    }
    
    func removeElement(at position: Triple<Int, Int, Int>) {
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
    
    
}

enum EditorStatus {
    case show
    case build
}

