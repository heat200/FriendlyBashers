//
//  ModeSelectScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit

class ModeSelectScene:SKScene {
    private var lastUpdateTime : TimeInterval = 0
    
    var backButton:SKSpriteNode?
    var agreeButton:SKSpriteNode?
    var createPartyButton:SKSpriteNode?
    var connectedCounter:SKSpriteNode?
    var connectedCounterLabel:SKLabelNode?
    
    var regularModeButton:SKSpriteNode?
    var gemRushModeButton:SKSpriteNode?
    var doomHolesModeButton:SKSpriteNode?
    var masterModeButton:SKSpriteNode?
    
    
    override func sceneDidLoad() {
        modeSelect = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.agreeButton = self.childNode(withName: "//agreeButton") as? SKSpriteNode
        self.createPartyButton = self.childNode(withName: "//createPartyButton") as? SKSpriteNode
        self.connectedCounter = self.childNode(withName: "//connectedCounter") as? SKSpriteNode
        self.connectedCounterLabel = SKLabelNode()
        self.connectedCounter?.addChild(connectedCounterLabel!)
        
        self.regularModeButton = self.childNode(withName: "//regularModeButton") as? SKSpriteNode
        self.gemRushModeButton = self.childNode(withName: "//gemRushButton") as? SKSpriteNode
        self.doomHolesModeButton = self.childNode(withName: "//doomHolesButton") as? SKSpriteNode
        self.masterModeButton = self.childNode(withName: "//masterModeButton") as? SKSpriteNode
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.agreeButton && chosenMode != "" {
                headToBasherSelect()
            } else if self.atPoint(pos) == self.backButton {
                // Present the scene
                if let view = self.view {
                    view.presentScene(mainMenu)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            } else if self.regularModeButton!.contains(pos) {
                chosenMode = "Regular"
            } else if self.gemRushModeButton!.contains(pos) {
                chosenMode = "GemRush"
            } else if self.doomHolesModeButton!.contains(pos) {
                chosenMode = "DoomHoles"
            } else if self.masterModeButton!.contains(pos) {
                chosenMode = "Master"
            } else {
                chosenMode = ""
            }
            //print(chosenMode)
        }
    }

    func headToBasherSelect() {
        if basherSelect == nil {
            if let scene = BasherSelectScene(fileNamed: "BasherSelectScene") {
                let sceneNode = scene
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = globalScaleMode
                
                // Present the scene
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        } else {
            // Present the scene
            if let view = self.view {
                view.presentScene(basherSelect)
                view.ignoresSiblingOrder = false
                
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if chosenMode == "" {
            self.agreeButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree_Disabled")))
        } else {
            self.agreeButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree")))
        }
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        self.lastUpdateTime = currentTime
    }
}
