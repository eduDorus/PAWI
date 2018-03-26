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
    var isPlaneSelected = false
    let planeHeight : CGFloat = 0.001
    var trackingCube : BasicCube?
    var screenCenter : CGPoint?

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
        screenCenter = sceneView.center
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        // add the anchor node only if the plane is not already selected.
        guard !isPlaneSelected else {
            // we don't session to track the anchor for which we don't want to map node.
            sceneView.session.remove(anchor: anchor)
            return nil
        }
        
        var node:  SCNNode?
        if let planeAnchor = anchor as? ARPlaneAnchor {
            node = SCNNode()
            let planeGeometry = SCNBox(width: CGFloat(planeAnchor.extent.x), height: planeHeight, length: CGFloat(planeAnchor.extent.z), chamferRadius: 0.0)
            planeGeometry.firstMaterial?.diffuse.contents = UIColor.green
            planeGeometry.firstMaterial?.specular.contents = UIColor.white
            planeGeometry.firstMaterial?.transparency = 0.1
            let planeNode = SCNNode(geometry: planeGeometry)
            planeNode.position = SCNVector3Make(planeAnchor.center.x, Float(planeHeight / 2), planeAnchor.center.z)
            node?.addChildNode(planeNode)
            anchors.append(planeAnchor)
        } else {
            print("not plane anchor \(anchor)")
        }
        return node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: sceneView)
        if !isPlaneSelected {
            selectExistingPlane(location: location)
        } else {
            //addNodeAtLocation(location: location)
            placeCube()
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
                setPlaneTexture(node: sceneView.node(for: planeAnchor)!)
                addTrackingCube()
            }
        }
    }
    
    func setPlaneTexture(node: SCNNode) {
        if let geometryNode = node.childNodes.first {
            if node.childNodes.count > 0 {
                geometryNode.geometry?.firstMaterial?.transparency = 0.01
            }
        }
    }
    
    func addNodeAtLocation(location: CGPoint) {
        guard anchors.count > 0 else {
            print("anchors are not created yet")
            return
        }
        
        let hitResults = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        if hitResults.count > 0 {
            let result: ARHitTestResult = hitResults.first!
            let cube = BasicCube()
            let newLocation = SCNVector3Make(result.worldTransform.columns.3.x, (result.worldTransform.columns.3.y + Float(cube.sidelength/2)), result.worldTransform.columns.3.z)
            cube.position = newLocation
            let cameraRotation = sceneView.pointOfView!.eulerAngles
            cube.eulerAngles = SCNVector3(0, cameraRotation.y, 0)
            sceneView.scene.rootNode.addChildNode(cube)
            boxes.append(cube)
        }
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
    
    func addTrackingCube() {
        trackingCube = BasicCube(withColor: UIColor.white)
        sceneView.scene.rootNode.addChildNode(trackingCube!)
        updateTrackingCube()
    }
    
    func updateTrackingCube() {
        let hitResults = sceneView.hitTest(screenCenter!, types: .existingPlane)
        if hitResults.count > 0 {
            let result : ARHitTestResult = hitResults.first!
            let newLocation = SCNVector3Make(result.worldTransform.columns.3.x, (result.worldTransform.columns.3.y + Float(trackingCube!.sidelength/2)), result.worldTransform.columns.3.z)
            trackingCube!.position = newLocation
            let cameraRotation = sceneView.pointOfView!.eulerAngles
            trackingCube!.eulerAngles = SCNVector3(0, cameraRotation.y, 0)
        }
    }
    
    func placeCube() {
        if trackingCube != nil {
            let cube = BasicCube(withColor: UIColor.green)
            cube.position = trackingCube!.position
            cube.eulerAngles = trackingCube!.eulerAngles
            sceneView.scene.rootNode.addChildNode(cube)
            boxes.append(cube)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard trackingCube != nil else {
            return
        }
        updateTrackingCube()
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
