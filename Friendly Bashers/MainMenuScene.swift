//
//  MainMenu.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit

var APP_VERSION = "0.05"

var playerName = "heat200"
var chosenMode = ""
var chosenMap = ""
var chosenBasher = ""
var chosenBasher2 = ""
var chosenBasher3 = ""
var chosenBasher4 = ""

var timeLimit = 0
var deathMode = 2

var chosenBlessing:Int = 0
var blessingNames = ["Page 1", "Page 2", "Page 3", "Page 4"]
var blessingList = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]

var musicEnabled = false
var sfxEnabled = false

var mainMenu:MainMenuScene?
var modeSelect:ModeSelectScene?
var basherSelect:BasherSelectScene?
var gameScene:GameScene?

var TEXT_COLOR:SKColor = SKColor(white: 0.35, alpha: 1)
var TEXT_FONT = "Chalkboard SE"

var inPlay = false
var connected = false

var otherPlayers = ["","",""]

var appDelegate:AppDelegate!

var globalScaleMode = SKSceneScaleMode.aspectFit

class MainMenuScene:SKScene {
    private var lastUpdateTime : TimeInterval = 0
    
    var titleLabel: SKLabelNode?
    var playButton: SKSpriteNode?
    var optionsButton: SKSpriteNode?
    var blessingsButton: SKSpriteNode?
    
    var appVersionLabel:SKLabelNode?
    
    override func sceneDidLoad() {
        mainMenu = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        titleLabel = SKLabelNode(text: "Friendly Bashers")
        titleLabel?.fontName = TEXT_FONT
        titleLabel?.position = CGPoint(x: 0, y: self.size.height/2 - ((titleLabel?.frame.height)! * 2.5))
        titleLabel?.fontColor = TEXT_COLOR
        titleLabel?.fontSize = 65
        
        playButton = SKSpriteNode(imageNamed: "Button_Enabled")
        playButton?.position = CGPoint(x: (titleLabel?.position.x)!, y: (titleLabel?.position.y)! - (playButton?.size.height)!/2 - 30)
        let label2 = SKLabelNode(text: "Play")
        label2.fontName = TEXT_FONT
        label2.fontColor = TEXT_COLOR
        label2.fontSize = 50
        label2.position.y -= 15
        
        optionsButton = SKSpriteNode(imageNamed: "Button_Enabled")
        optionsButton?.position = CGPoint(x: (playButton?.position.x)!, y: (playButton?.position.y)! - (optionsButton?.size.height)!)
        let label3 = SKLabelNode(text: "Options")
        label3.fontName = TEXT_FONT
        label3.fontColor = TEXT_COLOR
        label3.fontSize = 50
        label3.position.y -= 15
        
        blessingsButton = SKSpriteNode(imageNamed: "Button_Enabled")
        blessingsButton?.position = CGPoint(x: (optionsButton?.position.x)!, y: (optionsButton?.position.y)! - (blessingsButton?.size.height)!)
        let label4 = SKLabelNode(text: "Blessings")
        label4.fontName = TEXT_FONT
        label4.fontColor = TEXT_COLOR
        label4.fontSize = 50
        label4.position.y -= 15
        
        appVersionLabel = SKLabelNode(text: "Ver: " + APP_VERSION)
        appVersionLabel?.position = CGPoint(x: self.size.width/2 - (appVersionLabel?.frame.width)!/2, y: -self.size.height/2 + (appVersionLabel?.frame.height)!/2)
        appVersionLabel?.fontName = TEXT_FONT
        appVersionLabel?.fontColor = TEXT_COLOR
        appVersionLabel?.fontSize = 25
        
        self.addChild(titleLabel!)
        
        self.addChild(playButton!)
        playButton!.addChild(label2)
        
        self.addChild(optionsButton!)
        optionsButton!.addChild(label3)
        
        self.addChild(blessingsButton!)
        blessingsButton!.addChild(label4)
        
        self.addChild(appVersionLabel!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.playButton!.contains(pos) {
                headToModeSelect()
            } else if self.optionsButton!.contains(pos) {
                if let sceneNode = OptionsScene(fileNamed: "OptionsScene") {
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
            } else if self.blessingsButton!.contains(pos) {
                if let sceneNode = BlessingsScene(fileNamed: "BlessingsScene") {
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
            }
        }
    }
    
    func headToModeSelect() {
        if modeSelect == nil {
            if let sceneNode = ModeSelectScene(fileNamed: "ModeSelectScene") {
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = globalScaleMode
                
                // Present the scene
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = true
                    view.showsNodeCount = false
                }
            }
        } else {
            // Present the scene
            if let view = self.view {
                view.presentScene(modeSelect)
                view.ignoresSiblingOrder = false
                
                view.showsFPS = true
                view.showsNodeCount = false
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        self.lastUpdateTime = currentTime
    }
}
