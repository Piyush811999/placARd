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
import SafariServices

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    @IBAction func ClearButton(_ sender: Any) {
        
        print("Clear pressed")
        
        sceneView.session.pause()
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
        node.removeFromParentNode() }
        
        let configuration = ARWorldTrackingConfiguration()
        
        //Object detection
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: Bundle.main)!
            
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    var player : AVPlayer!
    
    var count : Int = 0
    
    var model = [People]() //Initialising Model Array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/GameScene.scn")!
        
        let url = URL(string: "http://aa57f7a2.ngrok.io/people/ar_index")!
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if (error) != nil {
                
                print(error as Any)
                print("test")
                
            }else{
                
                print("test21")
                
                
                
                if let urlContent = data {
                    
                    do {
                        

                        
                        let jsonResults = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        
//
                        guard let jsonArray = jsonResults as? [[String: Any]] else {
                              return
                        }

                        for dic in jsonArray{
                            self.model.append(People(dic)) // adding now value in Model array
                        }
                        //Printing first value for the output
                        print(self.model) // 1211
                        
                        print(jsonResults)
                        
                    } catch {
                        print("Json processing Error")
                    }
                    
                }
                
            }
            

        }
        task.resume()
        
        // Set the scene to the view
        

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))

        //Add recognizer to sceneview
        sceneView.addGestureRecognizer(tap)

        //Method called when tap

        sceneView.scene = scene
    }
    
    @objc func handleTap(rec: UITapGestureRecognizer){
        
           if rec.state == .ended {
                let location: CGPoint = rec.location(in: sceneView)
                let hits = self.sceneView.hitTest(location, options: nil)
                if !hits.isEmpty{
                    let tappedNode = hits.first?.node
                    
    
    
                    guard let url = URL(string: tappedNode?.name ?? "") else { return }
                        let svc = SFSafariViewController(url: url)
                        present(svc, animated: true, completion: nil)
                        
                        
                }
           }
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
                
            case "Candle" :
                
                let plane = SCNPlane(width: CGFloat(426.465/2000),height: CGFloat(256.795/2000))
                let  sKS = SKScene(fileNamed: "ProductOne")
                
                plane.firstMaterial?.diffuse.contents = sKS
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                
                let planeNode = SCNNode(geometry: plane)
                planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                
                node.addChildNode(planeNode)
            
            case "Laptop" :
                
                let plane = SCNPlane(width: CGFloat(1.6/5),height: CGFloat(0.9/5))
                
                let spriteKitScene = SKScene(fileNamed: "related")
                
                plane.firstMaterial?.diffuse.contents = spriteKitScene
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.20, objectAnchor.referenceObject.center.z)
                
                
                let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "M50X", ofType: "mp4")!)
                       player = AVPlayer(url: fileURL)
                       
                       let Video = SCNPlane(width: 1.6/4.5, height: 0.9/4.5)
                       Video.firstMaterial?.diffuse.contents = player
                       Video.firstMaterial?.isDoubleSided = true
                       
                       let tvNode = SCNNode(geometry: Video)
                    tvNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.43, objectAnchor.referenceObject.center.z)
                       node.addChildNode(tvNode)
                       node.addChildNode(planeNode)
                player.play()
                
                
            case "Notebook" :
                
                let plane = SCNPlane(width: CGFloat(426.465/2000),height: CGFloat(256.795/2000))

                let spriteKitScene = SKScene(fileNamed: "wallet")

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
                
                
            case "G305" :
                
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
             
                
            case "Face" :
                    
                                let title = SCNText(string: self.model[1].name, extrusionDepth: 0.6)
                    
                               
                                    
                                title.firstMaterial?.diffuse.contents = UIColor.black
                                    
                                let info = objectAnchor.referenceObject
          
                                  let titleNode = SCNNode(geometry: title)
                                  titleNode.scale = SCNVector3(0.005, 0.005, 0.01)
                                  titleNode.position = SCNVector3(info.center.x, info.center.y + 0.20 , info.center.z)
                                
                                 let plane = SCNPlane(width: CGFloat(titleNode.boundingBox.min.x)/2  ,height: CGFloat(1.2/5))
                        
                                let email = SCNText(string: "Facebook", extrusionDepth: 0.6)
                                email.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let emailNode = SCNNode(geometry: email)
                                emailNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                emailNode.position = SCNVector3(titleNode.position.x , titleNode.position.y - 0.05 , titleNode.position.z)
                                emailNode.name = self.model[1].fb_link
                //                planeNode.eulerAngles.x = -.pi/2
                                
                                let twitter = SCNText(string: "Twitter", extrusionDepth: 0.6)
                                twitter.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let twitterNode = SCNNode(geometry: twitter)
                                twitterNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                twitterNode.position = SCNVector3(titleNode.position.x , emailNode.position.y - 0.05 , titleNode.position.z)
                                twitterNode.name = self.model[1].twitter_link
                                
                                let linkedIn = SCNText(string: "LinkedIn", extrusionDepth: 0.6)
                                linkedIn.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let linkedInNode = SCNNode(geometry: linkedIn)
                                linkedInNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                linkedInNode.position = SCNVector3(titleNode.position.x , twitterNode.position.y - 0.05 , titleNode.position.z)
                                linkedInNode.name = self.model[1].linkedin_link
                  
                //                node.addChildNode(planeNode)
                                
                                
                                
                                let spriteKitScene = UIColor.lightGray
                                
                                plane.firstMaterial?.diffuse.contents = spriteKitScene
                                plane.firstMaterial?.isDoubleSided = true
                                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                                
                                let planeNode = SCNNode(geometry: plane)
                                
                                planeNode.position = SCNVector3Make(titleNode.position.x + 0.25 , titleNode.position.y - 0.05, titleNode.position.z)
                                
                                node.addChildNode(planeNode)
                                node.addChildNode(linkedInNode)
                                node.addChildNode(twitterNode)
                                node.addChildNode(emailNode)
                                node.addChildNode(titleNode)
                
            case "Face2" :
                let titleNode = createTitleNode2(info: objectAnchor.referenceObject)
                                
                                
                                let plane = SCNPlane(width: CGFloat(titleNode.boundingBox.min.x)/2  ,height: CGFloat(1.2/5))
                                
                                let spriteKitScene = UIColor.lightGray
                                
                                plane.firstMaterial?.diffuse.contents = spriteKitScene
                                plane.firstMaterial?.isDoubleSided = true
                                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                                
                                let planeNode = SCNNode(geometry: plane)
                                
                                let email = SCNText(string: "Facebook", extrusionDepth: 0.6)
                                email.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let emailNode = SCNNode(geometry: email)
                                emailNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                emailNode.position = SCNVector3(titleNode.position.x , titleNode.position.y - 0.05 , titleNode.position.z)
                                emailNode.name = self.model[0].fb_link
                //                planeNode.eulerAngles.x = -.pi/2
                                
                                
                                
                                
                                let twitter = SCNText(string: "Twitter", extrusionDepth: 0.6)
                                twitter.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let twitterNode = SCNNode(geometry: twitter)
                                twitterNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                twitterNode.position = SCNVector3(titleNode.position.x , emailNode.position.y - 0.05 , titleNode.position.z)
                                twitterNode.name = self.model[0].twitter_link
                                
                                
                                
                                
                                let linkedIn = SCNText(string: "LinkedIn", extrusionDepth: 0.6)
                                linkedIn.firstMaterial?.diffuse.contents = UIColor.white
                                
                                let linkedInNode = SCNNode(geometry: linkedIn)
                                linkedInNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                linkedInNode.position = SCNVector3(titleNode.position.x , twitterNode.position.y - 0.05 , titleNode.position.z)
                                linkedInNode.name = self.model[0].linkedin_link
                                
                                
                                
                                planeNode.position = SCNVector3Make(titleNode.position.x + 0.25 , titleNode.position.y - 0.05, titleNode.position.z)
                                
                                
                //                node.addChildNode(planeNode)
                                
                                node.addChildNode(planeNode)
                                node.addChildNode(linkedInNode)
                                node.addChildNode(twitterNode)
                                node.addChildNode(emailNode)
                                node.addChildNode(titleNode)
                
                
            case "Face3" :
                
                let titleNode = createTitleNode3(info: objectAnchor.referenceObject)
                                
                                
                                let plane = SCNPlane(width: CGFloat(titleNode.boundingBox.min.x)/2  ,height: CGFloat(1.2/5))
                                
                let spriteKitScene = UIColor(red: 7/255, green: 54/255, blue: 66/255, alpha: 0.95)
                                
                                plane.firstMaterial?.diffuse.contents = spriteKitScene
                                plane.firstMaterial?.isDoubleSided = true
                                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                                let planeNode = SCNNode(geometry: plane)
                                
                                let email = SCNText(string: "Facebook", extrusionDepth: 0.6)
                                email.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let emailNode = SCNNode(geometry: email)
                                emailNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                emailNode.position = SCNVector3(titleNode.position.x , titleNode.position.y - 0.05 , titleNode.position.z)
                                emailNode.name = self.model[1].fb_link
                //                planeNode.eulerAngles.x = -.pi/2
                                
                                
                                
                                
                                let twitter = SCNText(string: "Twitter", extrusionDepth: 0.6)
                                twitter.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let twitterNode = SCNNode(geometry: twitter)
                                twitterNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                twitterNode.position = SCNVector3(titleNode.position.x , emailNode.position.y - 0.05 , titleNode.position.z)
                                twitterNode.name = self.model[1].twitter_link
                                
                                
                                
                                
                                let linkedIn = SCNText(string: "LinkedIn", extrusionDepth: 0.6)
                                linkedIn.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let linkedInNode = SCNNode(geometry: linkedIn)
                                linkedInNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                linkedInNode.position = SCNVector3(titleNode.position.x , twitterNode.position.y - 0.05 , titleNode.position.z)
                                linkedInNode.name = self.model[1].linkedin_link
                                
                                
                                
                                planeNode.position = SCNVector3Make(titleNode.position.x + 0.25 , titleNode.position.y - 0.05, titleNode.position.z)
                                
                                
                //                node.addChildNode(planeNode)
                                
                                node.addChildNode(planeNode)
                                node.addChildNode(linkedInNode)
                                node.addChildNode(twitterNode)
                                node.addChildNode(emailNode)
                                node.addChildNode(titleNode)
                
            case "Face4" :
                
                let titleNode = createTitleNode2(info: objectAnchor.referenceObject)
                                
                                
                                let plane = SCNPlane(width: CGFloat(titleNode.boundingBox.min.x)/2  ,height: CGFloat(1.2/5))
                                
                let spriteKitScene = UIColor(red: 7/255, green: 54/255, blue: 66/255, alpha: 0.95)
                                
                                plane.firstMaterial?.diffuse.contents = spriteKitScene
                                plane.firstMaterial?.isDoubleSided = true
                                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
       
                                
                                let planeNode = SCNNode(geometry: plane)
                                
                                let email = SCNText(string: "Facebook", extrusionDepth: 0.6)
                                email.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let emailNode = SCNNode(geometry: email)
                                emailNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                emailNode.position = SCNVector3(titleNode.position.x , titleNode.position.y - 0.05 , titleNode.position.z)
                                emailNode.name = self.model[0].fb_link
                //                planeNode.eulerAngles.x = -.pi/2
                                
                                
                                
                                
                                let twitter = SCNText(string: "Twitter", extrusionDepth: 0.6)
                                twitter.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let twitterNode = SCNNode(geometry: twitter)
                                twitterNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                twitterNode.position = SCNVector3(titleNode.position.x , emailNode.position.y - 0.05 , titleNode.position.z)
                                twitterNode.name = self.model[0].twitter_link
                                
                                
                                
                                
                                let linkedIn = SCNText(string: "LinkedIn", extrusionDepth: 0.6)
                                linkedIn.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                                
                                let linkedInNode = SCNNode(geometry: linkedIn)
                                linkedInNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                                linkedInNode.position = SCNVector3(titleNode.position.x , twitterNode.position.y - 0.05 , titleNode.position.z)
                                linkedInNode.name = self.model[0].linkedin_link
                                
                                
                                
                                planeNode.position = SCNVector3Make(titleNode.position.x + 0.25 , titleNode.position.y - 0.05, titleNode.position.z)
                                
                                
                //                node.addChildNode(planeNode)
                                
                                node.addChildNode(planeNode)
                                node.addChildNode(linkedInNode)
                                node.addChildNode(twitterNode)
                                node.addChildNode(emailNode)
                                node.addChildNode(titleNode)
                
                
                
            default:
                
                let titleNode = createTitleNode(info: objectAnchor.referenceObject)
                
                
                let plane = SCNPlane(width: CGFloat(titleNode.boundingBox.min.x)/2  ,height: CGFloat(1.2/5))
                
                let spriteKitScene = UIColor(red: 7/255, green: 54/255, blue: 66/255, alpha: 0.95)
                
                plane.firstMaterial?.diffuse.contents = spriteKitScene
                plane.firstMaterial?.isDoubleSided = true
                plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1),0,1,0)
                
                let planeNode = SCNNode(geometry: plane)
                
                let email = SCNText(string: "Facebook", extrusionDepth: 0.6)
                email.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                
                let emailNode = SCNNode(geometry: email)
                emailNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                emailNode.position = SCNVector3(titleNode.position.x , titleNode.position.y - 0.05 , titleNode.position.z)
                emailNode.name = self.model[2].fb_link
//                planeNode.eulerAngles.x = -.pi/2
                
                
                
                
                let twitter = SCNText(string: "Twitter", extrusionDepth: 0.6)
                twitter.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                
                let twitterNode = SCNNode(geometry: twitter)
                twitterNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                twitterNode.position = SCNVector3(titleNode.position.x , emailNode.position.y - 0.05 , titleNode.position.z)
                twitterNode.name = self.model[2].twitter_link
                
                
                
                
                let linkedIn = SCNText(string: "LinkedIn", extrusionDepth: 0.6)
                linkedIn.firstMaterial?.diffuse.contents = UIColor(red: 38/255, green: 139/255, blue: 210/255, alpha: 1)
                
                let linkedInNode = SCNNode(geometry: linkedIn)
                linkedInNode.scale = SCNVector3(0.005/2, 0.005/2, 0.01/2)
                linkedInNode.position = SCNVector3(titleNode.position.x , twitterNode.position.y - 0.05 , titleNode.position.z)
                linkedInNode.name = self.model[2].linkedin_link
                
                
                
                planeNode.position = SCNVector3Make(titleNode.position.x + 0.25 , titleNode.position.y - 0.05, titleNode.position.z)
                
                
//                node.addChildNode(planeNode)
                
                node.addChildNode(planeNode)
                node.addChildNode(linkedInNode)
                node.addChildNode(twitterNode)
                node.addChildNode(emailNode)
                node.addChildNode(titleNode)
      
            }

        }
        
        return node
    }
    
    private func createTitleNode(info: ARReferenceObject) -> SCNNode {
        
        let title = SCNText(string: self.model[2].name, extrusionDepth: 0.6)
        
        title.firstMaterial?.diffuse.contents = UIColor.white
        
    
        
      let titleNode = SCNNode(geometry: title)
      titleNode.scale = SCNVector3(0.005, 0.005, 0.01)
      titleNode.position = SCNVector3(info.center.x, info.center.y + 0.20 , info.center.z)
      return titleNode
        
    }
    
    private func createTitleNode2(info: ARReferenceObject) -> SCNNode {
        
        let title = SCNText(string: self.model[0].name, extrusionDepth: 0.6)
        
        title.firstMaterial?.diffuse.contents = UIColor.white
        
    
        
      let titleNode = SCNNode(geometry: title)
      titleNode.scale = SCNVector3(0.005, 0.005, 0.01)
      titleNode.position = SCNVector3(info.center.x, info.center.y + 0.20 , info.center.z)
      return titleNode
        
    }
    
    private func createTitleNode3(info: ARReferenceObject) -> SCNNode {
        
        let title = SCNText(string: self.model[1].name, extrusionDepth: 0.6)
        
        title.firstMaterial?.diffuse.contents = UIColor.white
        
    
        
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


// diya
// wallet
// laptop 
