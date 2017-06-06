//
//  AI.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class AI:Character {
    var brain:Timer!
    var inAction = false
    var ableToWalkForward = false
    var attackCounter = 0
    
    var returnedP1 = false
    var returnedP2 = false
    var returnedP3 = false
    var returnedP4 = false
    
    var player1:Character?
    var player2:Character?
    var player3:Character?
    
    func startAI() {
        self.run(animateIdle!, withKey: "IDLE")
        
        if characterName == "Cog" {
            self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.texture!.size())
            self.physicsBody?.allowsRotation = false
            self.physicsBody!.categoryBitMask = SummonedCategory
            self.physicsBody!.collisionBitMask = WorldCategory
            if !inAction {
                self.run(SKAction.wait(forDuration: 0.025),completion:{
                    self.brain = Timer.scheduledTimer(timeInterval: 0.125, target: self, selector: #selector(AI.cogThink), userInfo: nil, repeats: true)
                    self.playerAction = "Skill_2"
                    self.doSkill_2()
                })
                inAction = true
            }
        } else {
            if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                self.player1 = self.returnPlayer(gameScene!,num: 1)
                self.player2 = self.returnPlayer(gameScene!,num: 2)
                self.player3 = self.returnPlayer(gameScene!,num: 3)
            } else if appDelegate.mpcHandler.session != nil {
                if appDelegate.mpcHandler.session.connectedPeers.count == 1 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                } else if appDelegate.mpcHandler.session.connectedPeers.count == 2 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                    self.player2 = self.returnPlayer(gameScene!,num: 2)
                } else if appDelegate.mpcHandler.session.connectedPeers.count == 3 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                    self.player2 = self.returnPlayer(gameScene!,num: 2)
                    self.player3 = self.returnPlayer(gameScene!,num: 3)
                }
            } else if GK_TRAFFIC_HANDLER.match != nil {
                if GK_TRAFFIC_HANDLER.match.players.count == 1 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                } else if GK_TRAFFIC_HANDLER.match.players.count == 2 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                    self.player2 = self.returnPlayer(gameScene!,num: 2)
                } else if GK_TRAFFIC_HANDLER.match.players.count == 3 {
                    self.player1 = self.returnPlayer(gameScene!,num: 1)
                    self.player2 = self.returnPlayer(gameScene!,num: 2)
                    self.player3 = self.returnPlayer(gameScene!,num: 3)
                }
            }
            
            if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
                brain = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(AI.think_4), userInfo: nil, repeats: true)
            } else {
                if gameScene!.otherPlayersCount == 1 {
                    brain = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(AI.think_2), userInfo: nil, repeats: true)
                } else if gameScene!.otherPlayersCount == 2 {
                    brain = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(AI.think_3), userInfo: nil, repeats: true)
                } else if gameScene!.otherPlayersCount == 3 {
                    brain = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(AI.think_4), userInfo: nil, repeats: true)
                }
            }
        }
        
        if checkIfStuck() {
            self.position.x -= 250
        }
    }
    
    func cogThink() {
        attackCounter += 1
        self.checkBlockUnderCogAI()
        if attackCounter > 15 {
            self.brain.invalidate()
            self.brain = nil
            self.removeAllActions()
            self.removeAllChildren()
            self.removeFromParent()
            if gameScene != nil {
                if self.player == gameScene!.playerNode.player {
                    if gameScene != nil {
                        gameScene?.p1SummonCount -= 1
                    }
                }
                
                if self.player == gameScene!.playerNode2.player  {
                    if gameScene != nil {
                        gameScene?.p2SummonCount -= 1
                    }
                }
                
                if gameScene!.playerNode3 != nil {
                    if self.player == gameScene!.playerNode3.player  {
                        if gameScene != nil {
                            gameScene?.p3SummonCount -= 1
                        }
                    }
                }
                
                if gameScene!.playerNode4 != nil {
                    if self.player == gameScene!.playerNode4.player  {
                        if gameScene != nil {
                            gameScene?.p4SummonCount -= 1
                        }
                    }
                }
            }
        }
    }
    
    func checkBlockUnderCogAI() {
        self.applyGroundChanges()
    }
    
    func move() {
        let block = returnBlockBelow()
        if block == "Water" {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.7, dy: (self.physicsBody?.velocity.dy)!)
        } else if block == "Dirt" {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 1.0, dy: (self.physicsBody?.velocity.dy)!)
        } else {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.85, dy: (self.physicsBody?.velocity.dy)!)
        }
    }
    
    func exposeTarget(_ target:Character) {
        if _devMode {
            target.run(SKAction.colorize(with: .yellow, colorBlendFactor: 1.0, duration: 0.4),completion:{
                target.run(SKAction.colorize(with: .yellow, colorBlendFactor: 0.0, duration: 0.4))
            })
            print(target.characterName)
        }
    }
    
    func think_4() {
        if gameScene != nil {
            if gameScene!.gameOver {
                self.removeAllActions()
                self.brain.invalidate()
            }
        } else {
            self.removeAllActions()
            self.brain.invalidate()
            self.removeAllChildren()
            self.removeAllActions()
            self.removeFromParent()
        }
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        } else if GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        }
        
        let healthChange = maxHP/70
        currentHP -= healthChange
        
        if currentHP <= 0 {
            self.isDead = true
            self.brain.invalidate()
            self.run(animateFaint!,completion:{
                self.removeAllActions()
                self.removeFromParent()
                if gameScene?.playerNode != self.player1 && gameScene?.playerNode != self.player2 && gameScene?.playerNode != self.player3 {
                    if gameScene != nil {
                        gameScene?.p1SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode2 != self.player1 && gameScene?.playerNode2 != self.player2 && gameScene?.playerNode2 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p2SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode3 != self.player1 && gameScene?.playerNode3 != self.player2 && gameScene?.playerNode3 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p3SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode4 != self.player1 && gameScene?.playerNode4 != self.player2 && gameScene?.playerNode4 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p4SummonCount -= 1
                    }
                }
            })
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && distanceFrom(player1!.position) < distanceFrom(player3!.position) && !self.isResting && !player1!.isDead {
            exposeTarget(player1!)
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player1!.position.x && !inAction {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player1!.position.x && !inAction {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && distanceFrom(player2!.position) < distanceFrom(player3!.position) && !self.isResting && !player2!.isDead {
            exposeTarget(player2!)
            ableToWalkForward = true
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player2!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player2!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else if distanceFrom(player3!.position) < distanceFrom(player1!.position) && distanceFrom(player3!.position) < distanceFrom(player2!.position) && !self.isResting && !player3!.isDead {
            exposeTarget(player3!)
            ableToWalkForward = true
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player3!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player3!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else {
            if self.position.x > 1250 {
                self.xScale = -1
            } else if self.position.x < -1250 {
                self.xScale = 1
            }
            
            if self.action(forKey: "RUN") == nil {
                self.removeAction(forKey: "IDLE")
                self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
            }
            self.move()
        }
        
        applyGroundChanges()
    }
    
    func think_3() {
        if gameScene != nil {
            if gameScene!.gameOver {
                self.removeAllActions()
                self.brain.invalidate()
            }
        } else {
            self.removeAllActions()
            self.brain.invalidate()
            self.removeAllChildren()
            self.removeAllActions()
            self.removeFromParent()
        }
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        } else if GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        }
        
        let healthChange = maxHP/70
        currentHP -= healthChange
        
        if currentHP <= 0 {
            self.isDead = true
            self.brain.invalidate()
            self.run(animateFaint!,completion:{
                self.removeAllActions()
                self.removeFromParent()
                if gameScene?.playerNode != self.player1 && gameScene?.playerNode != self.player2 && gameScene?.playerNode != self.player3 {
                    if gameScene != nil {
                        gameScene?.p1SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode2 != self.player1 && gameScene?.playerNode2 != self.player2 && gameScene?.playerNode2 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p2SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode3 != self.player1 && gameScene?.playerNode3 != self.player2 && gameScene?.playerNode3 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p3SummonCount -= 1
                    }
                }
            })
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && !self.isResting && !player1!.isDead {
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player1!.position.x && !inAction {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player1!.position.x && !inAction {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && !self.isResting && !player2!.isDead {
            ableToWalkForward = true
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player2!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player2!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else {
            if self.position.x > 1250 {
                self.xScale = -1
            } else if self.position.x < -1250 {
                self.xScale = 1
            }
            
            if self.action(forKey: "RUN") == nil {
                self.removeAction(forKey: "IDLE")
                self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
            }
            self.move()
        }
        
        applyGroundChanges()
    }
    
    func think_2() {
        if gameScene != nil {
            if gameScene!.gameOver {
                self.removeAllActions()
                self.brain.invalidate()
            }
        } else {
            self.removeAllActions()
            self.brain.invalidate()
            self.removeAllChildren()
            self.removeAllActions()
            self.removeFromParent()
        }
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        } else if GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.sendChildInfo(self.name!, position: self.position, direction: self.xScale, health: self.currentHP)
        }
        
        let healthChange = maxHP/70
        currentHP -= healthChange
        
        if currentHP <= 0 {
            self.isDead = true
            self.brain.invalidate()
            self.run(animateFaint!,completion:{
                self.removeAllActions()
                self.removeFromParent()
                if gameScene?.playerNode != self.player1 && gameScene?.playerNode != self.player2 && gameScene?.playerNode != self.player3 {
                    if gameScene != nil {
                        gameScene?.p1SummonCount -= 1
                    }
                }
                
                if gameScene?.playerNode2 != self.player1 && gameScene?.playerNode2 != self.player2 && gameScene?.playerNode2 != self.player3 {
                    if gameScene != nil {
                        gameScene?.p2SummonCount -= 1
                    }
                }
            })
        }
        
        if !self.isResting && !player1!.isDead {
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
                
                if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! {
                    if !inAction {
                        self.doSkill_1()
                        self.inAction = true
                        gameScene!.run(SKAction.wait(forDuration: 0.75),completion:{
                            self.inAction = false
                        })
                    }
                }
            } else if self.position.x > player1!.position.x && !inAction {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            } else if self.position.x < player1!.position.x && !inAction {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
                self.move()
            }
        } else {
            if self.position.x > 1250 {
                self.xScale = -1
            } else if self.position.x < -1250 {
                self.xScale = 1
            }
            
            if self.action(forKey: "RUN") == nil {
                self.removeAction(forKey: "IDLE")
                self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
            }
            self.move()
        }
        
        applyGroundChanges()
    }
    
    func applyGroundChanges() {
        if returnBlockBelow() == "Water" {
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            self.physicsBody?.affectedByGravity = false
        } else if returnBlockBelow() == "Dirt" {
            self.physicsBody?.affectedByGravity = true
        } else {
            self.physicsBody?.affectedByGravity = true
        }
    }
    
    func distanceFrom(_ point:CGPoint) -> CGFloat {
        var dist:CGFloat = 0
        dist = sqrt(pow((point.x - self.position.x),2) + pow((point.y - self.position.y),2))
        
        return dist
    }
    
    func returnPlayer(_ world:GameScene,num:Int) -> Character {
        var otherPlayer:Character?
        
        if appDelegate.mpcHandler.session == nil && GK_TRAFFIC_HANDLER.match == nil {
            if world.playerNode.player != self.player  && !returnedP1 {
                returnedP1 = true
                otherPlayer = world.playerNode
            } else if world.playerNode2.player != self.player && !returnedP2 {
                returnedP2 = true
                otherPlayer = world.playerNode2
            } else if world.playerNode3.player != self.player && !returnedP3 {
                returnedP3 = true
                otherPlayer = world.playerNode3
            } else if world.playerNode4.player != self.player && !returnedP4 {
                returnedP4 = true
                otherPlayer = world.playerNode4
            }
        } else if appDelegate.mpcHandler.session != nil {
            if appDelegate.mpcHandler.session.connectedPeers.count == 1 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                }
            } else if appDelegate.mpcHandler.session.connectedPeers.count == 2 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                } else if world.playerNode3.player != self.player && !returnedP3 {
                    returnedP3 = true
                    otherPlayer = world.playerNode3
                }
            } else if appDelegate.mpcHandler.session.connectedPeers.count == 3 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                } else if world.playerNode3.player != self.player && !returnedP3 {
                    returnedP3 = true
                    otherPlayer = world.playerNode3
                } else if world.playerNode4.player != self.player && !returnedP4 {
                    returnedP4 = true
                    otherPlayer = world.playerNode4
                }
            }
        } else if GK_TRAFFIC_HANDLER.match != nil {
            if GK_TRAFFIC_HANDLER.match.players.count == 1 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                }
            } else if GK_TRAFFIC_HANDLER.match.players.count == 2 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                } else if world.playerNode3.player != self.player && !returnedP3 {
                    returnedP3 = true
                    otherPlayer = world.playerNode3
                }
            } else if GK_TRAFFIC_HANDLER.match.players.count == 3 {
                if world.playerNode.player != self.player  && !returnedP1 {
                    returnedP1 = true
                    otherPlayer = world.playerNode
                } else if world.playerNode2.player != self.player && !returnedP2 {
                    returnedP2 = true
                    otherPlayer = world.playerNode2
                } else if world.playerNode3.player != self.player && !returnedP3 {
                    returnedP3 = true
                    otherPlayer = world.playerNode3
                } else if world.playerNode4.player != self.player && !returnedP4 {
                    returnedP4 = true
                    otherPlayer = world.playerNode4
                }
            }
        }
        
        return otherPlayer!
    }
}
