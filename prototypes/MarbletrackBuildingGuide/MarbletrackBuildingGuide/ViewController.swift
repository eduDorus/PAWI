//
//  ViewController.swift
//  MarbletrackBuildingGuide
//
//  Created by Lucas Schnüriger on 12.04.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    var isPlaneSelected = false
    var isTrackLocked = false
    var isBuildingPhase = false
    var anchors = [ARAnchor]()
    var track : MarbleTrack?
    var builder : TrackBuilder?
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

    // MARK: - ARSCNViewDelegate
    
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard !isPlaneSelected else {
            sceneView.session.remove(anchor: anchor)
            return nil
        }
        
        var node : SCNNode?
        
        if let planeAnchor = anchor as? ARPlaneAnchor {
            node = SCNNode()
            let planeNode = PlaneNode(planeAnchor: planeAnchor)
            node?.addChildNode(planeNode)
            
            anchors.append(planeAnchor)
        } else {
            print("not plane anchor \(anchor)")
        }

        return node
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isPlaneSelected {
            let touch = touches.first!
            let location = touch.location(in: sceneView)
            selectExistingPlane(location: location)
        } else if !isBuildingPhase {
            lockMarbleTrack(!isTrackLocked)
        }
    }

    @IBAction func startButtonTouched(_ sender: Any) {
        if isTrackLocked {
            showNextBuildingStep()
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
        track!.constrainToCamera(true)
        updateMarbleTrackLocation()
    }
    
    func updateMarbleTrackLocation() {
        let hitResults = sceneView.hitTest(screenCenter!, types: .existingPlane)
        if hitResults.count > 0 {
            let result : ARHitTestResult = hitResults.first!
            let coords = result.worldTransform.columns.3
            track!.set(position: SCNVector3(coords.x, coords.y, coords.z))
        }
    }
    
    func lockMarbleTrack(_ lock: Bool = true) {
        isTrackLocked = lock
        startButton.isEnabled = lock
        track!.constrainToCamera(!lock)
        // deactivate for now, to see how the anchors and the object behave compared to each other
//        for a in anchors {
//            sceneView.node(for: a)?.childNodes.first?.geometry?.firstMaterial?.transparency = 0
//        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard track != nil && !isTrackLocked else {
            return
        }
        updateMarbleTrackLocation()
    }
    

    func showNextBuildingStep() {
        if !isBuildingPhase {
            isBuildingPhase = true
            startButton.setTitle("Next Step …", for: .normal)
        }
        if track != nil && builder == nil {
            builder = TrackBuilder(track!.getMap())
            builder!.start()
        }
        if builder != nil {
            if !builder!.step() {
                startButton.setTitle("Restart Building", for: .normal)
                isBuildingPhase = false
                builder = nil
            }
        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        var text = "current camera tracking state: "
        switch camera.trackingState {
        case .limited(.insufficientFeatures):
            text.append("limited, insufficient features")
        case .limited(.excessiveMotion):
            text.append("limited, excessive motion")
        case .limited(.initializing):
            text.append("limited, initializing")
        case .limited(.relocalizing):
            text.append("limited, relocalizing")
        case .normal:
            text.append("normal")
        case .notAvailable:
            text.append("not available")
        }
        label.text = text
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
