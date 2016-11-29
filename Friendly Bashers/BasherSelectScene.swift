//
//  BasherSelectScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/21/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameKit

class BasherSelectScene:SKScene {
    fileprivate var lastUpdateTime : TimeInterval = 0
    var lastChosenBasher = ""
    
    var backButton:SKSpriteNode?
    var agreeButton:SKSpriteNode?
    var settingsButton:SKSpriteNode?
    var helpButton:SKSpriteNode?
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
    
    var helpMode = false
    var readyForGame = false
    
    var mapList = ["Origins","Buckets","Tunnels","Caves","SkyDen"]
    var mapIndex = 0
    
    var startSound:SKAudioNode!
    var backgroundAtlas = bgAtlas
    var characterAtlas = charAtlas
    var UIAtlas = uiAtlas
 
    override func sceneDidLoad() {
        basherSelect = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        currentTheme = "SPRING"
        
        if gameScene != nil {
            gameScene?.removeAllActions()
            gameScene?.removeAllChildren()
            gameScene = nil
        }
        
        if menuMusic.parent == nil && musicEnabled {
            self.addChild(menuMusic)
        }
        
        if startSound == nil {
            let soundStart = SKAudioNode(fileNamed: "Gamestart_Plasterbrain.mp3")
            soundStart.autoplayLooped = false
            self.addChild(soundStart)
            soundStart.run(SKAction.stop())
            startSound = soundStart
        }
        
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.agreeButton = self.childNode(withName: "//agreeButton") as? SKSpriteNode
        self.prevMapButton = self.childNode(withName: "//prevMapButton") as? SKSpriteNode
        self.nextMapButton = self.childNode(withName: "//nextMapButton") as? SKSpriteNode
        self.settingsButton = self.childNode(withName: "//settingsButton") as? SKSpriteNode
        self.helpButton = self.childNode(withName: "//helpButton") as? SKSpriteNode
        self.connectedCounter = self.childNode(withName: "//connectedCounter") as? SKSpriteNode
        self.connectedCounterLabel = SKLabelNode()
        self.connectedCounter?.addChild(connectedCounterLabel!)
        
        self.p1ChosenView = self.childNode(withName: "//chosen1") as? SKSpriteNode
        self.p2ChosenView = self.childNode(withName: "//chosen2") as? SKSpriteNode
        self.p3ChosenView = self.childNode(withName: "//chosen3") as? SKSpriteNode
        self.p4ChosenView = self.childNode(withName: "//chosen4") as? SKSpriteNode
        
        self.jackButton = self.childNode(withName: "//jackButton") as? SKSpriteNode
        let jackView = SKSpriteNode(texture: characterAtlas.textureNamed("Jack-O_Idle"))
        jackView.xScale = 0.8
        jackView.yScale = 0.8
        
        self.plumButton = self.childNode(withName: "//plumButton") as? SKSpriteNode
        let plumView = SKSpriteNode(texture: characterAtlas.textureNamed("Plum_Idle"))
        
        self.rosettaButton = self.childNode(withName: "//rosettaButton") as? SKSpriteNode
        let rosettaView = SKSpriteNode(texture: characterAtlas.textureNamed("Rosetta_Idle"))
        
        self.silvaButton = self.childNode(withName: "//silvaButton") as? SKSpriteNode
        let silvaView = SKSpriteNode(texture: characterAtlas.textureNamed("Silva_Idle"))
        
        self.cogButton = self.childNode(withName: "//cogButton") as? SKSpriteNode
        let cogView = SKSpriteNode(texture: characterAtlas.textureNamed("Cog_Idle"))
        
        self.sarahButton = self.childNode(withName: "//sarahButton") as? SKSpriteNode
        let sarahView = SKSpriteNode(texture: characterAtlas.textureNamed("Sarah_Idle"))
        
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
            
            if self.atPoint(pos) == self.agreeButton && readyForGame && !helpMode {
                chosenMap = mapList[mapIndex]
                if sfxEnabled {
                    startSound.run(SKAction.play())
                }
                
                menuMusic.run(SKAction.pause(),completion:{
                    menuMusic.removeFromParent()
                })
                
                self.run(SKAction.wait(forDuration: 1.0),completion:{
                    if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                        self.headToGameScene()
                    } else if appDelegate.mpcHandler.session != nil {
                        MP_TRAFFIC_HANDLER.sendPlayerBlessings()
                        self.run(SKAction.wait(forDuration: 0.15),completion:{
                            MP_TRAFFIC_HANDLER.sendStartGameMessage()
                            self.headToGameScene()
                        })
                    } else if GK_TRAFFIC_HANDLER.match != nil {
                        GK_TRAFFIC_HANDLER.sendPlayerBlessings()
                        self.run(SKAction.wait(forDuration: 0.15),completion:{
                            GK_TRAFFIC_HANDLER.sendStartGameMessage()
                            self.headToGameScene()
                        })
                    }
                })
            } else if (self.helpButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if helpMode {
                    helpMode = false
                } else {
                    helpMode = true
                }
            } else if (self.prevMapButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                mapIndex -= 1
                if mapIndex < 0 {
                    mapIndex = 0
                }
                chosenMap = mapList[mapIndex]
            } else if (self.nextMapButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                mapIndex += 1
                if mapIndex > 4 {
                    mapIndex = 4
                }
                chosenMap = mapList[mapIndex]
            } else if self.atPoint(pos) == self.backButton {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                menuMusic.run(SKAction.pause(),completion:{
                    menuMusic.removeFromParent()
                })
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                        self.backToModeSelect()
                    } else {
                        if GK_TRAFFIC_HANDLER.match != nil {
                            GK_TRAFFIC_HANDLER.backToModeSelect()
                            self.backToModeSelect()
                        } else if appDelegate.mpcHandler.session != nil {
                            MP_TRAFFIC_HANDLER.backToModeSelect()
                            self.backToModeSelect()
                        }
                    }
                })
            } else if self.atPoint(pos) == self.settingsButton {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                menuMusic.run(SKAction.pause(),completion:{
                    menuMusic.removeFromParent()
                })
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    if let sceneNode = GameOptionsScene(fileNamed: "GameOptionsScene") {
                        sceneNode.scaleMode = globalScaleMode
                        
                        if let view = self.view {
                            view.presentScene(sceneNode)
                            view.ignoresSiblingOrder = false
                            
                            view.showsFPS = false
                            view.showsNodeCount = false
                        }
                        
                    }
                })
            } else if (self.jackButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Jack-O \n Beige Button: Summon Zombie couple. \n Beige + Move Buttons: Slide tackle. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Jack-O"
                }
            } else if (self.plumButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Plum \n Teal Button: Throw Kunai. \n Beige Button: Sword Slash. \n Beige + Move Buttons: Slide Tackle. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Plum"
                }
            } else if (self.rosettaButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Rosetta \n Teal Button: Throw Kunai. \n Beige Button: Sword Slash. \n Beige + Move Buttons: Slide Tackle. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Rosetta"
                }
            } else if (self.silvaButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Silva \n Teal Button: Sword Slash. \n Beige Button: Damage Buff. \n Beige + Move Buttons: Movespeed Buff. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Silva"
                }
            } else if (self.cogButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Cog (Cat + Dog) \n Teal Button: Switch with your buddy. \n Beige Button: Double Slide Tackle. \n Beige + Move Buttons: Slide Tackle. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Cog"
                }
            } else if (self.sarahButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "Name: Sarah \n Teal Button: Knife Slash. \n Beige Button: Gunshot. \n Beige + Move Buttons: Slide Tackle. \n Lime Button: Use Mastery Move."
                    let title = "About this Basher"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = "Sarah"
                }
            } else {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                    chosenBasher2 = characterRoulette()
                    chosenBasher3 = characterRoulette()
                    chosenBasher4 = characterRoulette()
                }
                
                if helpMode {
                    let message = "This Button is either empty or requires no description."
                    let title = "About This Button "
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenBasher = ""
                }
            }
            
            if appDelegate.mpcHandler.session != nil {
                MP_TRAFFIC_HANDLER.sendPlayerCharacter()
            } else if GK_TRAFFIC_HANDLER.match != nil {
                print("Shouldve sent Player Basher...")
                GK_TRAFFIC_HANDLER.sendPlayerCharacter()
            }
            updateUI()
        }
    }
    
    func updateUI() {
        if chosenMap == "Origins" {
            mapIndex = 0
        } else if chosenMap == "Buckets" {
            mapIndex = 1
        } else if chosenMap == "Tunnels" {
            mapIndex = 2
        } else if chosenMap == "Caves" {
            mapIndex = 3
        } else if chosenMap == "SkyDen" {
            mapIndex = 4
        }
        
        if mapIndex == 0 {
            prevMapButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Left_Grey")))
        } else if mapIndex == 4 {
            nextMapButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Right_Grey")))
        } else {
            prevMapButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Left")))
            nextMapButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Right")))
        }
        
        if helpMode {
            helpButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Help_Active")))
        } else {
            helpButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Help")))
        }
        
        if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
            if chosenBasher == "" || helpMode {
                self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                readyForGame = false
            } else {
                self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                readyForGame = true
            }
        } else {
            if appDelegate.mpcHandler.session != nil {
                if appDelegate.mpcHandler.session.connectedPeers.count == 1 {
                    if chosenBasher == "" || chosenBasher2 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                } else if appDelegate.mpcHandler.session.connectedPeers.count == 2 {
                    if chosenBasher == "" || chosenBasher2 == "" || chosenBasher3 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                } else if appDelegate.mpcHandler.session.connectedPeers.count == 3 {
                    if chosenBasher == "" || chosenBasher2 == "" || chosenBasher3 == "" || chosenBasher4 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                }
            } else if GK_TRAFFIC_HANDLER.match != nil {
                if GK_TRAFFIC_HANDLER.match.players.count == 1 {
                    if chosenBasher == "" || chosenBasher2 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                } else if GK_TRAFFIC_HANDLER.match.players.count == 2 {
                    if chosenBasher == "" || chosenBasher2 == "" || chosenBasher3 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                } else if GK_TRAFFIC_HANDLER.match.players.count == 3 {
                    if chosenBasher == "" || chosenBasher2 == "" || chosenBasher3 == "" || chosenBasher4 == "" || helpMode {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
                        readyForGame = false
                    } else {
                        self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
                        readyForGame = true
                    }
                }
            }
        }
        
        if lastChosenBasher != chosenBasher {
            lastChosenBasher = chosenBasher
            if chosenBasher == "" {
                p1ChosenView!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                p1ChosenView!.xScale = 1
                p1ChosenView!.yScale = 1
                p1ChosenView!.size = CGSize(width: 100, height: 100)
            } else {
                p1ChosenView!.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher + "_Idle")))
                p1ChosenView!.xScale = 1
                p1ChosenView!.yScale = 1
                p1ChosenView!.size = charAtlas.textureNamed(chosenBasher + "_Idle").size()
                
                if chosenBasher == "Jack-O" || chosenBasher == "Silva" {
                    p1ChosenView!.xScale = 0.75
                    p1ChosenView!.yScale = 0.75
                }
            }
        }
        
        if chosenBasher2 == "" {
            p2ChosenView!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
            p2ChosenView!.xScale = 1
            p2ChosenView!.yScale = 1
            p2ChosenView!.size = CGSize(width: 100, height: 100)
        } else {
            p2ChosenView!.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher2 + "_Idle")))
            p2ChosenView!.xScale = 1
            p2ChosenView!.yScale = 1
            p2ChosenView!.size = charAtlas.textureNamed(chosenBasher2 + "_Idle").size()
            
            if chosenBasher2 == "Jack-O" || chosenBasher2 == "Silva" {
                p2ChosenView!.xScale = 0.75
                p2ChosenView!.yScale = 0.75
            }
        }
        
        if chosenBasher3 == "" {
            p3ChosenView!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
            p3ChosenView!.xScale = 1
            p3ChosenView!.yScale = 1
            p3ChosenView!.size = CGSize(width: 100, height: 100)
        } else {
            p3ChosenView!.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher3 + "_Idle")))
            p3ChosenView!.xScale = 1
            p3ChosenView!.yScale = 1
            p3ChosenView!.size = charAtlas.textureNamed(chosenBasher3 + "_Idle").size()
            
            if chosenBasher3 == "Jack-O" || chosenBasher3 == "Silva" {
                p3ChosenView!.xScale = 0.75
                p3ChosenView!.yScale = 0.75
            }
        }
        
        if chosenBasher4 == "" {
            p4ChosenView!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
            p4ChosenView!.xScale = 1
            p4ChosenView!.yScale = 1
            p4ChosenView!.size = CGSize(width: 100, height: 100)
        } else {
            p4ChosenView!.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher4 + "_Idle")))
            p4ChosenView!.xScale = 1
            p4ChosenView!.yScale = 1
            p4ChosenView!.size = charAtlas.textureNamed(chosenBasher4 + "_Idle").size()
            
            if chosenBasher4 == "Jack-O" || chosenBasher4 == "Silva" {
                p4ChosenView!.xScale = 0.75
                p4ChosenView!.yScale = 0.75
            }
        }
        
        if readyForGame && gameScene != nil {
            gameScene = nil
        }
    }
    
    func characterRoulette() -> String {
        let randomNum:Int = Int(arc4random_uniform(6) + 1)
        var chosenOne = ""
        
        switch randomNum {
        case 1:
            chosenOne = "Jack-O"
        case 2:
            chosenOne = "Plum"
        case 3:
            chosenOne = "Rosetta"
        case 4:
            chosenOne = "Silva"
        case 5:
            chosenOne = "Cog"
        case 6:
            chosenOne = "Sarah"
        default:
            chosenOne = ""
            break;
        }
        
        return chosenOne
    }
    
    func headToGameScene() {
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.playerCharacter = chosenBasher
                sceneNode.setUpAtlases()
                sceneNode.scaleMode = gameScaleMode
                
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
    func backToModeSelect() {
        // Present the scene
        if let view = self.view {
            view.presentScene(modeSelect)
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = false
        }
    }
}
