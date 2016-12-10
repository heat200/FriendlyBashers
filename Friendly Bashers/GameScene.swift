//
//  GameScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/17/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit
import GameplayKit

var AttackBoxCategory:UInt32 = 0x1 << 1
var CharacterCategory:UInt32 = 0x1 << 2
var ProjectileCategory:UInt32 = 0x1 << 3
var WorldCategory:UInt32 = 0x1 << 4
var SummonedCategory:UInt32 = 0x1 << 5
var ItemCategory:UInt32 = 0x1 << 6


class GameScene: SKScene, SKPhysicsContactDelegate {
    var playerCharacter = ""
    var timeSinceNoAction: TimeInterval = 0
    var lastSyncTime:TimeInterval = 0
    
    var playerCharacter2 = ""
    var playerCharacter3 = ""
    var playerCharacter4 = ""
    
    var gamePaused = false
    var multiplayerType = 0
    
    var buttonSize:CGFloat = 150
    var buttonMargin:CGFloat = 150
    
    var gameOver = false
    var lastItemSpawnTime:TimeInterval = 0
    var lastWeatherChangeTime:TimeInterval = 0
    
    fileprivate var lastUpdateTime : TimeInterval = 0
    var CAMERA_NODE : SKCameraNode?
    var playerNode : Character!
    var playerNode2 : CPU!
    var playerNode3 : CPU!
    var playerNode4 : CPU!
    var tileMapNode : SKTileMapNode?
    
    var timePassedLabel:SKLabelNode?
    var timePassed = 0
    var timePassedCounter = 0
    var timeMax = 0
    
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
    
    var runeOverlay: SKSpriteNode?
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
    
    var background:SKSpriteNode?
    
    var backgroundMusic:SKAudioNode!
    var soundMastery:SKAudioNode!
    
    var itemSpawnPoints = [CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0),CGPoint(x: 0, y: 0)]
    var playerSpawnPoint = [CGPoint(x: 0, y:0),CGPoint(x: 0, y:0),CGPoint(x: 0, y:0),CGPoint(x: 0, y:0)]
    
    var someoneDied = false
    var otherPlayersCount = 0
    
    let snowEffect = SKEmitterNode(fileNamed: "MapSnowEffect.sks")
    
    var backgroundAtlas = bgAtlas
    var characterAtlas:SKTextureAtlas!
    var characterAtlas2:SKTextureAtlas!
    var characterAtlas3:SKTextureAtlas!
    var characterAtlas4:SKTextureAtlas!
    var zombieboyAtlas:SKTextureAtlas!
    var zombiegirlAtlas:SKTextureAtlas!
    var TileAtlas = tileAtlas
    var UIAtlas = uiAtlas
    
    var heart1:SKSpriteNode?
    var heart2:SKSpriteNode?
    var heart3:SKSpriteNode?
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        gameScene = self
        if appDelegate.mpcHandler.session != nil {
            multiplayerType = 1
            otherPlayersCount = appDelegate.mpcHandler.session.connectedPeers.count
        } else if GK_TRAFFIC_HANDLER.match != nil {
            multiplayerType = 2
            otherPlayersCount = GK_TRAFFIC_HANDLER.match.players.count
        }
        playerCharacter2 = chosenBasher2
        playerCharacter3 = chosenBasher3
        playerCharacter4 = chosenBasher4
        self.physicsWorld.contactDelegate = self
        let backgroundAudio = SKAudioNode(fileNamed: "Suspence_Cheesepuff.mp3")
        self.background = self.childNode(withName: "//Background") as? SKSpriteNode
        self.CAMERA_NODE = self.childNode(withName: "//CAMERA_NODE") as? SKCameraNode
        
        let masterySound = SKAudioNode(fileNamed: "UseMastery_fins.wav")
        masterySound.autoplayLooped = false
        masterySound.isPositional = true
        self.CAMERA_NODE?.addChild(masterySound)
        masterySound.run(SKAction.stop())
        soundMastery = masterySound
        snowEffect?.position.y = 380
        
        removeOtherMaps()
        if chosenMap == "Origins" {
            playerSpawnPoint = [CGPoint(x: -9, y:51),CGPoint(x: 512, y:51),CGPoint(x: -766, y:12),CGPoint(x: -812, y:307)]
            itemSpawnPoints = [CGPoint(x: 850, y: 372),CGPoint(x: 415, y: 627),CGPoint(x: -1023, y: 563),CGPoint(x: -641, y: 819)]
            tileMapNode = self.childNode(withName: "//ORIGINS_MAP") as? SKTileMapNode
        } else if chosenMap == "Buckets" {
            playerSpawnPoint = [CGPoint(x: -95, y:51),CGPoint(x: -361, y:307),CGPoint(x: 756, y:563),CGPoint(x: 1197, y:563)]
            itemSpawnPoints = [CGPoint(x: 235, y: 243),CGPoint(x: 207, y: 500),CGPoint(x: 988, y: 883),CGPoint(x: -1149, y: 243)]
            tileMapNode = self.childNode(withName: "//BUCKETS_MAP") as? SKTileMapNode
        } else if chosenMap == "Tunnels" {
            playerSpawnPoint = [CGPoint(x: -232, y:180),CGPoint(x: -1117, y:-461),CGPoint(x: 951, y:-461),CGPoint(x: -1298, y:627)]
            itemSpawnPoints = [CGPoint(x: -1217, y: 627),CGPoint(x: 1049, y: 627),CGPoint(x: 631, y: -461),CGPoint(x: -890, y: -461)]
            tileMapNode = self.childNode(withName: "//TUNNELS_MAP") as? SKTileMapNode
        } else if chosenMap == "Caves" {
            playerSpawnPoint = [CGPoint(x: -499, y:-397),CGPoint(x: -1129, y:883),CGPoint(x: 735, y:883),CGPoint(x: -1153, y:1331)]
            itemSpawnPoints = [CGPoint(x: -645, y: -845),CGPoint(x: -835, y: 243),CGPoint(x: -881, y: 883),CGPoint(x: 491, y: 243)]
            tileMapNode = self.childNode(withName: "//CAVES_MAP") as? SKTileMapNode
        } else if chosenMap == "SkyDen" {
            playerSpawnPoint = [CGPoint(x: 724, y:563),CGPoint(x: 553, y:1011),CGPoint(x: -685, y:-205),CGPoint(x: 472, y:-589)]
            itemSpawnPoints = [CGPoint(x: 738, y: 1011),CGPoint(x: -293, y: 51),CGPoint(x: -1140, y: -525),CGPoint(x: -283.5, y: 51)]
            tileMapNode = self.childNode(withName: "//SKYDEN_MAP") as? SKTileMapNode
        }
        
        var playerTexture = characterAtlas.textureNamed(playerCharacter + "_Idle_1")
        
        if self.playerCharacter == "Cog" {
            playerTexture = characterAtlas.textureNamed("Cat_Idle_1")
        }
        
        self.playerNode = Character(texture: playerTexture)
        self.playerNode.CharAtlas = characterAtlas
        self.listener = self.playerNode
        
        if self.playerCharacter == "Cog" {
            playerNode.characterForm = "Cat"
        }
        
        self.playerNode.player = playerName
        self.playerNode.setUp(self.playerCharacter)
        self.playerNode.position = playerSpawnPoint[0]
        self.playerNode.physicsBody = SKPhysicsBody(texture: playerTexture, size: playerTexture.size())
        self.playerNode.physicsBody!.allowsRotation = false
        self.playerNode.physicsBody!.linearDamping = 1.0
        self.playerNode.physicsBody!.contactTestBitMask = ProjectileCategory
        self.playerNode.physicsBody!.categoryBitMask = CharacterCategory
        self.playerNode.physicsBody!.collisionBitMask = WorldCategory
        self.p1ChosenView = SKSpriteNode(texture: playerTexture)
        self.p1ChosenView?.size.width = playerTexture.size().width * 3/4
        self.p1ChosenView?.size.height = playerTexture.size().height * 3/4
        
        if multiplayerType > 0 {
            var playerTexture2 = characterAtlas2.textureNamed(playerCharacter2 + "_Idle_1")
            
            if self.playerCharacter2 == "Cog" {
                playerTexture2 = characterAtlas2.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode2 = CPU(texture: playerTexture2)
            self.playerNode2.CharAtlas = characterAtlas2
            
            if self.playerCharacter2 == "Cog" {
                playerNode2.characterForm = "Cat"
            }
            
            self.playerNode2.setUp(self.playerCharacter2)
            self.playerNode2.position = playerSpawnPoint[1]
            self.playerNode2.physicsBody = SKPhysicsBody(texture: playerTexture2, size: playerTexture2.size())
            self.playerNode2.physicsBody!.allowsRotation = false
            self.playerNode2.physicsBody!.linearDamping = 1.0
            self.playerNode2.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode2.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode2.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(playerNode2!)
            self.p2ChosenView = SKSpriteNode(texture: playerTexture2)
            self.p2ChosenView?.size.width = playerTexture2.size().width * 3/4
            self.p2ChosenView?.size.height = playerTexture2.size().height * 3/4
        } else {
            var playerTexture2 = characterAtlas2.textureNamed(playerCharacter2 + "_Idle_1")
            
            if self.playerCharacter2 == "Cog" {
                playerTexture2 = characterAtlas2.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode2 = CPU(texture: playerTexture2)
            self.playerNode2.CharAtlas = characterAtlas2
            
            if self.playerCharacter2 == "Cog" {
                playerNode2.characterForm = "Cat"
            }
            
            self.playerNode2.player = "CPU1"
            self.playerNode2.setUp(self.playerCharacter2)
            self.playerNode2.position = playerSpawnPoint[1]
            self.playerNode2.physicsBody = SKPhysicsBody(texture: playerTexture2, size: playerTexture2.size())
            self.playerNode2.physicsBody!.allowsRotation = false
            self.playerNode2.physicsBody!.linearDamping = 1.0
            self.playerNode2.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode2.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode2.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(playerNode2!)
            self.playerNode2.startCPU()
            self.p2ChosenView = SKSpriteNode(texture: playerTexture2)
            self.p2ChosenView?.size.width = playerTexture2.size().width * 3/4
            self.p2ChosenView?.size.height = playerTexture2.size().height * 3/4
        }
        
        if multiplayerType > 0 && otherPlayersCount == 2 {
            var playerTexture3 = characterAtlas3.textureNamed(playerCharacter3 + "_Idle_1")
            
            if self.playerCharacter3 == "Cog" {
                playerTexture3 = characterAtlas3.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode3 = CPU(texture: playerTexture3)
            self.playerNode3.CharAtlas = characterAtlas3
            
            if self.playerCharacter3 == "Cog" {
                playerNode3.characterForm = "Cat"
            }
            
            self.playerNode3.setUp(self.playerCharacter3)
            self.playerNode3.position = playerSpawnPoint[2]
            self.playerNode3.physicsBody = SKPhysicsBody(texture: playerTexture3, size: playerTexture3.size())
            self.playerNode3.physicsBody!.allowsRotation = false
            self.playerNode3.physicsBody!.linearDamping = 1.0
            self.playerNode3.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode3.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode3.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(playerNode3!)
            self.p3ChosenView = SKSpriteNode(texture: playerTexture3)
            self.p3ChosenView?.size.width = playerTexture3.size().width * 3/4
            self.p3ChosenView?.size.height = playerTexture3.size().height * 3/4
        } else if multiplayerType == 0 {
            var playerTexture3 = characterAtlas3.textureNamed(playerCharacter3 + "_Idle_1")
            
            if self.playerCharacter3 == "Cog" {
                playerTexture3 = characterAtlas3.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode3 = CPU(texture: playerTexture3)
            self.playerNode3.CharAtlas = characterAtlas3
            
            if self.playerCharacter3 == "Cog" {
                playerNode3.characterForm = "Cat"
            }
            
            self.playerNode3.player = "CPU2"
            self.playerNode3.setUp(self.playerCharacter3)
            self.playerNode3.position = playerSpawnPoint[2]
            self.playerNode3.physicsBody = SKPhysicsBody(texture: playerTexture3, size: playerTexture3.size())
            self.playerNode3.physicsBody!.allowsRotation = false
            self.playerNode3.physicsBody!.linearDamping = 1.0
            self.playerNode3.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode3.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode3.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(self.playerNode3!)
            self.playerNode3.startCPU()
            self.p3ChosenView = SKSpriteNode(texture: playerTexture3)
            self.p3ChosenView?.size.width = playerTexture3.size().width * 3/4
            self.p3ChosenView?.size.height = playerTexture3.size().height * 3/4
        }
        
        if multiplayerType > 0 && otherPlayersCount == 3 {
            var playerTexture4 = characterAtlas4.textureNamed(playerCharacter4 + "_Idle_1")
            
            if self.playerCharacter4 == "Cog" {
                playerTexture4 = characterAtlas4.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode4 = CPU(texture: playerTexture4)
            self.playerNode4.CharAtlas = characterAtlas4
            
            if self.playerCharacter4 == "Cog" {
                playerNode4.characterForm = "Cat"
            }
            
            self.playerNode4.setUp(self.playerCharacter4)
            self.playerNode4.position = playerSpawnPoint[3]
            self.playerNode4.physicsBody = SKPhysicsBody(texture: playerTexture4, size: playerTexture4.size())
            self.playerNode4.physicsBody!.allowsRotation = false
            self.playerNode4.physicsBody!.linearDamping = 1.0
            self.playerNode4.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode4.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode4.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(playerNode4!)
            self.p4ChosenView = SKSpriteNode(texture: playerTexture4)
            self.p4ChosenView?.size.width = playerTexture4.size().width * 3/4
            self.p4ChosenView?.size.height = playerTexture4.size().height * 3/4
        } else if multiplayerType == 0 {
            var playerTexture4 = characterAtlas4.textureNamed(playerCharacter4 + "_Idle_1")
            
            if self.playerCharacter4 == "Cog" {
                playerTexture4 = characterAtlas4.textureNamed("Cat_Idle_1")
            }
            
            self.playerNode4 = CPU(texture: playerTexture4)
            self.playerNode4.CharAtlas = characterAtlas4
            
            if self.playerCharacter4 == "Cog" {
                playerNode4.characterForm = "Cat"
            }
            
            self.playerNode4.player = "CPU3"
            self.playerNode4.setUp(self.playerCharacter4)
            self.playerNode4.position = playerSpawnPoint[3]
            self.playerNode4.physicsBody = SKPhysicsBody(texture: playerTexture4, size: playerTexture4.size())
            self.playerNode4.physicsBody!.allowsRotation = false
            self.playerNode4.physicsBody!.linearDamping = 1.0
            self.playerNode4.physicsBody!.contactTestBitMask = ProjectileCategory
            self.playerNode4.physicsBody!.categoryBitMask = CharacterCategory
            self.playerNode4.physicsBody!.collisionBitMask = WorldCategory
            self.tileMapNode!.addChild(self.playerNode4!)
            self.playerNode4.startCPU()
            self.p4ChosenView = SKSpriteNode(texture: playerTexture4)
            self.p4ChosenView?.size.width = playerTexture4.size().width * 3/4
            self.p4ChosenView?.size.height = playerTexture4.size().height * 3/4
        }
        
        jumpButton = SKSpriteNode(imageNamed: "Button_Up")
        jumpButton?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        skillButton_1 = SKSpriteNode(imageNamed: "Button_Teal")
        skillButton_1?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        skillButton_2 = SKSpriteNode(imageNamed: "Button_Beige")
        skillButton_2?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        runeButton = SKSpriteNode(imageNamed: "Button_Lime")
        runeOverlay = SKSpriteNode(imageNamed: "")
        runeOverlay?.scale(to: CGSize(width: 50, height: 50))
        runeButton?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        
        leftButton = SKSpriteNode(imageNamed: "Button_Left")
        leftButton?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        rightButton = SKSpriteNode(imageNamed: "Button_Right")
        rightButton?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        
        pauseButton = SKSpriteNode(imageNamed: "Button_Pause")
        pauseButton?.scale(to: CGSize(width: buttonSize, height: buttonSize))
        
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
        
        timePassedLabel = SKLabelNode(text: "--/--")
        timePassedLabel?.fontColor = SKColor.black
        timePassedLabel?.fontSize = 60
        timePassedLabel?.position = CGPoint(x: 0, y: -self.size.height/2 + 70)
        
        heart2 = SKSpriteNode(texture: UIAtlas.textureNamed("Heart"))
        heart2?.position = timePassedLabel!.position
        heart2?.position.y -= 50
        
        heart1 = SKSpriteNode(texture: UIAtlas.textureNamed("Heart"))
        heart1?.position = heart2!.position
        heart1?.position.x -= 50
        
        heart3 = SKSpriteNode(texture: UIAtlas.textureNamed("Heart"))
        heart3?.position = heart2!.position
        heart3?.position.x += 50
        
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
        skillButton_1?.position = CGPoint(x: self.size.width/2 - 75 - buttonMargin,y: -self.size.height/2 + 75) //Bottom Left
        skillChargeDisplay_1?.position = CGPoint(x: 0,y: 0)
        runeButton?.position = CGPoint(x: self.size.width/2 - 75 - buttonMargin,y: -self.size.height/2 + 75 + buttonMargin) //Top Left
        skillButton_2?.position = CGPoint(x: self.size.width/2 - 75,y: -self.size.height/2 + 75 + buttonMargin) // Top Right
        skillChargeDisplay_2?.position = CGPoint(x: 0,y: 0)
        skillChargeDisplay_3?.position = CGPoint(x: 0,y: 0)
        
        pauseButton?.position = CGPoint(x: self.size.width/2 - 75,y: self.size.height/2 - 75)
        
        //Left Side of Screen
        leftButton?.position = CGPoint(x: -self.size.width/2 + 75,y: -self.size.height/2 + 75)
        rightButton?.position = CGPoint(x: -self.size.width/2 + 75 + buttonMargin,y: -self.size.height/2 + 75)
        
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
        tilePhysicsBodyArray.removeAll()
        
        self.CAMERA_NODE?.addChild(backgroundAudio)
        
        self.CAMERA_NODE?.zPosition = playerNode!.zPosition + 10
        self.CAMERA_NODE?.addChild(snowEffect!)
        snowEffect?.zPosition = -5
        self.CAMERA_NODE?.addChild(pauseUI!)
        self.tileMapNode!.addChild(playerNode)
        self.CAMERA_NODE?.addChild(sfxButton!)
        self.CAMERA_NODE?.addChild(timePassedLabel!)
        
        if deathMode == 1 {
            self.CAMERA_NODE?.addChild(heart1!)
            self.CAMERA_NODE?.addChild(heart2!)
            self.CAMERA_NODE?.addChild(heart3!)
        }
        
        self.CAMERA_NODE?.addChild(musicButton!)
        self.CAMERA_NODE?.addChild(homeButton!)
        self.CAMERA_NODE?.addChild(exitButton!)
        
        self.CAMERA_NODE?.addChild(pauseButton!)
        self.CAMERA_NODE?.addChild(jumpButton!)
        self.CAMERA_NODE?.addChild(skillButton_1!)
        self.CAMERA_NODE?.addChild(skillButton_2!)
        self.CAMERA_NODE?.addChild(runeButton!)
        self.runeButton?.addChild(runeOverlay!)
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
        
        if multiplayerType > 0 {
            player2Name?.text = otherPlayers[0]
        }
        
        if multiplayerType == 0 || otherPlayersCount == 2 {
            if multiplayerType > 0 {
                player3Name?.text = otherPlayers[1]
            }
            
            self.CAMERA_NODE?.addChild(player3Health!)
            self.CAMERA_NODE?.addChild(player3Bubble!)
            self.CAMERA_NODE?.addChild(player3Name!)
            self.player3Bubble?.addChild(p3ChosenView!)
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            if multiplayerType > 0 {
                player4Name?.text = otherPlayers[1]
            }
            
            self.CAMERA_NODE?.addChild(player4Health!)
            self.CAMERA_NODE?.addChild(player4Bubble!)
            self.CAMERA_NODE?.addChild(player4Name!)
            self.player4Bubble?.addChild(p4ChosenView!)
        }
        
        self.pauseButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Pause")))
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
            timeMax = timeLimit * 60
            timePassedLabel?.text = "0/" + String(describing: timeLimit)
        }
        
        if primaryPlayer {
            self.spawnItem()
        }
        self.backgroundMusic = backgroundAudio
        
        self.setMasteryButtonOverlay()
        if musicEnabled {
            backgroundAudio.run(SKAction.play())
        } else {
            backgroundAudio.run(SKAction.pause())
        }
    }
    
    func itemRoulette() -> String {
        let randomNum:Int = Int(arc4random_uniform(6) + 1)
        var chosenOne = ""
        
        switch randomNum {
        case 1:
            chosenOne = "Golems_Curse"
        case 2:
            chosenOne = "Icy_Grasp"
        case 3:
            chosenOne = "Fires_Passion"
        case 4:
            chosenOne = "Air_Blast"
        case 5:
            chosenOne = "Sugar_Rush"
        case 6:
            chosenOne = "Fairys_Heart"
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
                    projectile.damage = 0
                }
            }
        } else if contact.bodyB.node is Projectile {
            let projectile = contact.bodyB.node as! Projectile
            if contact.bodyA.node is Character {
                let character = contact.bodyA.node as! Character
                if character.player != projectile.owner {
                    character.takeDamage(projectile.damage, direction: projectile.direction!)
                    projectile.damage = 0
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
            if contact.bodyA.node is Projectile && contact.bodyB.node is Projectile {
                let projectile1 = contact.bodyA.node as! Projectile
                projectile1.removeAllActions()
                projectile1.removeFromParent()
                
                let projectile2 = contact.bodyB.node as! Projectile
                projectile2.removeAllActions()
                projectile2.removeFromParent()
            } else if contact.bodyA.node is Projectile {
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
                    } else if (self.atPoint(pos) == self.runeButton || self.atPoint(pos) == self.runeOverlay) && !self.playerNode!.isResting {
                        if blessingList[chosenBlessing][0] == 10 {
                            self.playerNode?.useBlessingPower("Limbo")
                            if sfxEnabled {
                                self.soundMastery?.run(SKAction.stop())
                                self.soundMastery?.run(SKAction.play())
                            }
                        } else if blessingList[chosenBlessing][1] == 10 {
                            self.playerNode?.useBlessingPower("Enrage")
                            if sfxEnabled {
                                self.soundMastery?.run(SKAction.stop())
                                self.soundMastery?.run(SKAction.play())
                            }
                        } else if blessingList[chosenBlessing][2] == 10 {
                            if sfxEnabled {
                                self.soundMastery?.run(SKAction.stop())
                                self.soundMastery?.run(SKAction.play())
                            }
                            self.playerNode?.useBlessingPower("Survival")
                        } else if blessingList[chosenBlessing][3] == 10 {
                            if sfxEnabled {
                                self.soundMastery?.run(SKAction.stop())
                                self.soundMastery?.run(SKAction.play())
                            }
                            self.playerNode?.useBlessingPower("Lucky_Soul")
                        } else if blessingList[chosenBlessing][4] == 10 {
                            if sfxEnabled && playerNode?.itemHeld != "" {
                                self.soundMastery?.run(SKAction.stop())
                                self.soundMastery?.run(SKAction.play())
                            }
                            self.playerNode?.useBlessingPower("Hoarder")
                            self.setMasteryButtonOverlay()
                        }
                    }
                }
                
                if !(self.atPoint(pos) == self.leftButton) && !(self.atPoint(pos) == self.rightButton) && !(self.atPoint(pos) == self.jumpButton) && !(self.atPoint(pos) == self.skillButton_1) && !(self.atPoint(pos) == self.skillButton_2) && !(self.atPoint(pos) == self.runeButton) && !(self.atPoint(pos) == self.runeOverlay) {
                    playerNode?.playerAction = ""
                    playerNode?.playerMovement = ""
                    
                    if playerNode!.usedLimbo && (abs(pos.x) < 1595 && pos.y < 2014 && pos.y > -1280) && playerNode!.returnBlock(pos) != "Dirt" {
                        playerNode?.usedLimbo = false
                        self.playerNode!.position = pos
                        self.playerNode!.physicsBody?.velocity.dy = 0
                        self.playerNode!.physicsBody?.velocity.dx = 0
                    }
                }
                
                if multiplayerType == 1 {
                    MP_TRAFFIC_HANDLER.sendPlayerInfo()
                    MP_TRAFFIC_HANDLER.confirmPlayerStats()
                } else if multiplayerType == 2 {
                    GK_TRAFFIC_HANDLER.sendPlayerInfo()
                    GK_TRAFFIC_HANDLER.confirmPlayerStats()
                }
            } else {
                if self.atPoint(pos) == self.exitButton {
                    quitGame(false)
                } else if self.atPoint(pos) == self.sfxButton {
                    if sfxEnabled {
                        sfxEnabled = false
                        self.backgroundMusic?.run(SKAction.pause())
                    } else {
                        sfxEnabled = true
                        self.backgroundMusic?.run(SKAction.play())
                    }
                } else if self.atPoint(pos) == self.musicButton {
                    if musicEnabled {
                        musicEnabled = false
                    } else {
                        musicEnabled = true
                    }
                } else if self.atPoint(pos) == self.homeButton {
                    self.gameOver = true
                    
                    if musicEnabled {
                        SKTAudio.sharedInstance().playBackgroundMusic(filename: "Calamity_airwolf89.mp3")
                    }
                    
                    if let view = self.view {
                        view.presentScene(mainMenu)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = false
                        view.showsNodeCount = false
                        self.backgroundMusic.run(SKAction.stop())
                        
                        self.run(SKAction.wait(forDuration: 1),completion:{
                            if self.playerNode2.brain != nil {
                                self.playerNode2.brain.invalidate()
                            }
                            
                            if self.multiplayerType == 0 {
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
                        })
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
            
            if multiplayerType == 1 {
                MP_TRAFFIC_HANDLER.sendPlayerInfo()
            } else if multiplayerType == 2 {
                GK_TRAFFIC_HANDLER.sendPlayerInfo()
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
            
            if multiplayerType == 1 {
                MP_TRAFFIC_HANDLER.sendPlayerInfo()
            } else if multiplayerType == 2 {
                GK_TRAFFIC_HANDLER.sendPlayerInfo()
            }
        }
    }
    
    func updateUI(_ currentTime: TimeInterval) {
        if timeLimit != 0 {
            if timePassed > timeMax {
                self.endScreen("Out of time!", receiving: false)
            }
            timePassedLabel?.text = String(describing: timePassed) + "/" + String(describing: timeMax)
        }
        
        if self.playerNode!.currentJumps >= self.playerNode!.maxJumps || self.playerNode!.isResting {
            self.jumpButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Up_Grey")))
        } else {
            self.jumpButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Up")))
        }
        
        self.skillChargeDisplay_1?.text = String(self.playerNode!.skillCurrentCharges_1)
        self.skillChargeDisplay_2?.text = String(self.playerNode!.skillCurrentCharges_2)
        self.skillChargeDisplay_3?.text = String(self.playerNode!.skillCurrentCharges_3)
        
        if blessingList[chosenBlessing][0] == 10 {
            if currentTime - self.playerNode!.lastBlessingTime >= 20 {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Lime")))
            } else {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else if blessingList[chosenBlessing][1] == 10 {
            if currentTime - self.playerNode!.lastBlessingTime >= 40 {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Lime")))
            } else {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else if blessingList[chosenBlessing][2] == 10 {
            if currentTime - self.playerNode!.lastBlessingTime >= 45 {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Lime")))
            } else {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else if blessingList[chosenBlessing][3] == 10 {
            if currentTime - self.playerNode!.lastBlessingTime >= 45 {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Lime")))
            } else {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else if blessingList[chosenBlessing][4] == 10 {
            if currentTime - self.playerNode!.lastBlessingTime >= 5 {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Lime")))
            } else {
                self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else {
            self.runeButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
        }
        
        if playerNode!.isSkillReady_1(currentTime) && !self.playerNode!.isResting {
            self.skillButton_1?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Teal")))
        } else {
            self.skillButton_1?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
        }
        
        if playerNode?.playerMovement == "" {
            self.skillChargeDisplay_2?.isHidden = false
            self.skillChargeDisplay_3?.isHidden = true
            
            if playerNode!.isSkillReady_2(currentTime) && !self.playerNode!.isResting {
                self.skillButton_2?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Beige")))
            } else {
                self.skillButton_2?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        } else {
            self.skillChargeDisplay_2?.isHidden = true
            self.skillChargeDisplay_3?.isHidden = false
            
            if playerNode!.isSkillReady_3(currentTime) && !self.playerNode!.isResting {
                self.skillButton_2?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Beige")))
            } else {
                self.skillButton_2?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
            }
        }
        
        if self.playerNode!.isStunned || self.playerNode!.isResting {
            self.leftButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Left_Grey")))
            self.rightButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Right_Grey")))
        } else {
            self.leftButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Left")))
            self.rightButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Right")))
        }
        
        if musicEnabled {
            musicButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Music_On")))
        } else {
            musicButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Music_Off")))
        }
        
        if sfxEnabled {
            sfxButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Sfx_On")))
        } else {
            sfxButton?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Sfx_Off")))
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed( "Button_Grey")))
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width * 3/4
                    self.p1ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas.textureNamed( playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width * 3/4
                    self.p1ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width * 3/4
                    self.p2ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas2.textureNamed(playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width * 3/4
                    self.p2ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if self.playerNode3.isDead {
                self.player3Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode3.characterName == "Cog" {
                    let texture = characterAtlas3.textureNamed( playerNode3.characterForm + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width * 3/4
                    self.p3ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas3.textureNamed(playerCharacter3 + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width * 3/4
                    self.p3ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if self.playerNode4.isDead {
                self.player4Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode4.characterName == "Cog" {
                    let texture = characterAtlas4.textureNamed(playerNode4.characterForm + "_Faint_10")
                    self.p4ChosenView?.run(SKAction.setTexture(texture))
                    self.p4ChosenView?.size.width = texture.size().width * 3/4
                    self.p4ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas4.textureNamed(playerCharacter4 + "_Faint_10")
                    self.p4ChosenView?.run(SKAction.setTexture(texture))
                    self.p4ChosenView?.size.width = texture.size().width * 3/4
                    self.p4ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if !self.playerNode.isDead {
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Idle_1")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width * 3/4
                    self.p1ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if !self.playerNode2.isDead {
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Idle_1")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width * 3/4
                    self.p2ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if !self.playerNode3.isDead {
                if self.playerNode3.characterName == "Cog" {
                    let texture = characterAtlas3.textureNamed(playerNode3.characterForm + "_Idle_1")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width * 3/4
                    self.p3ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if !self.playerNode4.isDead {
                if self.playerNode4.characterName == "Cog" {
                    let texture = characterAtlas4.textureNamed(playerNode4.characterForm + "_Idle_1")
                    self.p4ChosenView?.run(SKAction.setTexture(texture))
                    self.p4ChosenView?.size.width = texture.size().width * 3/4
                    self.p4ChosenView?.size.height = texture.size().height * 3/4
                }
            }
        } else if multiplayerType == 0 || otherPlayersCount == 2 {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width * 3/4
                    self.p1ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas.textureNamed(playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width * 3/4
                    self.p1ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width * 3/4
                    self.p2ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas2.textureNamed(playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width * 3/4
                    self.p2ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if self.playerNode3.isDead {
                self.player3Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode3.characterName == "Cog" {
                    let texture = characterAtlas3.textureNamed(playerNode3.characterForm + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width * 3/4
                    self.p3ChosenView?.size.height = texture.size().height * 3/4
                } else {
                    let texture = characterAtlas3.textureNamed(playerCharacter3 + "_Faint_10")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width * 3/4
                    self.p3ChosenView?.size.height = texture.size().height * 3/4
                }
            }
            
            if !self.playerNode.isDead {
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Idle_1")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width/2
                    self.p1ChosenView?.size.height = texture.size().height/2
                }
            }
            
            if !self.playerNode2.isDead {
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Idle_1")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width/2
                    self.p2ChosenView?.size.height = texture.size().height/2
                }
            }
            
            if !self.playerNode3.isDead {
                if self.playerNode3.characterName == "Cog" {
                    let texture = characterAtlas3.textureNamed(playerNode3.characterForm + "_Idle_1")
                    self.p3ChosenView?.run(SKAction.setTexture(texture))
                    self.p3ChosenView?.size.width = texture.size().width/2
                    self.p3ChosenView?.size.height = texture.size().height/2
                }
            }
        } else {
            if self.playerNode.isDead {
                self.player1Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width/2
                    self.p1ChosenView?.size.height = texture.size().height/2
                } else {
                    let texture = characterAtlas.textureNamed(playerCharacter + "_Faint_10")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width/2
                    self.p1ChosenView?.size.height = texture.size().height/2
                }
            }
            
            if self.playerNode2.isDead {
                self.player2Bubble?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Grey")))
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width/2
                    self.p2ChosenView?.size.height = texture.size().height/2
                } else {
                    let texture = characterAtlas2.textureNamed(playerCharacter2 + "_Faint_10")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width/2
                    self.p2ChosenView?.size.height = texture.size().height/2
                }
            }
            
            if !self.playerNode.isDead {
                if self.playerNode.characterName == "Cog" {
                    let texture = characterAtlas.textureNamed(playerNode.characterForm + "_Idle_1")
                    self.p1ChosenView?.run(SKAction.setTexture(texture))
                    self.p1ChosenView?.size.width = texture.size().width/2
                    self.p1ChosenView?.size.height = texture.size().height/2
                }
            }
            
            if !self.playerNode2.isDead {
                if self.playerNode2.characterName == "Cog" {
                    let texture = characterAtlas2.textureNamed(playerNode2.characterForm + "_Idle_1")
                    self.p2ChosenView?.run(SKAction.setTexture(texture))
                    self.p2ChosenView?.size.width = texture.size().width/2
                    self.p2ChosenView?.size.height = texture.size().height/2
                }
            }
        }
    }
    
    func togglePause(_ received:Bool) {
        if multiplayerType == 1 && !received {
            MP_TRAFFIC_HANDLER.sendTogglePauseGameMessage()
        } else if multiplayerType == 2 && !received {
            GK_TRAFFIC_HANDLER.sendTogglePauseGameMessage()
        }
        
        if !gamePaused {
            gamePaused = true
            pauseButton?.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Right")))
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
                self.pauseButton?.run(SKAction.setTexture(self.UIAtlas.textureNamed("Button_Pause")))
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
        if deathMode == 1 {
            if playerNode!.lives == 2 {
                heart3?.isHidden = false
                heart2?.isHidden = false
                heart1?.isHidden = false
            } else if playerNode!.lives == 1 {
                heart3?.isHidden = true
                heart2?.isHidden = false
                heart1?.isHidden = false
            } else if playerNode!.lives == 0 {
                heart3?.isHidden = true
                heart2?.isHidden = true
                heart1?.isHidden = false
            } else {
                heart3?.isHidden = true
                heart2?.isHidden = true
                heart1?.isHidden = true
            }
        }
        
        if someoneDied {
            if playerNode2?.brain != nil {
                playerNode2?.updateCPU()
            }
            
            if playerNode3?.brain != nil {
                playerNode3?.updateCPU()
            }
            
            if playerNode4?.brain != nil {
                playerNode4?.updateCPU()
            }
            someoneDied = false
        }
        
        self.CAMERA_NODE?.position = (self.playerNode?.position)!
        if multiplayerType == 1 {
            MP_TRAFFIC_HANDLER.currentTime = currentTime
        } else if multiplayerType == 2 {
            GK_TRAFFIC_HANDLER.currentTime = currentTime
        }
        
        if playerNode?.playerAction == "" {
            timeSinceNoAction = currentTime
        }
        
        playerNode.checkBlockUnder()
        playerNode2.checkBlockUnder()
        
        if multiplayerType == 0 || otherPlayersCount == 2 {
            playerNode3.checkBlockUnder()
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            playerNode4.checkBlockUnder()
        }
        
        if multiplayerType == 0 {
            if playerNode!.isDead {
                endScreen("Defeat", receiving: false)
            } else if self.playerNode2!.isDead && self.playerNode3!.isDead && self.playerNode4!.isDead {
                endScreen("Victory", receiving: false)
            }
        } else {
            if otherPlayersCount == 1 {
                if playerNode!.isDead {
                    endScreen("Defeat", receiving: false)
                } else if self.playerNode2!.isDead {
                    endScreen("Victory", receiving: false)
                }
            } else if otherPlayersCount == 2 {
                if self.playerNode2!.isDead && self.playerNode3!.isDead {
                    endScreen("Victory", receiving: false)
                }
            } else if otherPlayersCount == 3 {
                if self.playerNode2!.isDead && self.playerNode3!.isDead && self.playerNode4!.isDead {
                    endScreen("Victory", receiving: false)
                }
            }
        }
        
        playerNode!.performFrameBasedUpdates(currentTime)
        playerNode2!.performFrameBasedUpdates(currentTime)
        
        if multiplayerType == 0 || otherPlayersCount == 2 {
            playerNode3.performFrameBasedUpdates(currentTime)
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            playerNode4.performFrameBasedUpdates(currentTime)
        }
        
        if multiplayerType == 0 {
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
        
        if multiplayerType == 0 || otherPlayersCount == 2 {
            player3Health?.size.height = 120 * (self.playerNode3.currentHP/self.playerNode3.maxHP)
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            player4Health?.size.height = 120 * (self.playerNode4.currentHP/self.playerNode4.maxHP)
        }
        
        playerNode?.followNaturalRegen(currentTime)
        playerNode2?.followNaturalRegen(currentTime)
        
        if multiplayerType == 0 || otherPlayersCount == 2 {
            playerNode3?.followNaturalRegen(currentTime)
        }
        
        if multiplayerType == 0 || otherPlayersCount == 3 {
            playerNode4?.followNaturalRegen(currentTime)
        }
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        self.lastUpdateTime = currentTime
        
        if currentTime - lastSyncTime >= 0.25 {
            lastSyncTime = currentTime
            updateUI(currentTime)
            if multiplayerType == 1 {
                MP_TRAFFIC_HANDLER.sendPlayerInfo()
            } else if multiplayerType == 2 {
                GK_TRAFFIC_HANDLER.sendPlayerInfo()
            }
            timePassedCounter += 1
            if timePassedCounter > 4 {
                timePassedCounter = 0
                timePassed += 1
            }
        }
        
        if currentTime - lastItemSpawnTime >= 10 && primaryPlayer {
            spawnItem()
            lastItemSpawnTime = currentTime
        }
        
        if currentTime - lastWeatherChangeTime >= 45 && primaryPlayer {
            changeTheme()
            lastWeatherChangeTime = currentTime
        }
    }
    
    func endScreen(_ stance:String,receiving:Bool) {
        self.gameOver = true
        
        if multiplayerType == 1 && !receiving {
            if stance == "Victory" {
                MP_TRAFFIC_HANDLER.sendEndGameMessage("Defeat")
            } else {
                MP_TRAFFIC_HANDLER.sendEndGameMessage("Victory")
            }
        } else if multiplayerType == 2 && !receiving {
            if stance == "Victory" {
                GK_TRAFFIC_HANDLER.sendEndGameMessage("Defeat")
            } else {
                GK_TRAFFIC_HANDLER.sendEndGameMessage("Victory")
            }
        }
        
        if multiplayerType == 0 {
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
        
        self.backgroundMusic.run(SKAction.stop())
        self.listener = nil
        self.itemSpawnPoints.removeAll()
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        
        if let sceneNode = EndScene(fileNamed: "EndScene") {
            // Set the scale mode to scale to fit the window
            sceneNode.scaleMode = globalScaleMode
            // Present the scene
            if let view = self.view {
                view.ignoresSiblingOrder = false
                view.showsFPS = false
                view.showsNodeCount = false
                sceneNode.outcome = stance
                view.presentScene(sceneNode)
            }
        }
    }
    
    func quitGame(_ receiving:Bool) {
        self.gameOver = true
        
        if multiplayerType == 1 && !receiving {
            MP_TRAFFIC_HANDLER.sendQuitGameMessage()
        } else if multiplayerType == 2 && !receiving {
            GK_TRAFFIC_HANDLER.sendQuitGameMessage()
        }
        
        if musicEnabled {
            SKTAudio.sharedInstance().playBackgroundMusic(filename: "Calamity_airwolf89.mp3")
        }
        
        if multiplayerType == 0 {
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
        
        self.backgroundMusic.run(SKAction.stop())
        self.listener = nil
        self.itemSpawnPoints.removeAll()
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        
        if let view = self.view {
            view.presentScene(basherSelect)
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    func spawnItem() {
        if itemSpawnPoints.count > 0 {
            if !(self.atPoint(itemSpawnPoints[0]) is Item) {
                let itemName = self.itemRoulette()
                let item = Item(imageNamed: itemName)
                item.setUp(itemName)
                item.position = itemSpawnPoints[0]
                self.addChild(item)
                
                if multiplayerType == 1 {
                    MP_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 0)
                } else if multiplayerType == 2 {
                    GK_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 0)
                }
            }
            
            if !(self.atPoint(itemSpawnPoints[1]) is Item) {
                let itemName = self.itemRoulette()
                let item = Item(imageNamed: itemName)
                item.setUp(itemName)
                item.position = itemSpawnPoints[1]
                self.addChild(item)
                
                if multiplayerType == 1 {
                    MP_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 1)
                } else if multiplayerType == 2 {
                    GK_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 1)
                }
            }
            
            if !(self.atPoint(itemSpawnPoints[2]) is Item) {
                let itemName = self.itemRoulette()
                let item = Item(imageNamed: itemName)
                item.setUp(itemName)
                item.position = itemSpawnPoints[2]
                self.addChild(item)
                
                if multiplayerType == 1 {
                    MP_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 2)
                } else if multiplayerType == 2 {
                    GK_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 2)
                }
            }
            
            if !(self.atPoint(itemSpawnPoints[3]) is Item) {
                let itemName = self.itemRoulette()
                let item = Item(imageNamed: itemName)
                item.setUp(itemName)
                item.position = itemSpawnPoints[3]
                self.addChild(item)
                
                if multiplayerType == 1 {
                    MP_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 3)
                } else if multiplayerType == 2 {
                    GK_TRAFFIC_HANDLER.spawnBlock(itemName, coord: 3)
                }
            }
        }
    }
    
    func spawnItemAt(_ coord:Int, blockName:String) {
        let item = Item(imageNamed: blockName)
        item.setUp(blockName)
        item.position = itemSpawnPoints[coord]
        self.addChild(item)
    }
    
    func setMasteryButtonOverlay() {
        if blessingList[chosenBlessing][0] == 10 {
            runeOverlay?.run(SKAction.setTexture(UIAtlas.textureNamed("Limbo")))
        } else if blessingList[chosenBlessing][1] == 10 {
            runeOverlay?.run(SKAction.setTexture(UIAtlas.textureNamed("Enrage")))
        } else if blessingList[chosenBlessing][2] == 10 {
            runeOverlay?.run(SKAction.setTexture(UIAtlas.textureNamed("Survival")))
        } else if blessingList[chosenBlessing][3] == 10 {
            runeOverlay?.run(SKAction.setTexture(UIAtlas.textureNamed("Lucky_Soul")))
        } else if blessingList[chosenBlessing][4] == 10 {
            if playerNode!.itemHeld == "" {
                runeOverlay?.texture = nil
            } else {
                if playerNode!.itemHeld == "Golems_Curse" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Golems_Curse")))
                } else if playerNode!.itemHeld == "Icy_Grasp" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Icy_Grasp")))
                } else if playerNode!.itemHeld == "Fires_Passion" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Fires_Passion")))
                } else if playerNode!.itemHeld == "Air_Blast" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Air_Blast")))
                } else if playerNode!.itemHeld == "Sugar_Rush" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Sugar_Rush")))
                } else if playerNode!.itemHeld == "Fairys_Heart" {
                    runeOverlay?.run(SKAction.setTexture(TileAtlas.textureNamed("Fairys_Heart")))
                }
            }
        } else {
            runeOverlay?.texture = nil
        }
    }
    
    func removeOtherMaps() {
        applyTheme()
        
        if chosenMap == "Origins" {
            (self.childNode(withName: "//BUCKETS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//TUNNELS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//CAVES_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//SKYDEN_MAP") as? SKTileMapNode)?.removeFromParent()
        } else if chosenMap == "Buckets" {
            (self.childNode(withName: "//ORIGINS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//TUNNELS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//CAVES_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//SKYDEN_MAP") as? SKTileMapNode)?.removeFromParent()
        } else if chosenMap == "Tunnels" {
            (self.childNode(withName: "//BUCKETS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//ORIGINS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//CAVES_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//SKYDEN_MAP") as? SKTileMapNode)?.removeFromParent()
        } else if chosenMap == "Caves" {
            (self.childNode(withName: "//BUCKETS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//TUNNELS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//ORIGINS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//SKYDEN_MAP") as? SKTileMapNode)?.removeFromParent()
        } else if chosenMap == "SkyDen" {
            (self.childNode(withName: "//BUCKETS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//TUNNELS_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//CAVES_MAP") as? SKTileMapNode)?.removeFromParent()
            (self.childNode(withName: "//ORIGINS_MAP") as? SKTileMapNode)?.removeFromParent()
        }
    }
    
    func applyTheme() {
        if currentTheme == "SPRING" {
            snowEffect?.numParticlesToEmit = 1
            background?.run(SKAction.setTexture(backgroundAtlas.textureNamed("BG_SPRING")))
            tileMapNode?.tileSet = SKTileSet(named: "SpringTiles")!
        } else if currentTheme == "SUMMER" {
            snowEffect?.numParticlesToEmit = 1
            background?.run(SKAction.setTexture(backgroundAtlas.textureNamed("BG_SUMMER")))
            tileMapNode?.tileSet = SKTileSet(named: "SummerTiles")!
        } else if currentTheme == "FALL" {
            snowEffect?.numParticlesToEmit = 1
            background?.run(SKAction.setTexture(backgroundAtlas.textureNamed("BG_FALL")))
            tileMapNode?.tileSet = SKTileSet(named: "FallTiles")!
        } else if currentTheme == "WINTER" {
            if snowEffect!.numParticlesToEmit > 0 {
                snowEffect?.numParticlesToEmit = 0
                snowEffect?.resetSimulation()
            }
            background?.run(SKAction.setTexture(backgroundAtlas.textureNamed("BG_WINTER")))
            tileMapNode?.tileSet = SKTileSet(named: "WinterTiles")!
        }
        
        if playerNode != nil {
            applyStatMods()
        }
    }
    
    func applyStatMods() {
        if !playerNode!.isDead {
            playerNode!.applyStatMods()
        }
        
        if playerNode2 != nil {
            if !playerNode2!.isDead {
                playerNode2!.applyStatMods()
            }
        }
        
        if playerNode3 != nil {
            if !playerNode3!.isDead {
                playerNode3!.applyStatMods()
            }
        }
        
        if playerNode4 != nil {
            if !playerNode4!.isDead {
                playerNode4!.applyStatMods()
            }
        }
    }
    
    func changeTheme() {
        let rand = Int(arc4random_uniform(4) + 1)
        
        if rand == 1 {
            currentTheme = "SPRING"
        } else if rand == 2 {
            currentTheme = "SUMMER"
        } else if rand == 3 {
            currentTheme = "FALL"
        } else if rand == 4 {
            currentTheme = "WINTER"
        }
        
        applyTheme()
        
        if multiplayerType == 1 {
            MP_TRAFFIC_HANDLER.syncTheme()
        } else if multiplayerType == 2 {
            GK_TRAFFIC_HANDLER.syncTheme()
        }
    }
    
    func setUpAtlases() {
        characterAtlas = SKTextureAtlas(named: chosenBasher + "Atlas")
        characterAtlas2 = SKTextureAtlas(named: chosenBasher2 + "Atlas")
        characterAtlas3 = SKTextureAtlas(named: chosenBasher3 + "Atlas")
        characterAtlas4 = SKTextureAtlas(named: chosenBasher4 + "Atlas")
        if chosenBasher == "Jack-O" || chosenBasher2 == "Jack-O" || chosenBasher3 == "Jack-O" || chosenBasher4 == "Jack-O" {
            zombieboyAtlas = SKTextureAtlas(named: "ZombieBoyAtlas")
            zombiegirlAtlas = SKTextureAtlas(named: "ZombieGirlAtlas")
        }
    }
}
