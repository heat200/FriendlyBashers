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

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
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
