//
//  MainMenu.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameKit

var APP_VERSION = "0.8.1"

var playerName = "heat200"
var chosenMode = ""
var currentTheme = "SPRING"
var chosenMap = ""
var chosenBasher = ""
var chosenBasher2 = ""
var chosenBasher3 = ""
var chosenBasher4 = ""

var timeLimit = 0
var deathMode = 2

var winCount = 0
var masteryPoints = 0

var chosenBlessing:Int = 0
var blessingNames = ["Page 1", "Page 2", "Page 3", "Page 4"]
var blessingList = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]

var otherPlayerBlessings = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]

var musicEnabled = false
var sfxEnabled = false
var _enableGameCenter = true
var _authVC:UIViewController?

var attemptedAuth = false

var mainMenu:MainMenuScene?
var modeSelect:ModeSelectScene?
var basherSelect:BasherSelectScene?
var gameScene:GameScene?

var MP_TRAFFIC_HANDLER:MPTrafficHandler!
var GK_TRAFFIC_HANDLER:GKTrafficHandler!

var TEXT_COLOR:SKColor = SKColor(white: 0.35, alpha: 1)
var TEXT_FONT = "Chalkboard SE"

var inPlay = false
var connected = false
var primaryPlayer = false

var otherPlayers = ["","",""]

var appDelegate:AppDelegate!

var globalScaleMode = SKSceneScaleMode.aspectFill
var gameScaleMode = SKSceneScaleMode.resizeFill

var clickSound = SKAction.playSoundFileNamed("Click_fins.wav", waitForCompletion: false)

let defaults = UserDefaults.standard

let bgAtlas = SKTextureAtlas(named: "BackgroundsAtlas")
let charAtlas = SKTextureAtlas(named: "CharAtlas")
let tileAtlas = SKTextureAtlas(named: "TilesAtlas")
let uiAtlas = SKTextureAtlas(named: "UI")

class MainMenuScene:SKScene {
    fileprivate var lastUpdateTime : TimeInterval = 0
    
    var titleLabel:SKLabelNode?
    var playButton:SKSpriteNode?
    var optionsButton:SKSpriteNode?
    var blessingsButton:SKSpriteNode?
    var infoButton:SKSpriteNode?
    var tutorialButton:SKSpriteNode?
    
    var tutorialView:SKSpriteNode?
    
    var appVersionLabel:SKLabelNode?
    
    var backgroundAtlas = bgAtlas
    var UIAtlas = uiAtlas
    
    var highlightedButton = [2,0]
    
    var tutorialPage = 1
    
    override func sceneDidLoad() {
        mainMenu = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        masteryPoints = Int(CGFloat(winCount)/2)
        
        if titleLabel == nil {
            titleLabel = SKLabelNode(text: "Friendly Bashers")
            titleLabel?.fontName = TEXT_FONT
            titleLabel?.position = CGPoint(x: 0, y: self.size.height/2 - ((titleLabel?.frame.height)! * 2.5))
            titleLabel?.fontColor = TEXT_COLOR
            titleLabel?.fontSize = 65
            self.addChild(titleLabel!)
        }
        
        if playButton == nil {
            playButton = SKSpriteNode(texture: UIAtlas.textureNamed("Button_Enabled"))
            playButton?.position = CGPoint(x: (titleLabel?.position.x)!, y: (titleLabel?.position.y)! - (playButton?.size.height)!/2 - 30)
            let label2 = SKLabelNode(text: "Play")
            label2.fontName = TEXT_FONT
            label2.fontColor = TEXT_COLOR
            label2.fontSize = 50
            label2.position.y -= 15
            playButton!.addChild(label2)
            self.addChild(playButton!)
        }
        
        if optionsButton == nil {
            optionsButton = SKSpriteNode(texture: UIAtlas.textureNamed("Button_Enabled"))
            optionsButton?.position = CGPoint(x: (playButton?.position.x)!, y: (playButton?.position.y)! - (optionsButton?.size.height)!)
            let label3 = SKLabelNode(text: "Options")
            label3.fontName = TEXT_FONT
            label3.fontColor = TEXT_COLOR
            label3.fontSize = 50
            label3.position.y -= 15
            self.addChild(optionsButton!)
            optionsButton!.addChild(label3)
        }
        
        if blessingsButton == nil {
            blessingsButton = SKSpriteNode(texture: UIAtlas.textureNamed("Button_Enabled"))
            blessingsButton?.position = CGPoint(x: (optionsButton?.position.x)!, y: (optionsButton?.position.y)! - (blessingsButton?.size.height)!)
            let label4 = SKLabelNode(text: "Masteries")
            label4.fontName = TEXT_FONT
            label4.fontColor = TEXT_COLOR
            label4.fontSize = 50
            label4.position.y -= 15
            self.addChild(blessingsButton!)
            blessingsButton!.addChild(label4)
        }
        
        if infoButton == nil {
            infoButton = SKSpriteNode(texture: UIAtlas.textureNamed("Button_Info"))
            infoButton!.size = CGSize(width: 100, height: 100)
            infoButton?.position = CGPoint(x: -self.size.width/2 + 60, y: -self.size.height/2 + 60)
            self.addChild(infoButton!)
            
            tutorialButton = SKSpriteNode(texture: UIAtlas.textureNamed("Button_Help"))
            tutorialButton!.size = CGSize(width: 100, height: 100)
            tutorialButton?.position = CGPoint(x: infoButton!.position.x + 100, y: infoButton!.position.y)
            self.addChild(tutorialButton!)
        }
        
        if appVersionLabel == nil {
            appVersionLabel = SKLabelNode(text: "Ver: " + APP_VERSION)
            appVersionLabel?.position = CGPoint(x: self.size.width/2 - 10, y: -self.size.height/2 + (appVersionLabel?.frame.height)!/2)
            appVersionLabel?.fontName = TEXT_FONT
            appVersionLabel?.fontColor = TEXT_COLOR
            appVersionLabel?.fontSize = 25
            appVersionLabel?.horizontalAlignmentMode = .right
            self.addChild(appVersionLabel!)
        } else {
            appVersionLabel?.removeFromParent()
            appVersionLabel = SKLabelNode(text: "Ver: " + APP_VERSION)
            appVersionLabel?.position = CGPoint(x: self.size.width/2 - 10, y: -self.size.height/2 + (appVersionLabel?.frame.height)!/2)
            appVersionLabel?.fontName = TEXT_FONT
            appVersionLabel?.fontColor = TEXT_COLOR
            appVersionLabel?.fontSize = 25
            appVersionLabel?.horizontalAlignmentMode = .right
            self.addChild(appVersionLabel!)
        }
        
        if !attemptedAuth {
            attemptedAuth = true
            GK_TRAFFIC_HANDLER.authLocalPlayer()
            
            if musicEnabled {
                SKTAudio.sharedInstance().playBackgroundMusic(filename: "Calamity_airwolf89.mp3")
            }
        }
        
        self.highlightSelected()
    }
    
    func receivedPress(press:UIPressType) {
        if press == .upArrow {
            if sfxEnabled {
                self.run(clickSound)
            }
            
            if tutorialView != nil {
                if tutorialPage > 1 {
                    tutorialPage -= 2
                    changeTutorialPage()
                } else if tutorialPage == 1 {
                    hideTutorialUI()
                }
            } else {
                if highlightedButton[0] > 0 {
                    highlightedButton[0] -= 1
                    highlightedButton[1] = 0
                }
            }
            highlightSelected()
        } else if press == .downArrow {
            if sfxEnabled {
                self.run(clickSound)
            }
            
            if tutorialView != nil {
                changeTutorialPage()
            } else {
                if highlightedButton[0] < 2 {
                    highlightedButton[0] += 1
                    highlightedButton[1] = 0
                }
            }
            highlightSelected()
        } else if press == .rightArrow {
            if sfxEnabled {
                self.run(clickSound)
            }
            
            if highlightedButton[1] > 0 && highlightedButton[0] == 2 {
                highlightedButton[1] -= 1
            }
            highlightSelected()
        } else if press == .leftArrow {
            if sfxEnabled {
                self.run(clickSound)
            }
            
            if highlightedButton[1] < 2 && highlightedButton[0] == 2 {
                highlightedButton[1] += 1
            }
            highlightSelected()
        } else if press == .select {
            if sfxEnabled {
                self.run(clickSound)
            }
            
            pressHighlighted()
        }
    }
    
    func pressHighlighted() {
        if tutorialView != nil {
            self.changeTutorialPage()
        } else if highlightedButton[0] == 2 && highlightedButton[1] == 0 {
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                self.headToModeSelect()
            })
        } else if highlightedButton[0] == 2 && highlightedButton[1] == 1 {
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                if let sceneNode = OptionsScene(fileNamed: "OptionsScene") {
                    sceneNode.scaleMode = globalScaleMode
                    if let view = self.view {
                        view.presentScene(sceneNode)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = false
                        view.showsNodeCount = false
                    }
                }
            })
        } else if highlightedButton[0] == 2 && highlightedButton[1] == 2 {
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                if let sceneNode = BlessingsScene(fileNamed: "BlessingsScene") {
                    sceneNode.scaleMode = globalScaleMode
                    if let view = self.view {
                        view.presentScene(sceneNode)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = false
                        view.showsNodeCount = false
                    }
                }
            })
        } else if highlightedButton[0] == 1 && highlightedButton[1] == 0 {
            self.showTutorialUI()
        } else if highlightedButton[0] == 0 && highlightedButton[1] == 0 {
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                if let sceneNode = HelpScene(fileNamed: "HelpScene") {
                    sceneNode.scaleMode = globalScaleMode
                    if let view = self.view {
                        view.presentScene(sceneNode)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = false
                        view.showsNodeCount = false
                    }
                }
            })
        }
    }
    
    func highlightSelected() {
        if highlightedButton[0] == 2 && highlightedButton[1] == 0 {
            playButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.2, duration: 0.5))
            optionsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            blessingsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            tutorialButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            infoButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
        } else if highlightedButton[0] == 2 && highlightedButton[1] == 1 {
            playButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            optionsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.2, duration: 0.5))
            blessingsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            tutorialButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            infoButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
        } else if highlightedButton[0] == 2 && highlightedButton[1] == 2 {
            playButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            optionsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            blessingsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.2, duration: 0.5))
            tutorialButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            infoButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
        } else if highlightedButton[0] == 1 && highlightedButton[1] == 0 {
            playButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            optionsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            blessingsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            tutorialButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.2, duration: 0.5))
            infoButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
        } else if highlightedButton[0] == 0 && highlightedButton[1] == 0 {
            playButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            optionsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            blessingsButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            tutorialButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.0, duration: 0.5))
            infoButton?.run(SKAction.colorize(with: .blue, colorBlendFactor: 0.2, duration: 0.5))
        }
    }
    
    func showTutorialUI() {
        self.tutorialView = SKSpriteNode(imageNamed: "Tut_1-1")
        self.tutorialView?.size = self.size
        self.addChild(tutorialView!)
    }
    
    func changeTutorialPage() {
        tutorialPage += 1
        
        if tutorialPage == 1 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_1-1")))
        } else if tutorialPage == 2 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_1-2")))
        } else if tutorialPage == 3 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_1-3")))
        } else if tutorialPage == 4 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_1-4")))
        } else if tutorialPage == 5 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_2-1")))
        } else if tutorialPage == 6 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_2-2")))
        } else if tutorialPage == 7 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_2-3")))
        } else if tutorialPage == 8 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_3-1")))
        } else if tutorialPage == 9 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_4-1")))
        } else if tutorialPage == 10 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_4-2")))
        } else if tutorialPage == 11 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_4-3")))
        } else if tutorialPage == 12 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_4-4")))
        } else if tutorialPage == 13 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_5-1")))
        } else if tutorialPage == 14 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_6-1")))
        } else if tutorialPage == 15 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_6-2")))
        } else if tutorialPage == 16 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_6-3")))
        } else if tutorialPage == 17 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_6-4")))
        } else if tutorialPage == 18 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_7-1")))
        } else if tutorialPage == 19 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_7-2")))
        } else if tutorialPage == 20 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_7-3")))
        } else if tutorialPage == 21 {
            tutorialView?.run(SKAction.setTexture(SKTexture(imageNamed: "Tut_7-4")))
        } else {
            self.hideTutorialUI()
        }
    }
    
    func hideTutorialUI() {
        tutorialView?.removeFromParent()
        tutorialPage = 1
        highlightedButton[0] = 2
        highlightedButton[1] = 0
    }
    
    func headToModeSelect() {
        if modeSelect == nil {
            if let sceneNode = ModeSelectScene(fileNamed: "ModeSelectScene") {
                sceneNode.scaleMode = globalScaleMode
                
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                    view.showsFPS = false
                    view.showsNodeCount = false
                }
            }
        } else {
            if let view = self.view {
                view.presentScene(modeSelect)
                view.ignoresSiblingOrder = false
                
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }
    }
}
