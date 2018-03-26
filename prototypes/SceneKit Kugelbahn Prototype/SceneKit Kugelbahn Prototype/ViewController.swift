//
//  ViewController.swift
//  SceneKit Kugelbahn Prototype
//
//  Created by Lucas Schnüriger on 15.03.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var configuration : ARWorldTrackingConfiguration?
    let planeIdentifiers = [UUID]()
    var anchors = [ARAnchor]()
    var boxes = [SCNNode]()
    let cubeSize : CGFloat = 0.05
    let edgeWidth : CGFloat = 0.001

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions  = [.showConstraints, .showLightExtents, ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        // Set the scene to the view
        sceneView.scene = SCNScene()
        // Set lighting
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        // Set configuration
        configuration = ARWorldTrackingConfiguration()
        configuration!.planeDetection = ARWorldTrackingConfiguration.PlaneDetection.horizontal
        sceneView.session.run(configuration!, options: [ARSession.RunOptions.removeExistingAnchors, ARSession.RunOptions.resetTracking])
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        var node: SCNNode?
        if let planeAnchor = anchor as? ARPlaneAnchor {
            let cube = BasicCube()
            cube.position = SCNVector3Make(planeAnchor.center.x, Float(cube.sidelength / 2), planeAnchor.center.z)
            boxes.append(cube)
            anchors.append(planeAnchor)
            node = cube
        } else {
            print("not plane anchor \(anchor)")
        }
        return node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: sceneView)
        selectCube(location: location)
    }
    
    func selectCube(location: CGPoint) {
        let hitResults = sceneView.hitTest(location, options: [:])
        if hitResults.count > 0 {
            let result = hitResults.first!
            if let box : BasicCube = result.node as? BasicCube {
                for index in 0...boxes.count - 1 {
                    if let node = boxes[index] as? BasicCube {
                        node.set(color: UIColor.red)
                    }
                }
                box.set(color: UIColor.green)
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        // let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        // sceneView.session.run(configuration)
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
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
