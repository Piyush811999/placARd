//
//  ViewController.swift
//  ARInfo
//
//  Created by Pop on 31/08/19.
//  Copyright © 2019 Piyush Makwana. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var player : AVPlayer!
    
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        //Object detection
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: Bundle.main)!
        
        

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            
            switch objectAnchor.referenceObject.name {
            case "SaltLamp":
                              
                              let plane = SCNPlane(width: CGFloat(426.465/2000),height: CGFloat(256.795/2000))
                            
                       
                              
                              let spriteKitScene = SKScene(fileNamed: "ProductOne")
                              
                            
                              
                              plane.firstMaterial?.diffuse.contents = spriteKitScene
                              plane.firstMaterial?.isDoubleSided = true
                              plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                              
                              let planeNode = SCNNode(geometry: plane)
                              planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                              
                              node.addChildNode(planeNode)
                
            case "360":
                
                let plane = SCNPlane(width: CGFloat(1.6/5),height: CGFloat(0.9*700/(5*1080)))
                
                let spriteKitScene = SKScene(fileNamed: "avail")
                
                plane.firstMaterial?.diffuse.contents = spriteKitScene
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                
                
                
                let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "360", ofType: "mp4")!)
                player = AVPlayer(url: fileURL)
                
                let Video = SCNPlane(width: 1.6/4, height: 0.9/4)
                Video.firstMaterial?.diffuse.contents = player
                Video.firstMaterial?.isDoubleSided = true
                
                let tvNode = SCNNode(geometry: Video)
                    tvNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.4, objectAnchor.referenceObject.center.z)
                
                    node.addChildNode(tvNode)
                    node.addChildNode(planeNode)
                
                    player.play()
                
            case "G305":
                
                let plane = SCNPlane(width: CGFloat(1.6/5),height: CGFloat(0.9/5))
                
                let spriteKitScene = SKScene(fileNamed: "related")
                
                plane.firstMaterial?.diffuse.contents = spriteKitScene
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                
                
                let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "G304", ofType: "mp4")!)
                       player = AVPlayer(url: fileURL)
                       
                       let Video = SCNPlane(width: 1.6/4.5, height: 0.9/4.5)
                       Video.firstMaterial?.diffuse.contents = player
                       Video.firstMaterial?.isDoubleSided = true
                       
                       let tvNode = SCNNode(geometry: Video)
                    tvNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.43, objectAnchor.referenceObject.center.z)
                       node.addChildNode(tvNode)
                       node.addChildNode(planeNode)
                player.play()
                
            case "M50X":
                
                
                let plane = SCNPlane(width: CGFloat(444/2000),height: CGFloat(200/2000))
                              
                let spriteKitScene = SKScene(fileNamed: "M50Xinfo")
                              
                plane.firstMaterial?.diffuse.contents = spriteKitScene
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                              
                let planeNode = SCNNode(geometry: plane)
                              
                planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.40, objectAnchor.referenceObject.center.z)
                
                let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "M50X", ofType: "mp4")!)
                       player = AVPlayer(url: fileURL)
                       
                       let Video = SCNPlane(width: 1.6/5, height: 0.9/5)
                       Video.firstMaterial?.diffuse.contents = player
                       Video.firstMaterial?.isDoubleSided = true
                       
                       let tvNode = SCNNode(geometry: Video)
                       tvNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                    node.addChildNode(tvNode)
                node.addChildNode(planeNode)
                player.play()
                
            default:
                let titleNode = createTitleNode(info: objectAnchor.referenceObject)
                
                node.addChildNode(titleNode)
      
            }
            
            
        }
        
        return node
    }
    
    private func createTitleNode(info: ARReferenceObject) -> SCNNode {
      let title = SCNText(string: info.name, extrusionDepth: 0.6)
      let titleNode = SCNNode(geometry: title)
      titleNode.scale = SCNVector3(0.005, 0.005, 0.01)
      titleNode.position = SCNVector3(info.center.x, info.center.y + 0.20 , info.center.z)
      return titleNode
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
