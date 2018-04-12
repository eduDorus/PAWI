//
//  ViewController.swift
//  GesturePrototype
//
//  Created by Dorus Janssens on 08.04.18.
//  Copyright © 2018 HSLU. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    var selectedObject: SCNNode?
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add functionality
        addTapGestureToSceneView()
        addDoubleTapGestureToSceneView()
        addLongTapGestureToSceneView()
        addSwipeGestureToSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    
    
    // Show example box
    func previewBox() {
        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0025)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3Make(0, 0, -0.2)
        sceneView.pointOfView?.addChildNode(boxNode)
    }
    
    // Add box to the scene
    func addBox(x: Float = 0, y: Float = 0, z: Float = 0) {
        let box = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0025)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        
        boxNode.castsShadow = true
        
        box.firstMaterial?.diffuse.contents  = UIColor(red: 182.0 / 255.0, green: 155.0 / 255.0, blue: 76.0 / 255.0, alpha: 1)
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    
    // Tap gestures
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addDoubleTapGestureToSceneView() {
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didDoubleTap(_:)))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        sceneView.addGestureRecognizer(doubleTapGestureRecognizer)
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
        let hitTestOptions: [SCNHitTestOption: Any] = [.boundingBoxOnly: true]
        let hitTestResults = sceneView.hitTest(tapLocation, options: hitTestOptions)

        guard let node = hitTestResults.first?.node else {return}
        
        updateSelectedObject(node: node)
    }
    
    func updateSelectedObject(node: SCNNode) {
        // Set selected color
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        selectedObject?.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 182.0 / 255.0, green: 155.0 / 255.0, blue: 76.0 / 255.0, alpha: 1)
        SCNTransaction.commit()
        
        // Set new selected node
        selectedObject = node
        
        // Set selected color
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        selectedObject?.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 130.0 / 255.0, green: 82.0 / 255.0, blue: 1.0 / 255.0, alpha: 1)
        SCNTransaction.commit()
    }
    
    @objc
    func didDoubleTap(_ recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        
        guard let node = hitTestResults.first?.node else {
            let hitTestResultWithFeaturePoints = sceneView.hitTest(tapLocation, types: .estimatedHorizontalPlane)
            if let hitTestResultWithFeaturePoints = hitTestResultWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
    }
    
    @objc
    func didLongPress(_ recognizer: UILongPressGestureRecognizer) {
        let longPressLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(longPressLocation)
        
        guard let node = hitTestResults.first?.node else { return }
        node.removeFromParentNode()
    }
    
    @objc
    func didSwipe(_ gesture: UISwipeGestureRecognizer) {
        let currentAngle = sceneView.session.currentFrame?.camera.eulerAngles.y
        var action: SCNAction!
        
        if gesture.direction == .right {
            action = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi/2), z: 0, duration: 0.5)
        }
        else if gesture.direction == .left {
            action = SCNAction.rotateBy(x: 0, y: CGFloat(-(Double.pi/2)), z: 0, duration: 0.5)
        }
        else if gesture.direction == .up {
            if (currentAngle! > Float(0.785) && currentAngle! < Float(2.356)) {
                action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(Double.pi/2), duration: 0.5)
            }
            else if (currentAngle! > Float(2.356) || currentAngle! < Float(-2.356)) {
                action = SCNAction.rotateBy(x: CGFloat(Double.pi/2), y: 0, z: 0, duration: 0.5)
            }
            else if (currentAngle! > Float(-2.356) && currentAngle! < Float(-0.785)) {
                action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(-(Double.pi/2)), duration: 0.5)
            }
            else if (currentAngle! > Float(-0.785) && currentAngle! < Float(0.785)) {
                action = SCNAction.rotateBy(x: CGFloat(-(Double.pi/2)), y: 0, z: 0, duration: 0.5)
            }
        }
        else if gesture.direction == .down {
            if (currentAngle! > Float(0.785) && currentAngle! < Float(2.356)) {
                action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(-(Double.pi/2)), duration: 0.5)
            }
            else if (currentAngle! > Float(2.356) || currentAngle! < Float(-2.356)) {
                action = SCNAction.rotateBy(x: CGFloat(-(Double.pi/2)), y: 0, z: 0, duration: 0.5)
            }
            else if (currentAngle! > Float(-2.356) && currentAngle! < Float(-0.785)) {
                action = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(Double.pi/2), duration: 0.5)
            }
            else if (currentAngle! > Float(-0.785) && currentAngle! < Float(0.785)) {
                action = SCNAction.rotateBy(x: CGFloat(Double.pi/2), y: 0, z: 0, duration: 0.5)
            }
            
        }
        if action != nil {
            selectedObject?.runAction(action, forKey: "rotate")
            selectedObject?.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 1.0)
        }
    }
}

// Helper function to convert a matrix to float3 -> x,y,z
extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

