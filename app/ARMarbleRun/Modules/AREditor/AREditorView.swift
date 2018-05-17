//
//  AREditorView.swift
//  ARMarbleRun
//

import Foundation
import UIKit
import ARKit

class AREditorView : UIViewController, AREditorViewProtocol {
    
    @IBOutlet weak var sceneView: ARSCNView!
    var status: EditorStatus = .show
    var marbleRun: MarbleRunNode = MarbleRunNode.init()

    
    var presenter: AREditorPresenterProtocol?
    
    // MARK: - IBActions
    
    @IBAction func didPressCancel(_ sender: Any) {
    }
    
    @IBAction func didPressAdd(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        //sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions  = [.showConstraints, .showLightExtents, ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Set a new scene to the view
        sceneView.scene = SCNScene()
        
        // Set lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        // Add functionality
        addTapGestureToSceneView()
        addLongTapGestureToSceneView()
        addSwipeGestureToSceneView()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // Tap gestures
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addLongTapGestureToSceneView() {
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        sceneView.addGestureRecognizer(longTapGestureRecognizer)
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
        
        sceneView.addGestureRecognizer(swipeLeftGesture)
        sceneView.addGestureRecognizer(swipeRightGesture)
        sceneView.addGestureRecognizer(swipeUpGesture)
        sceneView.addGestureRecognizer(swipeDownGesture)
    }
    
    @objc
    func didTap(_ recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults.first?.node else {return}
        
        if let element = node as? ElementNode {
            presenter?.selectElement(at: element.getLocation())
        }
        
        if let boundingBox = node as? BoundingBoxNode {
            presenter?.buildElement(at: boundingBox.getLocation())
        }
    }
    
    @objc
    func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let longPressLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(longPressLocation)
        
        guard let node = hitTestResults.first?.node else { return }
        
        // TODO: Test if not in add mode
        if let element = node as? ElementNode {
            presenter?.removeElement(at: element.getLocation())
        }
    }
    
    @objc
    func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        let currentAngle = sceneView.session.currentFrame?.camera.eulerAngles.y
        
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
        marbleRun.addElement(type: type, location: position)
    }
    
    func selectElement(at position: Triple<Int, Int, Int>) {
        // TODO: Unhighlight the previouse selected
        let element = marbleRun.getElement(at: position)
        element?.set(state: .highlighted)
    }
    
    func removeElement(at position: Triple<Int, Int, Int>) {
        marbleRun.removeElement(at: position)
    }
    
    func addBoundingBoxes(at positions: Set<Triple<Int, Int, Int>>) {
        for position in positions {
            marbleRun.addBoundingBox(location: position)
        }
    }
    
    func removeBoundingBoxes() {
        marbleRun.removeBoundingBoxes()
    }
    
    
}

enum EditorStatus {
    case show
    case build
}

