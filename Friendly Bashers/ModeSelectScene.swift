//
//  ModeSelectScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class ModeSelectScene:SKScene {
    fileprivate var lastUpdateTime : TimeInterval = 0
    
    var backButton:SKSpriteNode?
    var agreeButton:SKSpriteNode?
    var createPartyButton:SKSpriteNode?
    var leaveMatchButton:SKSpriteNode?
    
    var regularModeButton:SKSpriteNode?
    var gemRushModeButton:SKSpriteNode?
    var doomHolesModeButton:SKSpriteNode?
    var masterModeButton:SKSpriteNode?
    
    var multiplayerSelect:SKSpriteNode?
    var localplaySelect:SKSpriteNode?
    var netplaySelect:SKSpriteNode?
    var cancelMultiplayerSelect:SKSpriteNode?
    
    var playerDisplay1:SKLabelNode?
    var playerDisplay2:SKLabelNode?
    var playerDisplay3:SKLabelNode?
    var playerDisplay4:SKLabelNode?
    
    var backgroundAtlas = bgAtlas
    var UIAtlas = uiAtlas
    
    override func sceneDidLoad() {
        modeSelect = self
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        if appDelegate == nil {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        }
        
        self.playerDisplay1 = self.childNode(withName: "//playerDisplay1") as? SKLabelNode
        self.playerDisplay2 = self.childNode(withName: "//playerDisplay2") as? SKLabelNode
        self.playerDisplay3 = self.childNode(withName: "//playerDisplay3") as? SKLabelNode
        self.playerDisplay4 = self.childNode(withName: "//playerDisplay4") as? SKLabelNode
        self.multiplayerSelect = self.childNode(withName: "//multiPlaySelect") as? SKSpriteNode
        self.localplaySelect = self.childNode(withName: "//localPlay") as? SKSpriteNode
        self.netplaySelect = self.childNode(withName: "//netPlay") as? SKSpriteNode
        self.cancelMultiplayerSelect = self.childNode(withName: "//cancelButton") as? SKSpriteNode
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.agreeButton = self.childNode(withName: "//agreeButton") as? SKSpriteNode
        self.createPartyButton = self.childNode(withName: "//createPartyButton") as? SKSpriteNode
        self.leaveMatchButton = self.childNode(withName: "//quitMatch") as? SKSpriteNode
        
        self.regularModeButton = self.childNode(withName: "//regularModeButton") as? SKSpriteNode
        self.gemRushModeButton = self.childNode(withName: "//gemBashButton") as? SKSpriteNode
        self.doomHolesModeButton = self.childNode(withName: "//doomHolesButton") as? SKSpriteNode
        self.masterModeButton = self.childNode(withName: "//masterModeButton") as? SKSpriteNode
        updateUI()
        
        self.multiplayerSelect?.isHidden = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.agreeButton && chosenMode != "" {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.testForConnections()
                })
            } else if self.localplaySelect!.contains(pos) && !self.multiplayerSelect!.isHidden {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                MP_TRAFFIC_HANDLER.startMPC()
            } else if self.netplaySelect!.contains(pos) && !self.multiplayerSelect!.isHidden {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                GK_TRAFFIC_HANDLER.startGKTH()
            } else if self.cancelMultiplayerSelect!.contains(pos) && !self.multiplayerSelect!.isHidden {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                appDelegate.mpcHandler.session = nil
                GK_TRAFFIC_HANDLER.match = nil
                
                self.dismissMultiplayerSelect()
            } else if self.atPoint(pos) == self.backButton {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.backToMainMenu()
                })
            } else if self.atPoint(pos) == self.leaveMatchButton {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if appDelegate.mpcHandler.session != nil {
                    MP_TRAFFIC_HANDLER.disconnectFromPlayers()
                    otherPlayers[0] = ""
                    otherPlayers[1] = ""
                    otherPlayers[2] = ""
                } else if GK_TRAFFIC_HANDLER.match != nil {
                    GK_TRAFFIC_HANDLER.disconnectFromPlayers()
                    otherPlayers[0] = ""
                    otherPlayers[1] = ""
                    otherPlayers[2] = ""
                }
            } else if self.atPoint(pos) == self.createPartyButton {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                chosenBasher2 = ""
                chosenBasher3 = ""
                chosenBasher4 = ""
                
                if winCount < 1 {
                    let message = "Sorry but you need at least 1 Win to play this gamemode. \n You have: " + String(describing: winCount) + " Win(s)"
                    let title = "About Multiplayer"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    self.showMultiplayerSelect()
                }
            } else if self.regularModeButton!.contains(pos) {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                chosenMode = "Regular"
            } else if self.gemRushModeButton!.contains(pos) {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if winCount < 20 {
                    let message = "Sorry but you need at least 20 Wins to play this gamemode. \n You have: " + String(describing: winCount) + " Win(s)"
                    let title = "About Gem Bash"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    //chosenMode = "GemBash"
                    let message = "Sorry this gamemode is temporarily unavailable."
                    let title = "About Gem Bash"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                }
            } else if self.doomHolesModeButton!.contains(pos) {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if winCount < 50 {
                    let message = "Sorry but you need at least 50 Wins to play this gamemode. \n You have: " + String(describing: winCount) + " Win(s)"
                    let title = "About Doom Holes"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    //chosenMode = "DoomHoles"
                    let message = "Sorry this gamemode is temporarily unavailable."
                    let title = "About Doom Holes"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                }
            } else if self.masterModeButton!.contains(pos) {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if winCount < 8 {
                    let message = "Sorry but you need at least 8 Wins to play this gamemode. \n You have: " + String(describing: winCount) + " Win(s)"
                    let title = "About Chaos"
                    let userInfo = ["title":title,"message":message]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AlertMessage"), object: nil,userInfo: userInfo)
                } else {
                    chosenMode = "Chaos"
                }
            } else {
                chosenMode = ""
            }
            
            self.updateUI()
            
            if appDelegate.mpcHandler.session != nil {
                MP_TRAFFIC_HANDLER.syncGameMode()
            } else if GK_TRAFFIC_HANDLER.match != nil {
                GK_TRAFFIC_HANDLER.syncGameMode()
            }
        }
    }
    
    func showMultiplayerSelect() {
        multiplayerSelect?.isHidden = false
    }
    
    func dismissMultiplayerSelect() {
        multiplayerSelect?.isHidden = true
    }
    
    func updateUI() {
        if chosenMode == "" {
            self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree_Disabled")))
        } else {
            self.agreeButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Agree")))
        }
        
        self.playerDisplay1?.text = "P1: " + playerName
        self.playerDisplay2?.text = "P2: " + otherPlayers[0]
        self.playerDisplay3?.text = "P3: " + otherPlayers[1]
        self.playerDisplay4?.text = "P4: " + otherPlayers[2]
        
        if chosenMode == "Regular" {
            regularModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Selected")))
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
        } else if chosenMode == "Chaos" {
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Selected")))
            regularModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
        } else if chosenMode == "GemBash" {
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Selected")))
            regularModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
        } else if chosenMode == "DoomHoles" {
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Selected")))
            regularModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
        } else {
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            regularModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Enabled")))
        }
        
        if winCount < 8 {
            masterModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
        } else if winCount < 20 {
            gemRushModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
        } else if winCount < 50 {
            doomHolesModeButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Disabled")))
        }
    }
    
    func testForConnections() {
        if appDelegate.mpcHandler.session != nil {
            if appDelegate.mpcHandler.session.connectedPeers.count == 0 {
                appDelegate.mpcHandler.session = nil
                headToBasherSelect(false)
            } else {
                headToBasherSelect(false)
            }
        } else if GK_TRAFFIC_HANDLER.match != nil {
            if GK_TRAFFIC_HANDLER.match.players.count == 0 {
                GK_TRAFFIC_HANDLER.match = nil
                headToBasherSelect(false)
            } else {
                headToBasherSelect(false)
            }
        } else {
            headToBasherSelect(false)
        }
    }

    func headToBasherSelect(_ receiving:Bool) {
        if !receiving && appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.sendChooseBasherMsg()
            primaryPlayer = true
        } else if !receiving && GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.sendChooseBasherMsg()
            primaryPlayer = true
        } else if !receiving && appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
            primaryPlayer = true
        }
        
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
    
    func backToMainMenu() {
        if let view = self.view {
            view.presentScene(mainMenu)
            view.ignoresSiblingOrder = false
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
}
