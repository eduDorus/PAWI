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
    
    var boxNode : SCNNode?
    
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
            node = SCNNode()
            
            // this shader makes the (edge-)cube only show the lines on the sides and no diagonals
            let sm = "float u = _surface.diffuseTexcoord.x; \n" +
                "float v = _surface.diffuseTexcoord.y; \n" +
                "int u100 = int(u * 100); \n" +
                "int v100 = int(v * 100); \n" +
                "if (u100 % 99 == 0 || v100 % 99 == 0) { \n" +
                "  // do nothing \n" +
                "} else { \n" +
                "    discard_fragment(); \n" +
            "} \n"
            
            let boxGeometry = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0.001)
            boxGeometry.firstMaterial?.diffuse.contents = UIColor.red
            boxGeometry.firstMaterial?.specular.contents = UIColor.red
            boxGeometry.firstMaterial?.transparency = 0.2
            let boxNode = SCNNode(geometry: boxGeometry)
            let edgeBox = SCNBox(width: cubeSize, height: cubeSize, length: cubeSize, chamferRadius: 0.0)
            edgeBox.firstMaterial?.emission.contents = UIColor.red
            edgeBox.firstMaterial?.diffuse.contents = UIColor.red
            edgeBox.firstMaterial?.shaderModifiers = [SCNShaderModifierEntryPoint.surface: sm]
            edgeBox.firstMaterial?.isDoubleSided = true
            boxNode.addChildNode(SCNNode(geometry: edgeBox))
            boxNode.position = SCNVector3Make(planeAnchor.center.x, Float(cubeSize / 2), planeAnchor.center.z)
            boxNode.castsShadow = true
            node?.addChildNode(boxNode)
            boxes.append(boxNode)
            anchors.append(planeAnchor)
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
            if let box : SCNBox = result.node.geometry as? SCNBox {
                for var index in 0...boxes.count - 1 {
                    if (boxes[index].geometry!.isEqual(box)) {
                        boxes[index].geometry?.firstMaterial?.specular.contents = UIColor.green
                        boxes[index].geometry?.firstMaterial?.diffuse.contents = UIColor.green
                    } else {
                        boxes[index].geometry?.firstMaterial?.specular.contents = UIColor.red
                        boxes[index].geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    }
                    index += 1
                }
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
