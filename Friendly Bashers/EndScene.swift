//
//  EndScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/22/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class EndScene:SKScene {
    var outcome:String?
    var outcomeLabel:SKLabelNode?
    var okayButton:SKSpriteNode?
    var playerAnimation:Character?
    var floorSprite:SKSpriteNode?
    var readyToMove = false
    
    var backgroundAtlas = bgAtlas
    var UIAtlas = uiAtlas
    
    override func sceneDidLoad() {
        self.okayButton = self.childNode(withName: "//okayButton") as? SKSpriteNode
        self.outcomeLabel = self.childNode(withName: "//outcomeLabel") as? SKLabelNode
        self.playerAnimation = self.childNode(withName: "//playerBasher") as? Character
        self.floorSprite = self.childNode(withName: "//floorSprite") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
        var audioNode = SKAudioNode()
        
        if outcome == "Victory" {
            outcomeLabel?.fontColor = SKColor.green
            winCount += 1
            outcomeLabel?.text = outcome! + "!"
            defaults.setValue(winCount, forKey: "WINS")
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                audioNode = SKAudioNode(fileNamed: "Gewonnen_Kasenfrosch.mp3")
                audioNode.autoplayLooped = false
                self.addChild(audioNode)
                if sfxEnabled {
                    audioNode.run(SKAction.play())
                } else {
                    audioNode.run(SKAction.stop())
                }
            })
        } else if outcome == "Defeat" {
            outcomeLabel?.fontColor = SKColor.red
            outcomeLabel?.text = outcome! + "..."
            self.run(SKAction.wait(forDuration: 0.03),completion:{
                audioNode = SKAudioNode(fileNamed: "WahWah_Kirbydx.wav")
                audioNode.autoplayLooped = false
                self.addChild(audioNode)
                if sfxEnabled {
                    audioNode.run(SKAction.play())
                } else {
                    audioNode.run(SKAction.stop())
                }
            })
        }
        
        self.run(SKAction.wait(forDuration: 0.25), completion:{
            self.animateOutcome()
        })
        
        okayButton?.run(SKAction.wait(forDuration: 4.5),completion:{
            audioNode.run(SKAction.stop())
            self.readyToMove = true
            self.okayButton?.run(SKAction.setTexture(self.UIAtlas.textureNamed("Button_Enabled")))
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.okayButton?.contains(pos))! && readyToMove {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.removeAllActions()
                    self.removeAllChildren()
                    self.removeFromParent()
                    if let view = self.view {
                        view.presentScene(basherSelect)
                        view.ignoresSiblingOrder = false
                        
                        view.showsFPS = true
                        view.showsNodeCount = false
                    }
                })
            }
        }
    }
    
    func animateOutcome() {
        if chosenBasher == "Cog" {
            playerAnimation?.run(SKAction.setTexture(charAtlas.textureNamed("Cat_Idle"), resize: true))
        } else {
            playerAnimation?.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher + "_Idle"), resize: true))
        }
        playerAnimation?.CharAtlas = SKTextureAtlas(named: chosenBasher + "Atlas")
        playerAnimation?.setUp(chosenBasher)
        
        floorSprite?.position.y = (playerAnimation?.position.y)! - (playerAnimation?.size.height)!/2
        if outcome == "Victory" {
            self.victoryAnimation()
        } else {
            self.defeatAnimation()
        }
    }
    
    func victoryAnimation() {
        playerAnimation?.run(SKAction.moveTo(y: playerAnimation!.position.y + 30, duration: 0.45))
        playerAnimation?.run(playerAnimation!.animateJump!,completion:{
            self.playerAnimation?.run(SKAction.moveTo(y: self.playerAnimation!.position.y - 30, duration: 0.45))
        })
    }
    
    func defeatAnimation() {
        playerAnimation?.run(playerAnimation!.animateFaint!,completion:{
            if chosenBasher == "Cog" {
                self.playerAnimation?.run(SKAction.setTexture(charAtlas.textureNamed("Cat_Faint"), resize: true))
            } else {
                self.playerAnimation?.run(SKAction.setTexture(charAtlas.textureNamed(chosenBasher + "_Faint"), resize: true))
            }
        })
    }
}
