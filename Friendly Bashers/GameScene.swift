//
//  GameScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/17/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit

var CharacterCategory:UInt32 = 0x1 << 1
var ProjectileCategory:UInt32 = 0x1 << 2
var WorldCategory:UInt32 = 0x1 << 3
var SummonedCategory:UInt32 = 0x1 << 4

class GameScene: SKScene, SKPhysicsContactDelegate {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var playerCharacter = ""
    var timeSinceNoAction: TimeInterval = 0
    var lastSyncTime:TimeInterval = 0
    
    var playerCharacter2 = ""
    var playerCharacter3 = ""
    var playerCharacter4 = ""
    
    var gamePaused = false
    var multiplayerGame = false
    
    private var lastUpdateTime : TimeInterval = 0
    var CAMERA_NODE : SKCameraNode?
    var playerNode : Character!
    var playerNode2 : CPU!
    var playerNode3 : CPU!
    var playerNode4 : CPU!
    var tileMapNode : SKTileMapNode?
    
    var pauseButton: SKSpriteNode?
    var pauseUI:SKSpriteNode?
    var sfxButton:SKSpriteNode?
    var musicButton:SKSpriteNode?
    var exitButton:SKSpriteNode?
    var homeButton:SKSpriteNode?
    
    var player1Bubble: SKSpriteNode?
    var player1Name: SKLabelNode?
    var player1Health: SKSpriteNode?
    
    var player2Bubble: SKSpriteNode?
    var player2Name: SKLabelNode?
    var player2Health: SKSpriteNode?
    
    var player3Bubble: SKSpriteNode?
    var player3Name: SKLabelNode?
    var player3Health: SKSpriteNode?
    
    var player4Bubble: SKSpriteNode?
    var player4Name: SKLabelNode?
    var player4Health: SKSpriteNode?
    
    var leftButton: SKSpriteNode?
    var rightButton: SKSpriteNode?
    
    var runeButton: SKSpriteNode?
    var skillButton_1: SKSpriteNode?
    var skillButton_2: SKSpriteNode?
    var jumpButton : SKSpriteNode?
    
    var skillChargeDisplay_1:SKLabelNode?
    var skillChargeDisplay_2:SKLabelNode?
    var skillChargeDisplay_3:SKLabelNode?
    
    var p1ChosenView:SKSpriteNode?
    var p2ChosenView:SKSpriteNode?
    var p3ChosenView:SKSpriteNode?
    var p4ChosenView:SKSpriteNode?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        gameScene = self
        if appDelegate.mpcHandler.session != nil {
            multiplayerGame = true
        }
        playerCharacter2 = chosenBasher2
        playerCharacter3 = chosenBasher3
        playerCharacter4 = chosenBasher4
        self.physicsWorld.contactDelegate = self
        self.CAMERA_NODE = self.childNode(withName: "//CAMERA_NODE") as? SKCameraNode
        self.tileMapNode = self.childNode(withName: "//TILE_MAP") as? SKTileMapNode
        
        var playerTexture = SKTexture(imageNamed: self.playerCharacter + "_Idle_1")
        
        if self.playerCharacter == "Cog" {
            playerTexture = SKTexture(imageNamed: "Cat_Idle_1")
        }
        
        self.playerNode = Character(texture: playerTexture)
        if self.playerCharacter == "Cog" {
            playerNode.characterForm = "Cat"
        }
        
        self.playerNode.player = playerName
        self.playerNode.setUp(name: self.playerCharacter)
        self.playerNode.position = CGPoint(x: -80, y: (self.playerNode?.size.height)!/2 + 33)
        self.playerNode.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerTexture.size())
        self.playerNode.physicsBody!.allowsRotation = false
        self.playerNode.physicsBody!.linearDamping = 1.0
        self.playerNode.physicsBody!.contactTestBitMask = ProjectileCategory
        self.playerNode.physicsBody!.categoryBitMask = CharacterCategory
        self.playerNode.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
        self.p1ChosenView = SKSpriteNode(texture: playerTexture)
        
        if playerCharacter2 != "" {
            var playerTexture2 = SKTexture(imageNamed: self.playerCharacter2 + "_Idle_1")
            
            if self.playerCharacter2 == "Cog" {
                playerTexture2 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode2 = CPU(texture: playerTexture2)
            self.playerNode2.setUp(name: self.playerCharacter2)
            self.playerNode2.position = CGPoint(x: 40, y: (self.playerNode2?.size.height)!/2 + 33)
            self.playerNode2.physicsBody = SKPhysicsBody(texture: playerTexture2, size: playerTexture2.size())
            self.playerNode2.physicsBody!.allowsRotation = false
            self.playerNode2.physicsBody!.linearDamping = 1.0
            self.playerNode2.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode2.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode2.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(playerNode2!)
            self.p2ChosenView = SKSpriteNode(texture: playerTexture2)
        } else {
            playerCharacter2 = characterRoulette()
            var playerTexture2 = SKTexture(imageNamed: self.playerCharacter2 + "_Idle_1")
            
            if self.playerCharacter2 == "Cog" {
                playerTexture2 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode2 = CPU(texture: playerTexture2)
            self.playerNode2.player = "CPU1"
            self.playerNode2.setUp(name: self.playerCharacter2)
            self.playerNode2.position = CGPoint(x: 40, y: (self.playerNode2?.size.height)!/2 + 33)
            self.playerNode2.physicsBody = SKPhysicsBody(texture: playerTexture2, size: playerTexture2.size())
            self.playerNode2.physicsBody!.allowsRotation = false
            self.playerNode2.physicsBody!.linearDamping = 1.0
            self.playerNode2.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode2.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode2.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(playerNode2!)
            self.playerNode2.world = self
            self.playerNode2.startCPU()
            self.p2ChosenView = SKSpriteNode(texture: playerTexture2)
        }
        
        if playerCharacter3 != "" {
            var playerTexture3 = SKTexture(imageNamed: self.playerCharacter3 + "_Idle_1")
            
            if self.playerCharacter3 == "Cog" {
                playerTexture3 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode3 = CPU(texture: playerTexture3)
            self.playerNode3.setUp(name: self.playerCharacter3)
            self.playerNode3.position = CGPoint(x: 160, y: (self.playerNode3?.size.height)!/3 + 33)
            self.playerNode3.physicsBody = SKPhysicsBody(texture: playerTexture3, size: playerTexture3.size())
            self.playerNode3.physicsBody!.allowsRotation = false
            self.playerNode3.physicsBody!.linearDamping = 1.0
            self.playerNode3.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode3.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode3.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(playerNode3!)
            self.p3ChosenView = SKSpriteNode(texture: playerTexture3)
        } else if playerCharacter3 == "" && !multiplayerGame {
            self.playerCharacter3 = self.characterRoulette()
            var playerTexture3 = SKTexture(imageNamed: self.playerCharacter3 + "_Idle_1")
            
            if self.playerCharacter3 == "Cog" {
                playerTexture3 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode3 = CPU(texture: playerTexture3)
            self.playerNode3.player = "CPU2"
            self.playerNode3.setUp(name: self.playerCharacter3)
            self.playerNode3.position = CGPoint(x: 160, y: (self.playerNode3?.size.height)!/3 + 33)
            self.playerNode3.physicsBody = SKPhysicsBody(texture: playerTexture3, size: playerTexture3.size())
            self.playerNode3.physicsBody!.allowsRotation = false
            self.playerNode3.physicsBody!.linearDamping = 1.0
            self.playerNode3.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode3.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode3.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(self.playerNode3!)
            self.playerNode3.world = self
            self.playerNode3.startCPU()
            self.p3ChosenView = SKSpriteNode(texture: playerTexture3)
        }
        
        if playerCharacter4 != "" {
            var playerTexture4 = SKTexture(imageNamed: self.playerCharacter4 + "_Idle_1")
            
            if self.playerCharacter4 == "Cog" {
                playerTexture4 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode4 = CPU(texture: playerTexture4)
            self.playerNode4.setUp(name: self.playerCharacter4)
            self.playerNode4.position = CGPoint(x: 280, y: (self.playerNode4?.size.height)!/4 + 33)
            self.playerNode4.physicsBody = SKPhysicsBody(texture: playerTexture4, size: playerTexture4.size())
            self.playerNode4.physicsBody!.allowsRotation = false
            self.playerNode4.physicsBody!.linearDamping = 1.0
            self.playerNode4.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode4.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode4.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(playerNode4!)
            self.p4ChosenView = SKSpriteNode(texture: playerTexture4)
        } else if playerCharacter4 == "" && !multiplayerGame {
            self.playerCharacter4 = self.characterRoulette()
            var playerTexture4 = SKTexture(imageNamed: self.playerCharacter4 + "_Idle_1")
            
            if self.playerCharacter4 == "Cog" {
                playerTexture4 = SKTexture(imageNamed: "Cat_Idle_1")
            }
            self.playerNode4 = CPU(texture: playerTexture4)
            self.playerNode4.player = "CPU3"
            self.playerNode4.setUp(name: self.playerCharacter4)
            self.playerNode4.position = CGPoint(x: 280, y: (self.playerNode4?.size.height)!/4 + 33)
            self.playerNode4.physicsBody = SKPhysicsBody(texture: playerTexture4, size: playerTexture4.size())
            self.playerNode4.physicsBody!.allowsRotation = false
            self.playerNode4.physicsBody!.linearDamping = 1.0
            self.playerNode4.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode4.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode4.physicsBody!.collisionBitMask = WorldCategory | ProjectileCategory
            self.tileMapNode!.addChild(self.playerNode4!)
            self.playerNode4.world = self
            self.playerNode4.startCPU()
            self.p4ChosenView = SKSpriteNode(texture: playerTexture4)
        }
        
        jumpButton = SKSpriteNode(imageNamed: "Button_Up")
        jumpButton?.scale(to: CGSize(width: 135, height: 135))
        skillButton_1 = SKSpriteNode(imageNamed: "Button_Blue")
        skillButton_1?.scale(to: CGSize(width: 135, height: 135))
        skillButton_2 = SKSpriteNode(imageNamed: "Button_Blue")
        skillButton_2?.scale(to: CGSize(width: 135, height: 135))
        runeButton = SKSpriteNode(imageNamed: "Button_Blue")
        runeButton?.scale(to: CGSize(width: 135, height: 135))
        
        leftButton = SKSpriteNode(imageNamed: "Button_Left")
        leftButton?.scale(to: CGSize(width: 135, height: 135))
        rightButton = SKSpriteNode(imageNamed: "Button_Right")
        rightButton?.scale(to: CGSize(width: 135, height: 135))
        
        pauseButton = SKSpriteNode(imageNamed: "Button_Pause")
        pauseButton?.scale(to: CGSize(width: 135, height: 135))
        
        pauseUI = SKSpriteNode(color: UIColor.black, size: CGSize(width: self.size.width, height: self.size.height))
        pauseUI?.alpha = 0.6
        
        sfxButton = SKSpriteNode(imageNamed: "Button_Sfx_Off")
        sfxButton?.scale(to: CGSize(width: 135, height: 135))
        sfxButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 200)
        
        musicButton = SKSpriteNode(imageNamed: "Button_Music_Off")
        musicButton?.scale(to: CGSize(width: 135, height: 135))
        musicButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 330)
        
        homeButton = SKSpriteNode(imageNamed: "Button_Home")
        homeButton?.scale(to: CGSize(width: 135, height: 135))
        homeButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 455)
        
        exitButton = SKSpriteNode(imageNamed: "Button_Exit")
        exitButton?.scale(to: CGSize(width: 135, height: 135))
        exitButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 585)
        
        skillChargeDisplay_1 = SKLabelNode(text: "0")
        skillChargeDisplay_1?.fontColor = SKColor.black
        skillChargeDisplay_1?.fontSize = 40
        
        skillChargeDisplay_2 = SKLabelNode(text: "0")
        skillChargeDisplay_2?.fontColor = SKColor.black
        skillChargeDisplay_2?.fontSize = 40
        
        skillChargeDisplay_3 = SKLabelNode(text: "0")
        skillChargeDisplay_3?.fontColor = SKColor.black
        skillChargeDisplay_3?.fontSize = 40
        
        //Right Side of Screen
        jumpButton?.position = CGPoint(x: self.size.width/2 - 75,y: -self.size.height/2 + 75) //Bottom Right
        skillButton_1?.position = CGPoint(x: self.size.width/2 - 205,y: -self.size.height/2 + 75) //Bottom Left
        skillChargeDisplay_1?.position = CGPoint(x: 0,y: 0)
        runeButton?.position = CGPoint(x: self.size.width/2 - 205,y: -self.size.height/2 + 205) //Top Left
        skillButton_2?.position = CGPoint(x: self.size.width/2 - 75,y: -self.size.height/2 + 205) // Top Right
        skillChargeDisplay_2?.position = CGPoint(x: 0,y: 0)
        skillChargeDisplay_3?.position = CGPoint(x: 0,y: 0)
        
        pauseButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 75)
        
        //Left Side of Screen
        leftButton?.position = CGPoint(x: -self.size.width/2 + 75,y: -self.size.height/2 + 75)
        rightButton?.position = CGPoint(x: -self.size.width/2 + 205,y: -self.size.height/2 + 75)
        
        player1Bubble = SKSpriteNode(imageNamed: "Button_Green")
        player1Bubble?.position = CGPoint(x: -self.size.width/2 + 120,y: self.size.height/2 - 75)
        player1Bubble?.size.width = 120
        player1Bubble?.size.height = 120
        
        player1Name = SKLabelNode(text: "")
        player1Name?.text = playerName
        player1Name?.fontColor = UIColor.black
        player1Name?.position = CGPoint(x: -self.size.width/2 + 120,y: self.size.height/2 - 150)
        
        player1Health = SKSpriteNode(imageNamed: "HealthBar")
        player1Health?.position = CGPoint(x: -self.size.width/2 + 45,y: self.size.height/2 - 135)
        player1Health?.size.height = 120
        player1Health?.size.width = 40
        player1Health?.anchorPoint.y = 0
        
        player2Bubble = SKSpriteNode(imageNamed: "Button_Green")
        player2Bubble?.position = CGPoint(x: -self.size.width/2 + 290,y: self.size.height/2 - 75)
        player2Bubble?.size.width = 120
        player2Bubble?.size.height = 120
        
        player2Name = SKLabelNode(text: "")
        player2Name?.text = "P2"
        player2Name?.fontColor = UIColor.black
        player2Name?.position = CGPoint(x: -self.size.width/2 + 290,y: self.size.height/2 - 150)
        
        player2Health = SKSpriteNode(imageNamed: "HealthBar")
        player2Health?.position = CGPoint(x: -self.size.width/2 + 215,y: self.size.height/2 - 135)
        player2Health?.size.height = 120
        player2Health?.size.width = 40
        player2Health?.anchorPoint.y = 0
        
        player3Bubble = SKSpriteNode(imageNamed: "Button_Green")
        player3Bubble?.position = CGPoint(x: -self.size.width/2 + 460,y: self.size.height/2 - 75)
        player3Bubble?.size.width = 120
        player3Bubble?.size.height = 120
        
        player3Name = SKLabelNode(text: "")
        player3Name?.text = "P3"
        player3Name?.fontColor = UIColor.black
        player3Name?.position = CGPoint(x: -self.size.width/2 + 460,y: self.size.height/2 - 150)
        
        player3Health = SKSpriteNode(imageNamed: "HealthBar")
        player3Health?.position = CGPoint(x: -self.size.width/2 + 385,y: self.size.height/2 - 135)
        player3Health?.size.height = 120
        player3Health?.size.width = 40
        player3Health?.anchorPoint.y = 0

        player4Bubble = SKSpriteNode(imageNamed: "Button_Green")
        player4Bubble?.position = CGPoint(x: -self.size.width/2 + 630,y: self.size.height/2 - 75)
        player4Bubble?.size.width = 120
        player4Bubble?.size.height = 120
        
        player4Name = SKLabelNode(text: "")
        player4Name?.text = "P4"
        player4Name?.fontColor = UIColor.black
        player4Name?.position = CGPoint(x: -self.size.width/2 + 630,y: self.size.height/2 - 150)
        
        player4Health = SKSpriteNode(imageNamed: "HealthBar")
        player4Health?.position = CGPoint(x: -self.size.width/2 + 555,y: self.size.height/2 - 135)
        player4Health?.size.height = 120
        player4Health?.size.width = 40
        player4Health?.anchorPoint.y = 0
        
        var tilePhysicsBodyArray = [SKPhysicsBody]()
        
        for row in 0...self.tileMapNode!.numberOfRows {
            for column in 0...self.tileMapNode!.numberOfColumns {
                let tileGroup = self.tileMapNode!.tileGroup(atColumn: column, row: row)
                let tileDefinition = self.tileMapNode!.tileDefinition(atColumn: column, row: row)
                let tileOrigin = self.tileMapNode!.centerOfTile(atColumn: column, row: row)
                if tileGroup == nil {
                    
                } else if tileGroup!.name == "Dirt" {
                    let tilePhysicsBody = SKPhysicsBody(rectangleOf: tileDefinition!.size, center: tileOrigin)
                    tilePhysicsBody.affectedByGravity = false
                    tilePhysicsBody.allowsRotation = false
                    tilePhysicsBody.isDynamic = false
                    tilePhysicsBody.contactTestBitMask = ProjectileCategory
                    tilePhysicsBody.categoryBitMask = WorldCategory
                    tilePhysicsBody.collisionBitMask = CharacterCategory
                    
                    tilePhysicsBodyArray.append(tilePhysicsBody)
                }
            }
        }
        
        self.tileMapNode?.physicsBody = SKPhysicsBody(bodies: tilePhysicsBodyArray)
        self.tileMapNode?.physicsBody?.affectedByGravity = false
        self.tileMapNode?.physicsBody?.allowsRotation = false
        self.tileMapNode?.physicsBody?.isDynamic = false
        
        self.CAMERA_NODE?.zPosition = playerNode!.zPosition + 10
        
        self.CAMERA_NODE?.addChild(pauseUI!)
        self.tileMapNode!.addChild(playerNode)
        self.CAMERA_NODE?.addChild(sfxButton!)
        self.CAMERA_NODE?.addChild(musicButton!)
        self.CAMERA_NODE?.addChild(homeButton!)
        self.CAMERA_NODE?.addChild(exitButton!)
        
        self.CAMERA_NODE?.addChild(pauseButton!)
        self.CAMERA_NODE?.addChild(jumpButton!)
        self.CAMERA_NODE?.addChild(skillButton_1!)
        self.CAMERA_NODE?.addChild(skillButton_2!)
        self.CAMERA_NODE?.addChild(runeButton!)
        self.CAMERA_NODE?.addChild(rightButton!)
        self.CAMERA_NODE?.addChild(leftButton!)
        self.CAMERA_NODE?.addChild(player1Health!)
        self.CAMERA_NODE?.addChild(player1Bubble!)
        self.CAMERA_NODE?.addChild(player1Name!)
        self.player1Bubble?.addChild(p1ChosenView!)
        self.CAMERA_NODE?.addChild(player2Health!)
        self.CAMERA_NODE?.addChild(player2Bubble!)
        self.CAMERA_NODE?.addChild(player2Name!)
        self.player2Bubble?.addChild(p2ChosenView!)
        self.skillButton_1?.addChild(skillChargeDisplay_1!)
        self.skillButton_2?.addChild(skillChargeDisplay_2!)
        self.skillButton_2?.addChild(skillChargeDisplay_3!)
        
        if multiplayerGame && appDelegate.mpcHandler.session.connectedPeers.count == 1 {
            player2Name?.text = otherPlayers[0]
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            if multiplayerGame {
                player3Name?.text = otherPlayers[1]
            }
            
            self.CAMERA_NODE?.addChild(player3Health!)
            self.CAMERA_NODE?.addChild(player3Bubble!)
            self.CAMERA_NODE?.addChild(player3Name!)
            self.player3Bubble?.addChild(p3ChosenView!)
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            if multiplayerGame {
                player4Name?.text = otherPlayers[1]
            }
            
            self.CAMERA_NODE?.addChild(player4Health!)
            self.CAMERA_NODE?.addChild(player4Bubble!)
            self.CAMERA_NODE?.addChild(player4Name!)
            self.player4Bubble?.addChild(p4ChosenView!)
        }
        
        self.pauseButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Pause")))
        self.leftButton?.isHidden = false
        self.rightButton?.isHidden = false
        self.skillButton_1?.isHidden = false
        self.skillButton_2?.isHidden = false
        self.runeButton?.isHidden = false
        self.jumpButton?.isHidden = false
        
        self.pauseUI?.isHidden = true
        self.sfxButton?.isHidden = true
        self.musicButton?.isHidden = true
        self.homeButton?.isHidden = true
        self.exitButton?.isHidden = true
        
        if timeLimit != 0 {
            self.run(SKAction.wait(forDuration: Double(timeLimit * 60)),completion:{
                self.endScreen("Out of Time",receiving: false)
            })
        }
        
        if multiplayerGame {
            MP_TRAFFIC_HANDLER.confirmPlayerStats()
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node is Projectile {
            let projectile = contact.bodyA.node as! Projectile
            if contact.bodyB.node is Character {
                let character = contact.bodyB.node as! Character
                if character.player != projectile.owner {
                    character.takeDamage(projectile.damage, direction: projectile.direction!)
                    projectile.removeAllActions()
                    projectile.removeFromParent()
                }
            }
        } else if contact.bodyB.node is Projectile {
            let projectile = contact.bodyB.node as! Projectile
            if contact.bodyA.node is Character {
                let character = contact.bodyA.node as! Character
                if character.player != projectile.owner {
                    character.takeDamage(projectile.damage, direction: projectile.direction!)
                    projectile.removeAllActions()
                    projectile.removeFromParent()
                }
            }
        }
        
        if contact.bodyA.node is AI {
            let ai = contact.bodyA.node as! AI
            if contact.bodyB.node is Character {
                let character = contact.bodyB.node as! Character
                if character.player != ai.player {
                    character.takeDamage(ai.contactDamage, direction: ai.xScale)
                    ai.contactDamage = 0
                }
            }
        } else if contact.bodyB.node is AI {
            let ai = contact.bodyB.node as! AI
            if contact.bodyA.node is Character {
                let character = contact.bodyA.node as! Character
                if character.player != ai.player {
                    character.takeDamage(ai.contactDamage, direction: ai.xScale)
                    ai.contactDamage = 0
                }
            }
        }
        
        if (contact.bodyA.node is Projectile && contact.bodyB.node is Projectile) || (contact.bodyA.node is Projectile && !(contact.bodyB.node is Character)) || (contact.bodyB.node is Projectile && !(contact.bodyA.node is Character)) {
            if contact.bodyA.node is Projectile {
                let projectile = contact.bodyA.node as! Projectile
                projectile.removeAllActions()
                projectile.removeFromParent()
            } else if contact.bodyB.node is Projectile {
                let projectile = contact.bodyB.node as! Projectile
                projectile.removeAllActions()
                projectile.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            if !gamePaused {
                if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                    playerNode?.playerMovement = "Move_Left"
                    self.playerNode.xScale = -1
                } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                    playerNode?.playerMovement = "Move_Right"
                    self.playerNode.xScale = 1
                }
                
                if playerNode?.playerAction == "" {
                    if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Jump"
                    } else if self.atPoint(pos) == self.skillButton_1 && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_1"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerNode?.playerMovement == "" && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_2"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerNode?.playerMovement != "" && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_3"
                    }
                }
                
                if !(self.atPoint(pos) == self.leftButton) && !(self.atPoint(pos) == self.rightButton) && !(self.atPoint(pos) == self.jumpButton) && !(self.atPoint(pos) == self.skillButton_1) && !(self.atPoint(pos) == self.skillButton_2) {
                    playerNode?.playerAction = ""
                    playerNode?.playerMovement = ""
                }
                
                if multiplayerGame {
                    MP_TRAFFIC_HANDLER.sendPlayerInfo()
                }
            } else {
                if self.atPoint(pos) == self.exitButton {
                    quitGame(false)
                } else if self.atPoint(pos) == self.sfxButton {
                    if sfxEnabled {
                        sfxEnabled = false
                    } else {
                        sfxEnabled = true
                    }
                } else if self.atPoint(pos) == self.musicButton {
                    if musicEnabled {
                        musicEnabled = false
                    } else {
                        musicEnabled = true
                    }
                } else if self.atPoint(pos) == self.homeButton {
                    // Present the scene
                    if let view = self.view {
                        view.presentScene(mainMenu)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = true
                        view.showsNodeCount = false
                        
                        if !multiplayerGame {
                            if self.playerNode2.brain != nil {
                                self.playerNode2.brain.invalidate()
                            }
                            
                            if self.playerNode3.brain != nil {
                                self.playerNode3.brain.invalidate()
                            }
                            
                            if self.playerNode4.brain != nil {
                                self.playerNode4.brain.invalidate()
                            }
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                }
            }
            
            if self.atPoint(pos) == self.pauseButton {
                togglePause(false)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            if !gamePaused {
                if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                    playerNode?.playerMovement = "Move_Left"
                    self.playerNode.xScale = -1
                } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                    playerNode?.playerMovement = "Move_Right"
                    self.playerNode.xScale = 1
                }
                
                if playerNode?.playerAction == "" {
                    if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Jump"
                    } else if self.atPoint(pos) == self.skillButton_1 && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_1"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerNode?.playerMovement == "" && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_2"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerNode?.playerMovement != "" && !self.playerNode!.isResting {
                        playerNode?.playerAction = "Skill_3"
                    }
                }
                
                if !(self.atPoint(pos) == self.leftButton) && !(self.atPoint(pos) == self.rightButton) && !(self.atPoint(pos) == self.jumpButton) && !(self.atPoint(pos) == self.skillButton_1) && !(self.atPoint(pos) == self.skillButton_2) {
                    playerNode?.playerAction = ""
                    playerNode?.playerMovement = ""
                }
                
                if multiplayerGame {
                    MP_TRAFFIC_HANDLER.sendPlayerInfo()
                }
            } else {
                if self.atPoint(pos) == self.exitButton {
                    quitGame(false)
                } else if self.atPoint(pos) == self.sfxButton {
                    if sfxEnabled {
                        sfxEnabled = false
                    } else {
                        sfxEnabled = true
                    }
                } else if self.atPoint(pos) == self.musicButton {
                    if musicEnabled {
                        musicEnabled = false
                    } else {
                        musicEnabled = true
                    }
                } else if self.atPoint(pos) == self.homeButton {
                    // Present the scene
                    if let view = self.view {
                        view.presentScene(mainMenu)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = true
                        view.showsNodeCount = false
                        
                        if !multiplayerGame {
                            if self.playerNode2.brain != nil {
                                self.playerNode2.brain.invalidate()
                            }
                            
                            if self.playerNode3.brain != nil {
                                self.playerNode3.brain.invalidate()
                            }
                            
                            if self.playerNode4.brain != nil {
                                self.playerNode4.brain.invalidate()
                            }
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                }
            }
            
            if self.atPoint(pos) == self.pauseButton {
                togglePause(false)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                playerNode?.playerMovement = ""
                self.playerNode.xScale = -1
            } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                playerNode?.playerMovement = ""
                self.playerNode.xScale = 1
            }
            
            if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                playerNode?.playerAction = ""
            }
            
            if multiplayerGame {
                MP_TRAFFIC_HANDLER.sendPlayerInfo()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                playerNode?.playerMovement = ""
                self.playerNode.xScale = -1
            } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                playerNode?.playerMovement = ""
                self.playerNode.xScale = 1
            }
            
            if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                playerNode?.playerAction = ""
            }
            
            if multiplayerGame {
                MP_TRAFFIC_HANDLER.sendPlayerInfo()
            }
        }
    }
    
    func updateUI(_ currentTime: TimeInterval) {
        if self.playerNode!.currentJumps >= self.playerNode!.maxJumps || self.playerNode!.isResting {
            self.jumpButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Up_Grey")))
        } else {
            self.jumpButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Up")))
        }
        
        self.skillChargeDisplay_1?.text = String(self.playerNode!.skillCurrentCharges_1)
        self.skillChargeDisplay_2?.text = String(self.playerNode!.skillCurrentCharges_2)
        self.skillChargeDisplay_3?.text = String(self.playerNode!.skillCurrentCharges_3)
        
        if playerNode!.isSkillReady_1(currentTime) && !self.playerNode!.isResting {
            self.skillButton_1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Blue")))
        } else {
            self.skillButton_1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
        }
        
        if playerNode?.playerMovement == "" {
            self.skillChargeDisplay_2?.isHidden = false
            self.skillChargeDisplay_3?.isHidden = true
            
            if playerNode!.isSkillReady_2(currentTime) && !self.playerNode!.isResting {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Blue")))
            } else {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
            }
        } else {
            self.skillChargeDisplay_2?.isHidden = true
            self.skillChargeDisplay_3?.isHidden = false
            
            if playerNode!.isSkillReady_3(currentTime) && !self.playerNode!.isResting {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Blue")))
            } else {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
            }
        }
        
        if self.playerNode!.isStunned || self.playerNode!.isResting {
            self.leftButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Left_Grey")))
            self.rightButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Right_Grey")))
        } else {
            self.leftButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Left")))
            self.rightButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Right")))
        }
        
        if self.playerNode!.isInvuln {
            //print("Invulnerable")
        }
        
        if musicEnabled {
            musicButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Music_On")))
        } else {
            musicButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Music_Off")))
        }
        
        if sfxEnabled {
            sfxButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Sfx_On")))
        } else {
            sfxButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Sfx_Off")))
        }
        
        if !multiplayerGame || (multiplayerGame && appDelegate.mpcHandler.session.connectedPeers.count == 3) {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                }
            } else if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter2 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter2 + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                }
            } else if self.playerNode3.isDead {
                self.player3Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter3 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode3.characterForm + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode3.characterForm + "_Faint_10")))
                    self.p3ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter3 + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter3 + "_Faint_10")))
                    self.p3ChosenView?.size = texture.size()
                }
            } else if self.playerNode4.isDead {
                self.player4Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter4 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode4.characterForm + "_Faint_10")
                    self.p4ChosenView?.run(SKAction.setTexture(texture))
                    self.p4ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter4 + "_Faint_10")
                    self.p4ChosenView?.run(SKAction.setTexture(texture))
                    self.p4ChosenView?.size = texture.size()
                }
            }
        } else if multiplayerGame && appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                }
            } else if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter2 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter2 + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                }
            } else if self.playerNode3.isDead {
                self.player3Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter3 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode3.characterForm + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode3.characterForm + "_Faint_10")))
                    self.p3ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter3 + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter3 + "_Faint_10")))
                    self.p3ChosenView?.size = texture.size()
                }
            }
        } else if multiplayerGame && appDelegate.mpcHandler.session.connectedPeers.count == 1 {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode.characterForm + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter + "_Faint_10")))
                    self.p1ChosenView?.size = texture.size()
                }
            } else if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
                if self.playerCharacter2 == "Cog" {
                    let texture = SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerNode2.characterForm + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                } else {
                    let texture = SKTexture(imageNamed: playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(SKTexture(imageNamed: playerCharacter2 + "_Faint_10")))
                    self.p2ChosenView?.size = texture.size()
                }
            }
        }
    }
    
    func togglePause(_ received:Bool) {
        if multiplayerGame && !received {
            MP_TRAFFIC_HANDLER.sendTogglePauseGameMessage()
        }
        
        if !gamePaused {
            gamePaused = true
            pauseButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Right")))
            leftButton?.isHidden = true
            rightButton?.isHidden = true
            skillButton_1?.isHidden = true
            skillButton_2?.isHidden = true
            runeButton?.isHidden = true
            jumpButton?.isHidden = true
            
            pauseUI?.isHidden = false
            sfxButton?.isHidden = false
            musicButton?.isHidden = false
            homeButton?.isHidden = false
            exitButton?.isHidden = false
            self.run(SKAction.wait(forDuration: 0.2),completion:{
                self.view!.isPaused = true
            })
        } else {
            self.view!.isPaused = false
            self.run(SKAction.wait(forDuration: 0.2),completion:{
                self.gamePaused = false
                self.pauseButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Pause")))
                self.leftButton?.isHidden = false
                self.rightButton?.isHidden = false
                self.skillButton_1?.isHidden = false
                self.skillButton_2?.isHidden = false
                self.runeButton?.isHidden = false
                self.jumpButton?.isHidden = false
                
                self.pauseUI?.isHidden = true
                self.sfxButton?.isHidden = true
                self.musicButton?.isHidden = true
                self.homeButton?.isHidden = true
                self.exitButton?.isHidden = true
            })
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.CAMERA_NODE?.position = (self.playerNode?.position)!
        MP_TRAFFIC_HANDLER.currentTime = currentTime
        
        if playerNode?.playerAction == "" {
            timeSinceNoAction = currentTime
        }
        
        playerNode.checkBlockUnder()
        playerNode2.checkBlockUnder()
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            playerNode3.checkBlockUnder()
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            playerNode4.checkBlockUnder()
        }
        
        if !multiplayerGame {
            if playerNode!.isDead {
                endScreen("Defeat", receiving: false)
            } else if self.playerNode2!.isDead && self.playerNode3!.isDead && self.playerNode4!.isDead {
                endScreen("Victory", receiving: false)
            }
        } else {
            if playerNode!.isDead {
                endScreen("Defeat", receiving: false)
            } else if self.playerNode2!.isDead {
                endScreen("Victory", receiving: false)
            }
        }
        
        playerNode!.performFrameBasedUpdates(currentTime)
        playerNode2!.performFrameBasedUpdates(currentTime)
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            playerNode3.performFrameBasedUpdates(currentTime)
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            playerNode4.performFrameBasedUpdates(currentTime)
        }
        
        if !multiplayerGame {
            if playerNode2.brain != nil {
                self.playerNode2.currentTime = currentTime
            }
            
            if playerNode3.brain != nil {
                self.playerNode3.currentTime = currentTime
            }
            
            if playerNode4.brain != nil {
                self.playerNode4.currentTime = currentTime
            }
        }
        
        player1Health?.size.height = 120 * (self.playerNode.currentHP/self.playerNode.maxHP)
        player2Health?.size.height = 120 * (self.playerNode2.currentHP/self.playerNode2.maxHP)
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            player3Health?.size.height = 120 * (self.playerNode3.currentHP/self.playerNode3.maxHP)
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            player4Health?.size.height = 120 * (self.playerNode4.currentHP/self.playerNode4.maxHP)
        }
        
        updateUI(currentTime)
        
        playerNode?.followNaturalRegen(currentTime)
        playerNode2?.followNaturalRegen(currentTime)
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            playerNode3?.followNaturalRegen(currentTime)
        }
        
        if !multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            playerNode4?.followNaturalRegen(currentTime)
        }
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
            
        }
        self.lastUpdateTime = currentTime
        
        if currentTime - lastSyncTime >= 0.25 && multiplayerGame {
            MP_TRAFFIC_HANDLER.sendPlayerInfo()
        }
    }
    
    func endScreen(_ stance:String,receiving:Bool) {
        print(stance)
        
        if multiplayerGame && !receiving {
            if stance == "Victory" {
                MP_TRAFFIC_HANDLER.sendEndGameMessage("Defeat")
            } else {
                MP_TRAFFIC_HANDLER.sendEndGameMessage("Victory")
            }
        }
        
        if let sceneNode = EndScene(fileNamed: "EndScene") {
            // Set the scale mode to scale to fit the window
            sceneNode.scaleMode = globalScaleMode
            
            // Present the scene
            if let view = self.view {
                sceneNode.outcome = stance
                view.presentScene(sceneNode)
                
                self.run(SKAction.wait(forDuration: 3),completion:{
                    self.playerNode2.brain.invalidate()
                    self.playerNode3.brain.invalidate()
                    self.playerNode4.brain.invalidate()
                    self.removeAllActions()
                    self.removeAllChildren()
                    self.removeFromParent()
                })
                
                view.ignoresSiblingOrder = false
                
                view.showsFPS = false
                view.showsNodeCount = true
            }
        }
    }
    
    func quitGame(_ receiving:Bool) {
        if multiplayerGame && !receiving {
            MP_TRAFFIC_HANDLER.sendQuitGameMessage()
        }
        
        if let view = self.view {
            view.presentScene(basherSelect)
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = false
            
            if self.playerNode2.brain != nil {
                self.playerNode2.brain.invalidate()
            }
            
            if !multiplayerGame {
                if self.playerNode3.brain != nil {
                    self.playerNode3.brain.invalidate()
                }
                
                if self.playerNode4.brain != nil {
                    self.playerNode4.brain.invalidate()
                }
            }
            
            self.removeAllActions()
            self.removeAllChildren()
            self.removeFromParent()
        }
    }
}
