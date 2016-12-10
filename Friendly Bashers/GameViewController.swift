//
//  GameViewController.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/17/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MP_TRAFFIC_HANDLER == nil {
            MP_TRAFFIC_HANDLER = MPTrafficHandler()
        }
        
        if GK_TRAFFIC_HANDLER == nil {
            GK_TRAFFIC_HANDLER = GKTrafficHandler()
        }
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            globalScaleMode = SKSceneScaleMode.aspectFit
            gameScaleMode = SKSceneScaleMode.aspectFit
        break
        case .pad:
            globalScaleMode = SKSceneScaleMode.fill
            gameScaleMode = SKSceneScaleMode.resizeFill
        break
        case .unspecified:
            globalScaleMode = SKSceneScaleMode.aspectFit
            gameScaleMode = SKSceneScaleMode.aspectFit
        break
        default:
            globalScaleMode = SKSceneScaleMode.aspectFit
            gameScaleMode = SKSceneScaleMode.aspectFit
        break
        }
        
        NotificationCenter.default.addObserver(self,selector:#selector(GameViewController.AlertMessage(notification:)),name:NSNotification.Name(rawValue: "AlertMessage"),object:nil)
        
        NotificationCenter.default.addObserver(self,selector:#selector(GameViewController.LoginMessage),name:NSNotification.Name(rawValue: "LoginMessage"),object:nil)
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        SKTextureAtlas.preloadTextureAtlases([bgAtlas,charAtlas,tileAtlas,uiAtlas], withCompletionHandler: {
            if let scene = MainMenuScene(fileNamed: "MainMenuScene") {
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene as MainMenuScene? {
                    // Set the scale mode to scale to fit the window
                    sceneNode.scaleMode = globalScaleMode
                    
                    // Present the scene
                    if let view = self.view as! SKView? {
                        view.presentScene(sceneNode)
                        
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = false
                        view.showsNodeCount = false
                    }
                }
            }
        })
    }
    
    func AlertMessage(notification:NSNotification) {
        if let userInfo = notification.userInfo {
            var title = userInfo["title"] as! String?
            let message = userInfo["message"] as! String?
            if title == "" {
                title = "About this Mastery"
            }
            
            let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "Thanks!", style: .default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
    func LoginMessage() {
        if _authVC != nil {
            self.present(_authVC!, animated: false, completion: {})
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
