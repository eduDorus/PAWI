//
//  ARViewController.swift
//  ARMarbleRun
//
//  Created by Lucas Schnüriger on 17.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import ARKit

class ARViewController : UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    public var screenCenter : CGPoint?
    var isPlaneSelected = false
    var anchors = [ARAnchor]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func selectExistingPlane(location: CGPoint) -> Bool {
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
                return true
            }
        }
        return false
    }
    
    // MARK: - ARSCNViewDelegate
    
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
}
