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
    var attackTime = false
    var ableToWalkForward = false
    var contactDamage:CGFloat = 0
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
        
        if characterName == "Cog" {
            brain = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AI.cogThink), userInfo: nil, repeats: true)
            if !inAction {
                self.doSkill_2()
                self.run(animateSkill_2!)
                inAction = true
                contactDamage = 15 + (power * 0.5)
            }
        } else {
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
        
        if attackCounter > 1 {
            self.brain.invalidate()
            self.brain = nil
            self.removeAllActions()
            self.removeAllChildren()
            self.removeFromParent()
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
        
        attackCounter += 1
        
        if attackCounter > 15 {
            self.inAction = false
        }
        
        if !inAction && attackTime && !isDead && gameScene != nil {
            inAction = true
            self.doSkill_1()
        } else {
            let healthChange = maxHP/70
            currentHP -= healthChange
            
            if currentHP <= 0 {
                self.isDead = true
                self.brain.invalidate()
                self.run(animateFaint!,completion:{
                    self.removeAllActions()
                    self.removeFromParent()
                })
            } else {
                if ableToWalkForward && !inAction {
                    let block = returnBlockBelow()
                    if block == "Water" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.7, dy: (self.physicsBody?.velocity.dy)!)
                    } else if block == "Dirt" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 1.0, dy: (self.physicsBody?.velocity.dy)!)
                    } else {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.85, dy: (self.physicsBody?.velocity.dy)!)
                    }
                }
            }
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && distanceFrom(player1!.position) < distanceFrom(player3!.position) && !self.isResting && !player1!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                if self.position.x >= player1!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x <= player1!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player1!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player1!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateIdle!),withKey:"IDLE")
                }
            }
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && distanceFrom(player2!.position) < distanceFrom(player3!.position) && !self.isResting && !player2!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.position.x > player2!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x < player2!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player2!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player2!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"IDLE")
                }
            }
        } else if distanceFrom(player3!.position) < distanceFrom(player1!.position) && distanceFrom(player3!.position) < distanceFrom(player2!.position) && !self.isResting && !player3!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.position.x > player3!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x < player3!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player3!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player3!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"IDLE")
                }
            }
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
        
        attackCounter += 1
        
        if attackCounter > 15 {
            self.inAction = false
        }
        
        if !inAction && attackTime && !isDead {
            inAction = true
            self.doSkill_1()
        } else {
            let healthChange = maxHP/70
            currentHP -= healthChange
            
            if currentHP <= 0 {
                self.isDead = true
                self.brain.invalidate()
                self.run(animateFaint!,completion:{
                    self.removeAllActions()
                    self.removeFromParent()
                })
            } else {
                if ableToWalkForward && !inAction {
                    let block = returnBlockBelow()
                    if block == "Water" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.7, dy: (self.physicsBody?.velocity.dy)!)
                    } else if block == "Dirt" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 1.0, dy: (self.physicsBody?.velocity.dy)!)
                    } else {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.85, dy: (self.physicsBody?.velocity.dy)!)
                    }
                }
            }
        }
        
        if !self.isResting && !player1!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                if self.position.x >= player1!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x <= player1!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player1!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player1!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"IDLE")
                }
            }
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
        
        attackCounter += 1
        
        if attackCounter > 15 {
            self.inAction = false
        }
        
        if !inAction && attackTime && !isDead {
            inAction = true
            self.doSkill_1()
        } else {
            let healthChange = maxHP/70
            currentHP -= healthChange
            
            if currentHP <= 0 {
                self.isDead = true
                self.brain.invalidate()
                self.run(animateFaint!,completion:{
                    self.removeAllActions()
                    self.removeFromParent()
                })
            } else {
                if ableToWalkForward && !inAction {
                    let block = returnBlockBelow()
                    if block == "Water" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.7, dy: (self.physicsBody?.velocity.dy)!)
                    } else if block == "Dirt" {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 1.0, dy: (self.physicsBody?.velocity.dy)!)
                    } else {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale * 0.85, dy: (self.physicsBody?.velocity.dy)!)
                    }
                }
            }
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && !self.isResting && !player1!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                if self.position.x >= player1!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x <= player1!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player1!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player1!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"IDLE")
                }
            }
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && !self.isResting && !player2!.isDead {
            attackTime = false
            ableToWalkForward = true
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 {
                ableToWalkForward = false
                if self.position.x > player2!.position.x + 5 {
                    self.xScale = -1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                } else if self.position.x < player2!.position.x - 5 {
                    self.xScale = 1
                    ableToWalkForward = false
                    inAction = false
                    attackTime = true
                }
            } else if self.position.x > player2!.position.x {
                self.xScale = -1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else if self.position.x < player2!.position.x {
                self.xScale = 1
                if self.action(forKey: "RUN") == nil {
                    self.removeAction(forKey: "IDLE")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"RUN")
                }
            } else {
                ableToWalkForward = false
                if self.action(forKey: "IDLE") == nil {
                    self.removeAction(forKey: "RUN")
                    self.run(SKAction.repeatForever(self.animateRun!),withKey:"IDLE")
                }
            }
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
