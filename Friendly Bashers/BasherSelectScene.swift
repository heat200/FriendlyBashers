//
//  BasherSelectScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/21/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit

class BasherSelectScene:SKScene {
    private var lastUpdateTime : TimeInterval = 0
    var lastChosenBasher = ""
    
    var backButton:SKSpriteNode?
    var agreeButton:SKSpriteNode?
    var settingsButton:SKSpriteNode?
    var connectedCounter:SKSpriteNode?
    var connectedCounterLabel:SKLabelNode?
    
    var jackButton:SKSpriteNode?
    var plumButton:SKSpriteNode?
    var rosettaButton:SKSpriteNode?
    var silvaButton:SKSpriteNode?
    var cogButton:SKSpriteNode?
    var sarahButton:SKSpriteNode?
    
    var prevMapButton:SKSpriteNode?
    var nextMapButton:SKSpriteNode?
    var chosenMapView:SKSpriteNode?
    
    var p1ChosenView:SKSpriteNode?
    var p2ChosenView:SKSpriteNode?
    var p3ChosenView:SKSpriteNode?
    var p4ChosenView:SKSpriteNode?
    
    override func sceneDidLoad() {
        basherSelect = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.agreeButton = self.childNode(withName: "//agreeButton") as? SKSpriteNode
        self.settingsButton = self.childNode(withName: "//settingsButton") as? SKSpriteNode
        self.connectedCounter = self.childNode(withName: "//connectedCounter") as? SKSpriteNode
        self.connectedCounterLabel = SKLabelNode()
        self.connectedCounter?.addChild(connectedCounterLabel!)
        
        self.p1ChosenView = self.childNode(withName: "//chosen1") as? SKSpriteNode
        self.p2ChosenView = self.childNode(withName: "//chosen2") as? SKSpriteNode
        self.p3ChosenView = self.childNode(withName: "//chosen3") as? SKSpriteNode
        self.p4ChosenView = self.childNode(withName: "//chosen4") as? SKSpriteNode
        
        self.jackButton = self.childNode(withName: "//jackButton") as? SKSpriteNode
        let jackView = SKSpriteNode(imageNamed: "Jack-O_Idle_1")
        jackView.xScale = 0.8
        jackView.yScale = 0.8
        
        self.plumButton = self.childNode(withName: "//plumButton") as? SKSpriteNode
        let plumView = SKSpriteNode(imageNamed: "Plum_Idle_1")
        
        self.rosettaButton = self.childNode(withName: "//rosettaButton") as? SKSpriteNode
        let rosettaView = SKSpriteNode(imageNamed: "Rosetta_Idle_1")
        
        self.silvaButton = self.childNode(withName: "//silvaButton") as? SKSpriteNode
        let silvaView = SKSpriteNode(imageNamed: "Silva_Idle_1")
        
        self.cogButton = self.childNode(withName: "//cogButton") as? SKSpriteNode
        let cogView = SKSpriteNode(imageNamed: "Cog_Idle_1")
        
        self.sarahButton = self.childNode(withName: "//sarahButton") as? SKSpriteNode
        let sarahView = SKSpriteNode(imageNamed: "Sarah_Idle_1")
        
        self.jackButton?.addChild(jackView)
        self.plumButton?.addChild(plumView)
        self.rosettaButton?.addChild(rosettaView)
        self.silvaButton?.addChild(silvaView)
        self.cogButton?.addChild(cogView)
        self.sarahButton?.addChild(sarahView)
        updateUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.agreeButton && chosenBasher != "" {
                headToGameScene()
            } else if self.atPoint(pos) == self.backButton {
                // Present the scene
                if let view = self.view {
                    view.presentScene(modeSelect)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = true
                    view.showsNodeCount = false
                }
            } else if self.atPoint(pos) == self.settingsButton {
                if let sceneNode = GameOptionsScene(fileNamed: "GameOptionsScene") {
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
            } else if (self.jackButton?.contains(pos))! {
                chosenBasher = "Jack-O"
            } else if (self.plumButton?.contains(pos))! {
                chosenBasher = "Plum"
            } else if (self.rosettaButton?.contains(pos))! {
                chosenBasher = "Rosetta"
            } else if (self.silvaButton?.contains(pos))! {
                chosenBasher = "Silva"
            } else if (self.cogButton?.contains(pos))! {
                chosenBasher = "Cog"
            } else if (self.sarahButton?.contains(pos))! {
                chosenBasher = "Sarah"
            } else {
                chosenBasher = ""
            }
            
            if appDelegate.mpcHandler.session != nil {
                MP_TRAFFIC_HANDLER.sendPlayerCharacter()
            }
            
            updateUI()
        }
    }
    
    func updateUI() {
        if appDelegate.mpcHandler.session == nil {
            if chosenBasher == "" {
                self.agreeButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree_Disabled")))
            } else {
                self.agreeButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Agree")))
            }
        } else {
            if appDelegate.mpcHandler.session.connectedPeers.count == 1 {
                
            } else if appDelegate.mpcHandler.session.connectedPeers.count == 2 {
                
            } else if appDelegate.mpcHandler.session.connectedPeers.count == 3 {
                
            }
        }
        
        if lastChosenBasher != chosenBasher {
            lastChosenBasher = chosenBasher
            if chosenBasher == "" {
                p1ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                p1ChosenView!.xScale = 1
                p1ChosenView!.yScale = 1
                p1ChosenView!.size = CGSize(width: 100, height: 100)
            } else {
                p1ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: chosenBasher + "_Idle_1")))
                p1ChosenView!.xScale = 1
                p1ChosenView!.yScale = 1
                p1ChosenView!.size = SKTexture(imageNamed: chosenBasher + "_Idle_1").size()
                
                if chosenBasher == "Jack-O" || chosenBasher == "Silva" {
                    p1ChosenView!.xScale = 0.75
                    p1ChosenView!.yScale = 0.75
                }
            }
        }
        
        if appDelegate.mpcHandler.session != nil {
            if chosenBasher2 == "" {
                p2ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                p2ChosenView!.xScale = 1
                p2ChosenView!.yScale = 1
                p2ChosenView!.size = CGSize(width: 100, height: 100)
            } else {
                p2ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: chosenBasher2 + "_Idle_1")))
                p2ChosenView!.xScale = 1
                p2ChosenView!.yScale = 1
                p2ChosenView!.size = SKTexture(imageNamed: chosenBasher2 + "_Idle_1").size()
                
                if chosenBasher2 == "Jack-O" || chosenBasher2 == "Silva" {
                    p2ChosenView!.xScale = 0.75
                    p2ChosenView!.yScale = 0.75
                }
            }
            
            if chosenBasher3 == "" {
                p3ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                p3ChosenView!.xScale = 1
                p3ChosenView!.yScale = 1
                p3ChosenView!.size = CGSize(width: 100, height: 100)
            } else {
                p3ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: chosenBasher3 + "_Idle_1")))
                p3ChosenView!.xScale = 1
                p3ChosenView!.yScale = 1
                p3ChosenView!.size = SKTexture(imageNamed: chosenBasher3 + "_Idle_1").size()
                
                if chosenBasher3 == "Jack-O" || chosenBasher3 == "Silva" {
                    p3ChosenView!.xScale = 0.75
                    p3ChosenView!.yScale = 0.75
                }
            }
            
            if chosenBasher4 == "" {
                p4ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                p4ChosenView!.xScale = 1
                p4ChosenView!.yScale = 1
                p4ChosenView!.size = CGSize(width: 100, height: 100)
            } else {
                p4ChosenView!.run(SKAction.setTexture(SKTexture(imageNamed: chosenBasher4 + "_Idle_1")))
                p4ChosenView!.xScale = 1
                p4ChosenView!.yScale = 1
                p4ChosenView!.size = SKTexture(imageNamed: chosenBasher4 + "_Idle_1").size()
                
                if chosenBasher4 == "Jack-O" || chosenBasher4 == "Silva" {
                    p4ChosenView!.xScale = 0.75
                    p4ChosenView!.yScale = 0.75
                }
            }
        }
    }
    
    func headToGameScene() {
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.playerCharacter = chosenBasher
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = globalScaleMode
                
                // Present the scene
                if let view = self.view {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
}
