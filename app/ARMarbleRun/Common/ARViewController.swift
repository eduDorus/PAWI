//
//  ARViewController.swift
//  ARMarbleRun
//
//  Created by Lucas Schnüriger on 17.05.18.
//  Copyright © 2018 hslu. All rights reserved.
//

import Foundation
import ARKit

class ARViewController : UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    public var screenCenter : CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
