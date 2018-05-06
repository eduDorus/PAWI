//
//  ViewController.swift
//  MarbeltrackBuilder
//
//  Created by Dorus Janssens on 19.04.18.
//  Copyright © 2018 HSLU. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var startButton: UIButton!
    var isPlaneSelected = false
    var isTrackLocked = false
    var isBuildingPhase = false
    var isEditMode = false
    var anchors = [ARAnchor]()
    var track : MarbleTrack?
    var editor : TrackEditor?
    var screenCenter : CGPoint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions  = [.showConstraints, .showLightExtents, ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Set a new scene to the view
        sceneView.scene = SCNScene()
        
        // Set lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        screenCenter = sceneView.center
        
        // Add functionality
        addTapGestureToSceneView()
        addLongTapGestureToSceneView()
        addSwipeGestureToSceneView()
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
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard !isPlaneSelected else {
            sceneView.session.remove(anchor: anchor)
            return nil
        }
        
        var node : SCNNode?
        
        if let planeAnchor = anchor as? ARPlaneAnchor {
            node = SCNNode()
            let planeHeight : CGFloat = 0.001
            let planeGeometry = SCNBox(width: CGFloat(planeAnchor.extent.x), height: planeHeight, length: CGFloat(planeAnchor.extent.z), chamferRadius: 0.0)
            planeGeometry.firstMaterial?.diffuse.contents = UIColor.green
            planeGeometry.firstMaterial?.specular.contents = UIColor.white
            planeGeometry.firstMaterial?.transparency = 0.3
            let planeNode = SCNNode(geometry: planeGeometry)
            planeNode.position = SCNVector3Make(planeAnchor.center.x, Float(planeHeight / 2), planeAnchor.center.z)
            node?.addChildNode(planeNode)
            anchors.append(planeAnchor)
        } else {
            print("not plane anchor \(anchor)")
        }
        
        return node
    }
    
    
    @IBAction func startButtonTouched(_ sender: Any) {
        if isTrackLocked {
            showEditor()
        }
    }
    
    
    // Tap gestures
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addLongTapGestureToSceneView() {
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.didLongPress(_:)))
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
        
        if !isPlaneSelected {
            selectExistingPlane(location: tapLocation)
        } else if !isTrackLocked {
            lockMarbleTrack()
        } else if !isEditMode {
            unlockMarbleTrack()
        } else {
            // let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
            let hitTestResults = sceneView.hitTest(tapLocation)
            
            guard let node = hitTestResults.first?.node else {return}
            
            if let cube = node as? BasicCube {
                updateSelectedCube(cube: cube)
            }
            
        }
    }
    
    func updateSelectedCube(cube: BasicCube) {
        // Set new selected node
        editor!.updateSelected(cube: cube)
    }
    
    @objc
    func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let longPressLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(longPressLocation)
        
        guard let node = hitTestResults.first?.node else { return }
        
        if let cube = node as? BasicCube {
            editor?.removeCube(cube: cube)
        }
    }
    
    @objc
    func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        let currentAngle = sceneView.session.currentFrame?.camera.eulerAngles.y
        
        if gesture.direction == .right {
            editor?.rotateRight()
        }
        else if gesture.direction == .left {
            editor?.rotateLeft()
        }
        else if gesture.direction == .up {
            editor?.rotateUp(currentAngle: currentAngle)
        }
        else if gesture.direction == .down {
            editor?.rotateDown(currentAngle: currentAngle)
        }
    }
    
    
    func selectExistingPlane(location: CGPoint) {
        let hitResults = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        if hitResults.count > 0 {
            let result: ARHitTestResult = hitResults.first!
            if let planeAnchor = result.anchor as? ARPlaneAnchor {
                for var index in 0...anchors.count - 1 {
                    // remove all the nodes from the scene except for the one that is selected
                    if anchors[index].identifier != planeAnchor.identifier {
                        sceneView.node(for: anchors[index])?.removeFromParentNode()
                        sceneView.session.remove(anchor: anchors[index])
                    }
                    index += 1
                }
                // keep track of selected anchor only
                anchors = [planeAnchor]
                // set isPlaneSelected to true
                isPlaneSelected = true
                addMarbleTrack()
            }
        }
    }
    
    func addMarbleTrack() {
        track = MarbleTrack()
        sceneView.scene.rootNode.addChildNode(track!)
        updateMarbleTrackLocation()
    }
    
    func lockMarbleTrack() {
        isTrackLocked = true
        track!.removeConstraints()
        for a in anchors {
            sceneView.node(for: a)?.childNodes.first?.geometry?.firstMaterial?.transparency = 0
        }
        showEditor()
    }
    
    func unlockMarbleTrack() {
        isTrackLocked = false
        track!.constraintToCamera()
        for a in anchors {
            sceneView.node(for: a)?.childNodes.first?.geometry?.firstMaterial?.transparency = 0.1
        }
        updateMarbleTrackLocation()
    }
    
    func updateMarbleTrackLocation() {
        let hitResults = sceneView.hitTest(screenCenter!, types: .existingPlane)
        if hitResults.count > 0 {
            let result : ARHitTestResult = hitResults.first!
            
            let coords = result.worldTransform.columns.3
            track!.set(position: SCNVector3(coords.x, coords.y, coords.z))
            track!.constraintToCamera()
        }
    }
    
    func showEditor() {
        if !isEditMode {
            isEditMode = true
            startButton.isHidden = true
        }
        if track != nil && editor == nil {
            editor = TrackEditor(track!)
            editor!.start()
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard track != nil && !isTrackLocked else {
            return
        }
        updateMarbleTrackLocation()
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
