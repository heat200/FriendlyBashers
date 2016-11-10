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
    var playerMovement = ""
    var playerLastMovement = ""
    var playerAction = ""
    var playerLastAction = ""
    var timeSinceNoAction: TimeInterval = 0
    var lastRegenTime:TimeInterval = 0
    
    var playerCharacter2 = ""
    var playerCharacter3 = ""
    var playerCharacter4 = ""
    
    var gamePaused = false
    
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
    
    var playerLabelNode:SKLabelNode?
    var playerLabelNode2:SKLabelNode?
    var playerLabelNode3:SKLabelNode?
    var playerLabelNode4:SKLabelNode?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        gameScene = self
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
        
        playerLabelNode = SKLabelNode(text: playerName + " " + String(describing: self.playerNode.currentHP) + "/" + String(describing: self.playerNode.maxHP) + "HP")
        playerLabelNode?.fontColor = SKColor.black
        playerLabelNode?.fontSize = 30
        playerLabelNode?.position.y = 80
        
        playerLabelNode2 = SKLabelNode(text: "")
        playerLabelNode2?.fontColor = SKColor.black
        playerLabelNode2?.fontSize = 30
        playerLabelNode2?.position.y = 80
        
        playerLabelNode3 = SKLabelNode(text:"")
        playerLabelNode3?.fontColor = SKColor.black
        playerLabelNode3?.fontSize = 30
        playerLabelNode3?.position.y = 80
        
        playerLabelNode4 = SKLabelNode(text:"")
        playerLabelNode4?.fontColor = SKColor.black
        playerLabelNode4?.fontSize = 30
        playerLabelNode4?.position.y = 80
        
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
        } else {
            playerCharacter3 = characterRoulette()
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
            self.tileMapNode!.addChild(playerNode3!)
            self.playerNode3.world = self
            self.playerNode3.startCPU()
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
        } else {
            playerCharacter4 = characterRoulette()
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
            self.tileMapNode!.addChild(playerNode4!)
            self.playerNode4.world = self
            self.playerNode4.startCPU()
        }
        
        jumpButton = SKSpriteNode(imageNamed: "Button_Up")
        jumpButton?.scale(to: CGSize(width: 120, height: 120))
        skillButton_1 = SKSpriteNode(imageNamed: "Button_Blue")
        skillButton_1?.scale(to: CGSize(width: 120, height: 120))
        skillButton_2 = SKSpriteNode(imageNamed: "Button_Blue")
        skillButton_2?.scale(to: CGSize(width: 120, height: 120))
        runeButton = SKSpriteNode(imageNamed: "Button_Blue")
        runeButton?.scale(to: CGSize(width: 120, height: 120))
        
        leftButton = SKSpriteNode(imageNamed: "Button_Left")
        leftButton?.scale(to: CGSize(width: 120, height: 120))
        rightButton = SKSpriteNode(imageNamed: "Button_Right")
        rightButton?.scale(to: CGSize(width: 120, height: 120))
        
        pauseButton = SKSpriteNode(imageNamed: "Button_Pause")
        pauseButton?.scale(to: CGSize(width: 120, height: 120))
        
        pauseUI = SKSpriteNode(color: UIColor.black, size: CGSize(width: self.size.width, height: self.size.height))
        pauseUI?.alpha = 0.6
        
        sfxButton = SKSpriteNode(imageNamed: "Button_Sfx_Off")
        sfxButton?.scale(to: CGSize(width: 120, height: 120))
        sfxButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 200)
        
        musicButton = SKSpriteNode(imageNamed: "Button_Music_Off")
        musicButton?.scale(to: CGSize(width: 120, height: 120))
        musicButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 330)
        
        homeButton = SKSpriteNode(imageNamed: "Button_Home")
        homeButton?.scale(to: CGSize(width: 120, height: 120))
        homeButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 455)
        
        exitButton = SKSpriteNode(imageNamed: "Button_Exit")
        exitButton?.scale(to: CGSize(width: 120, height: 120))
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
        self.skillButton_1?.addChild(skillChargeDisplay_1!)
        self.skillButton_2?.addChild(skillChargeDisplay_2!)
        self.skillButton_2?.addChild(skillChargeDisplay_3!)
        self.playerNode.addChild(playerLabelNode!)
        self.playerNode2.addChild(playerLabelNode2!)
        self.playerNode3.addChild(playerLabelNode3!)
        self.playerNode4.addChild(playerLabelNode4!)
        
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
                self.endScreen("Out of Time")
            })
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
                    playerMovement = "Move_Left"
                    self.playerNode.xScale = -1
                } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                    playerMovement = "Move_Right"
                    self.playerNode.xScale = 1
                }
                
                if playerAction == "" {
                    if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                        playerAction = "Jump"
                    } else if self.atPoint(pos) == self.skillButton_1 && !self.playerNode!.isResting {
                        playerAction = "Skill_1"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerMovement == "" && !self.playerNode!.isResting {
                        playerAction = "Skill_2"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerMovement != "" && !self.playerNode!.isResting {
                        playerAction = "Skill_3"
                    }
                }
                
                if !(self.atPoint(pos) == self.leftButton) && !(self.atPoint(pos) == self.rightButton) && !(self.atPoint(pos) == self.jumpButton) && !(self.atPoint(pos) == self.skillButton_1) && !(self.atPoint(pos) == self.skillButton_2) {
                    playerAction = ""
                    playerMovement = ""
                }
            } else {
                if self.atPoint(pos) == self.exitButton {
                    // Present the scene
                    if let view = self.view {
                        view.presentScene(basherSelect)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = true
                        view.showsNodeCount = false
                        
                        if self.playerNode2.brain != nil {
                            self.playerNode2.brain.invalidate()
                        }
                        
                        if self.playerNode3.brain != nil {
                            self.playerNode3.brain.invalidate()
                        }
                        
                        if self.playerNode4.brain != nil {
                            self.playerNode4.brain.invalidate()
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
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
                        
                        if self.playerNode2.brain != nil {
                            self.playerNode2.brain.invalidate()
                        }
                        
                        if self.playerNode3.brain != nil {
                            self.playerNode3.brain.invalidate()
                        }
                        
                        if self.playerNode4.brain != nil {
                            self.playerNode4.brain.invalidate()
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                }
            }
            
            if self.atPoint(pos) == self.pauseButton {
                if gamePaused {
                    gamePaused = false
                    togglePause()
                } else {
                    gamePaused = true
                    togglePause()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            if !gamePaused {
                if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                    playerMovement = "Move_Left"
                    self.playerNode.xScale = -1
                } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                    playerMovement = "Move_Right"
                    self.playerNode.xScale = 1
                }
                
                if playerAction == "" {
                    if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                        playerAction = "Jump"
                    } else if self.atPoint(pos) == self.skillButton_1 && !self.playerNode!.isResting {
                        playerAction = "Skill_1"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerMovement == "" && !self.playerNode!.isResting {
                        playerAction = "Skill_2"
                    } else if self.atPoint(pos) == self.skillButton_2 && playerMovement != "" && !self.playerNode!.isResting {
                        playerAction = "Skill_3"
                    }
                }
                
                if !(self.atPoint(pos) == self.leftButton) && !(self.atPoint(pos) == self.rightButton) && !(self.atPoint(pos) == self.jumpButton) && !(self.atPoint(pos) == self.skillButton_1) && !(self.atPoint(pos) == self.skillButton_2) {
                    playerAction = ""
                    playerMovement = ""
                }
            } else {
                if self.atPoint(pos) == self.exitButton {
                    // Present the scene
                    if let view = self.view {
                        view.presentScene(basherSelect)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = true
                        view.showsNodeCount = false
                        
                        if self.playerNode2.brain != nil {
                            self.playerNode2.brain.invalidate()
                        }
                        
                        if self.playerNode3.brain != nil {
                            self.playerNode3.brain.invalidate()
                        }
                        
                        if self.playerNode4.brain != nil {
                            self.playerNode4.brain.invalidate()
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
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
                        
                        if self.playerNode2.brain != nil {
                            self.playerNode2.brain.invalidate()
                        }
                        
                        if self.playerNode3.brain != nil {
                            self.playerNode3.brain.invalidate()
                        }
                        
                        if self.playerNode4.brain != nil {
                            self.playerNode4.brain.invalidate()
                        }
                        
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.removeFromParent()
                    }
                }
            }
            
            if self.atPoint(pos) == self.pauseButton {
                if gamePaused {
                    gamePaused = false
                    togglePause()
                } else {
                    gamePaused = true
                    togglePause()
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                playerMovement = ""
                self.playerNode.xScale = -1
            } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                playerMovement = ""
                self.playerNode.xScale = 1
            }
            
            if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                playerAction = ""
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if self.atPoint(pos) == self.leftButton && !self.playerNode!.isResting {
                playerMovement = ""
                self.playerNode.xScale = -1
            } else if self.atPoint(pos) == self.rightButton && !self.playerNode!.isResting {
                playerMovement = ""
                self.playerNode.xScale = 1
            }
            
            if self.atPoint(pos) == self.jumpButton && !self.playerNode!.isResting {
                playerAction = ""
            }
        }
    }
    
    func playerMovement(mod:CGFloat) {
        if playerMovement == "Move_Left" {
            self.playerNode?.physicsBody?.velocity = CGVector(dx: -self.playerNode!.movespeed * mod, dy: (self.playerNode?.physicsBody?.velocity.dy)!)
        } else if playerMovement == "Move_Right" {
            self.playerNode?.physicsBody?.velocity = CGVector(dx: self.playerNode!.movespeed * mod, dy: (self.playerNode?.physicsBody?.velocity.dy)!)
        }
    }
    
    func isSkillReady_1(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        let player = self.playerNode!
        
        if player.skillCurrentCharges_1 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_2(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        let player = self.playerNode!
        
        if player.skillCurrentCharges_2 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_3(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        let player = self.playerNode!
        
        if player.skillCurrentCharges_3 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func playerAnimations(_ currentTime: TimeInterval) {
        if !playerNode!.isResting {
            if playerAction != playerLastAction || playerMovement != playerLastMovement {
                if playerMovement == "Move_Right" || playerMovement == "Move_Left" {
                    self.playerNode!.removeAllActions()
                    self.playerNode?.run((self.playerNode?.animateRun)!)
                } else if playerMovement == "" && playerAction == "" {
                    self.playerNode!.removeAllActions()
                    self.playerNode?.run((self.playerNode?.animateIdle)!)
                } else if playerMovement == "" {
                    self.removeAllActions()
                    self.run((self.playerNode?.animateIdle!)!)
                }
                
                if playerAction == "" && playerMovement == "" {
                    self.playerNode!.removeAllActions()
                    self.playerNode?.run((self.playerNode?.animateIdle)!)
                } else if playerAction == "Jump" && self.playerNode!.currentJumps < self.playerNode!.maxJumps {
                    self.playerNode?.run((self.playerNode?.animateJump)!)
                } else if playerAction == "Skill_1" && isSkillReady_1(currentTime) {
                    self.playerNode?.run((self.playerNode?.animateSkill_1)!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_1" && self.playerAction == "Skill_1" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_1" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.playerNode!.removeAllActions()
                            self.playerNode?.run((self.playerNode?.animateIdle)!)
                        }
                    })
                } else if playerAction == "Skill_2" && isSkillReady_2(currentTime) {
                    self.playerNode?.run((self.playerNode?.animateSkill_2)!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_2" && self.playerAction == "Skill_2" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_2" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.playerNode!.removeAllActions()
                            self.playerNode?.run((self.playerNode?.animateIdle)!)
                        }
                    })
                } else if playerAction == "Skill_3" && isSkillReady_3(currentTime) {
                    self.playerNode?.run((self.playerNode?.animateSkill_3)!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_3" && self.playerAction == "Skill_3" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_3" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.playerNode!.removeAllActions()
                            self.playerNode?.run((self.playerNode?.animateIdle)!)
                        }
                    })
                }
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
        
        if isSkillReady_1(currentTime) && !self.playerNode!.isResting {
            self.skillButton_1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Blue")))
        } else {
            self.skillButton_1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
        }
        
        if self.playerMovement == "" {
            self.skillChargeDisplay_2?.isHidden = false
            self.skillChargeDisplay_3?.isHidden = true
            
            if isSkillReady_2(currentTime) && !self.playerNode!.isResting {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Blue")))
            } else {
                self.skillButton_2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Grey")))
            }
        } else {
            self.skillChargeDisplay_2?.isHidden = true
            self.skillChargeDisplay_3?.isHidden = false
            
            if isSkillReady_3(currentTime) && !self.playerNode!.isResting {
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
    }
    
    func togglePause() {
        if gamePaused {
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
        // Called before each frame is rendered
        let position = CGPoint(x: (self.playerNode?.position.x)!, y: self.playerNode!.position.y - self.playerNode!.size.height/2)
        let column = self.tileMapNode?.tileColumnIndex(fromPosition: position)
        let row = self.tileMapNode?.tileRowIndex(fromPosition: position)
        let tile = self.tileMapNode?.tileGroup(atColumn: column!, row: row!)
        
        self.CAMERA_NODE?.position = (self.playerNode?.position)!
        
        if playerAction == "" {
            timeSinceNoAction = currentTime
        }
        
        if tile?.name == "Dirt" {
            playerMovement(mod: 1.0)
            self.playerNode?.resetJumpsCount()
            if playerMovement == "" {
                self.playerNode!.physicsBody?.velocity.dx = 0
            }
            
            if self.playerNode!.isResting && self.playerNode!.allowedToRecover {
                self.playerNode!.recovered()
            }
        } else if tile?.name == "Water" {
            self.playerNode?.physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            self.playerNode?.physicsBody?.affectedByGravity = false
            playerMovement(mod: 0.4)
            self.playerNode?.resetJumpsCount()
        } else {
            self.playerNode?.physicsBody?.affectedByGravity = true
            playerMovement(mod: 0.75)
        }
        
        if self.playerNode!.isResting {
            playerMovement = ""
            playerLastMovement = ""
        }
        
        if self.playerNode!.isResting && self.playerNode!.currentHP >= self.playerNode!.maxHP {
            self.playerNode!.recovered()
        }
        
        if deathMode == 2 && (tile?.name == "Water" && self.playerNode!.isResting) {
            endScreen("Defeat")
        } else if deathMode == 1 && self.playerNode!.lives <= 0 && self.playerNode!.isResting {
            endScreen("Defeat")
        } else if self.playerNode2!.isDead && self.playerNode3!.isDead && self.playerNode4!.isDead {
            endScreen("Victory")
        }
        
        if currentTime - self.playerNode!.skill_1_Last_Used >= self.playerNode!.skillCooldown_1 {
            self.playerNode!.skill_1_Last_Used = currentTime
            if self.playerNode!.skillCurrentCharges_1 < self.playerNode!.skillMaxCharges_1 {
                self.playerNode!.skillCurrentCharges_1 += 1
            }
        }
        
        if currentTime - self.playerNode!.skill_2_Last_Used >= self.playerNode!.skillCooldown_2 {
            self.playerNode!.skill_2_Last_Used = currentTime
            if self.playerNode!.skillCurrentCharges_2 < self.playerNode!.skillMaxCharges_2 {
                self.playerNode!.skillCurrentCharges_2 += 1
            }
        }
        
        if currentTime - self.playerNode!.skill_3_Last_Used >= self.playerNode!.skillCooldown_3 {
            self.playerNode!.skill_3_Last_Used = currentTime
            if self.playerNode!.skillCurrentCharges_3 < self.playerNode!.skillMaxCharges_3 {
                self.playerNode!.skillCurrentCharges_3 += 1
            }
        }
        
        playerAnimations(currentTime)
        
        if playerAction != playerLastAction {
            if playerAction == "Jump" && self.playerNode!.currentJumps < self.playerNode!.maxJumps {
                self.playerNode?.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.playerNode!.movespeed * 0.25))
                self.playerNode?.currentJumps += 1
            } else if playerAction == "Skill_1" && self.isSkillReady_1(currentTime) {
                self.playerNode!.skill_1_Last_Used = currentTime
                self.playerNode!.skillCurrentCharges_1 -= 1
                self.playerNode!.doSkill_1()
            } else if playerAction == "Skill_2" && self.isSkillReady_2(currentTime) {
                self.playerNode!.skill_2_Last_Used = currentTime
                self.playerNode!.skillCurrentCharges_2 -= 1
                self.playerNode!.doSkill_2()
            } else if playerAction == "Skill_3" && self.isSkillReady_3(currentTime) {
                self.playerNode!.skill_3_Last_Used = currentTime
                self.playerNode!.skillCurrentCharges_3 -= 1
                self.playerNode!.doSkill_3()
            }
        }
        
        if playerNode!.xScale == -1 {
            playerLabelNode?.xScale = -1
        } else {
            playerLabelNode?.xScale = 1
        }
        
        if playerNode2!.xScale == -1 {
            playerLabelNode2?.xScale = -1
        } else {
            playerLabelNode2?.xScale = 1
        }
        
        if playerNode3!.xScale == -1 {
            playerLabelNode3?.xScale = -1
        } else {
            playerLabelNode3?.xScale = 1
        }
        
        if playerNode4!.xScale == -1 {
            playerLabelNode4?.xScale = -1
        } else {
            playerLabelNode4?.xScale = 1
        }
        
        if playerNode2.brain != nil {
            self.playerNode2.currentTime = currentTime
        }
        
        if playerNode3.brain != nil {
            self.playerNode3.currentTime = currentTime
        }
        
        if playerNode4.brain != nil {
            self.playerNode4.currentTime = currentTime
        }
        
        playerLabelNode?.text = playerName + " " + String(describing: self.playerNode.currentHP) + "/" + String(describing: self.playerNode.maxHP) + "HP"
        playerLabelNode2?.text = "P2 " + String(describing: self.playerNode2.currentHP) + "/" + String(describing: self.playerNode2.maxHP) + "HP"
        playerLabelNode3?.text = "P3 " + String(describing: self.playerNode3.currentHP) + "/" + String(describing: self.playerNode3.maxHP) + "HP"
        playerLabelNode4?.text = "P4 " + String(describing: self.playerNode4.currentHP) + "/" + String(describing: self.playerNode4.maxHP) + "HP"
        
        playerLastAction = playerAction
        playerLastMovement = playerMovement
        
        updateUI(currentTime)
        
        if currentTime - lastRegenTime >= 1 {
            if playerNode.currentHP < playerNode.maxHP {
                if playerNode.isResting {
                    playerNode.currentHP += (playerNode.maxHP/3)
                } else {
                    playerNode.currentHP += playerNode.hpRegen
                }
                
                if playerNode.currentHP > playerNode.maxHP {
                    playerNode.currentHP = playerNode.maxHP
                }
            }
            
            if playerNode2.currentHP < playerNode2.maxHP {
                if playerNode2.isResting {
                    playerNode2.currentHP += (playerNode2.maxHP/3)
                } else {
                    playerNode2.currentHP += playerNode2.hpRegen
                }
                
                if playerNode2.currentHP > playerNode2.maxHP {
                    playerNode2.currentHP = playerNode2.maxHP
                }
            }
            
            if playerNode3.currentHP < playerNode3.maxHP {
                if playerNode3.isResting {
                    playerNode3.currentHP += (playerNode3.maxHP/3)
                } else {
                    playerNode3.currentHP += playerNode3.hpRegen
                }
                
                if playerNode3.currentHP > playerNode3.maxHP {
                    playerNode3.currentHP = playerNode3.maxHP
                }
            }
            
            if playerNode4.currentHP < playerNode4.maxHP {
                if playerNode4.isResting {
                    playerNode4.currentHP += (playerNode4.maxHP/3)
                } else {
                    playerNode4.currentHP += playerNode4.hpRegen
                }
                
                if playerNode4.currentHP > playerNode4.maxHP {
                    playerNode4.currentHP = playerNode4.maxHP
                }
            }
            lastRegenTime = currentTime
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
    }
    
    func endScreen(_ stance:String) {
        print(stance)
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
}
