//
//  CPU.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class CPU:Character {
    var brain:Timer!
    var inAction = false
    var playerMovement = ""
    var playerLastMovement = ""
    var playerAction = ""
    var playerLastAction = ""
    var currentTime:TimeInterval = 0
    var timeSinceNoAction: TimeInterval = 0
    
    var returnedP1 = false
    var returnedP2 = false
    var returnedP3 = false
    var returnedP4 = false
    
    var world:GameScene?
    var player1:Character?
    var player2:Character?
    var player3:Character?
    
    func startCPU() {
        world = self.parent as! GameScene?
        self.run(SKAction.wait(forDuration: 3),completion:{
            self.player1 = self.returnPlayer(self.world!,num: 1)
            self.player2 = self.returnPlayer(self.world!,num: 2)
            self.player3 = self.returnPlayer(self.world!,num: 3)
            self.run(self.animateIdle!)
            self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.processInfo), userInfo: nil, repeats: true)
        })
    }
    
    func isSkillReady_1() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_1 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_2() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_2 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_3() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_3 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func playerAnimations() {
        if playerMovement != playerLastMovement {
            if playerMovement == "Move_Right" || playerMovement == "Move_Left" {
                self.removeAllActions()
                self.run(self.animateRun!)
            } else if playerMovement == "" && playerAction == "" {
                self.removeAllActions()
                self.run(self.animateIdle!)
            } else if playerMovement == "" {
                self.removeAllActions()
                self.run(self.animateIdle!)
            }
        }
        
        if playerAction != playerLastAction {
            if playerAction == "" && playerMovement == "" {
                self.removeAllActions()
                self.run(self.animateIdle!)
            } else if playerAction == "Jump" && self.currentJumps < self.maxJumps{
                self.run(self.animateJump!)
            } else if playerAction == "Skill_1" && isSkillReady_1() {
                self.run(self.animateSkill_1!)
                self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                    self.playerLastAction = ""
                    self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                        self.playerLastAction = ""
                    })
                })
            } else if playerAction == "Skill_2" && isSkillReady_2() {
                self.run(self.animateSkill_2!)
                self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                    self.playerLastAction = ""
                    self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                        self.playerLastAction = ""
                    })
                })
            } else if playerAction == "Skill_3" && isSkillReady_3() {
                self.run(self.animateSkill_3!)
                self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                    self.playerLastAction = ""
                    self.parent?.run(SKAction.wait(forDuration: 0.6),completion:{
                        self.playerLastAction = ""
                    })
                })
            }
        }
    }
    
    func attackTypeAvailable(_ type:String) -> Bool {
        var available = false
        
        if characterName == "Jack-O" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                available = true
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Plum" {
            if type == "Ranged" && skillCurrentCharges_1 > 0 {
                available = true
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                available = true
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Rosetta" {
            if type == "Ranged" && skillCurrentCharges_1 > 0 {
                available = true
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                available = true
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Silva" {
            if type == "Ranged" {
                available = false
            } else if type == "Slide" {
                available = false
            } else if type == "Melee" && skillCurrentCharges_1 > 0 {
                available = true
            } else if type == "Still_Buff" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Moving_Buff" && skillCurrentCharges_3 > 0 {
                available = true
            }
        } else if characterName == "Cog" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                available = true
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Still_Buff" && skillCurrentCharges_1 > 0 {
                available = true
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Sarah" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                available = true
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                available = true
            } else if type == "Melee" && skillCurrentCharges_1 > 0 {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        }
        
        return available
    }
    
    func useAttack(_ type:String) {
        if characterName == "Jack-O" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            }
        } else if characterName == "Plum" {
            if type == "Ranged" && skillCurrentCharges_1 > 0 {
                playerAction = "Skill_1"
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            }
        } else if characterName == "Rosetta" {
            if type == "Ranged" && skillCurrentCharges_1 > 0 {
                playerAction = "Skill_1"
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            }
        } else if characterName == "Silva" {
            if type == "Melee" && skillCurrentCharges_1 > 0 {
                playerAction = "Skill_1"
            } else if type == "Still_Buff" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            } else if type == "Moving_Buff" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            }
        } else if characterName == "Cog" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            } else if type == "Melee" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            } else if type == "Still_Buff" && skillCurrentCharges_1 > 0 {
                playerAction = "Skill_1"
            }
        } else if characterName == "Sarah" {
            if type == "Ranged" && skillCurrentCharges_2 > 0 {
                playerAction = "Skill_2"
            } else if type == "Slide" && skillCurrentCharges_3 > 0 {
                playerAction = "Skill_3"
            } else if type == "Melee" && skillCurrentCharges_1 > 0 {
                playerAction = "Skill_1"
            }
        }
    }
    
    func processInfo() {
        think()
        update(currentTime)
    }
    
    func think() {
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && distanceFrom(player1!.position) < distanceFrom(player2!.position) && !self.isResting && !player1!.isDead {
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player1!.position.x {
                playerMovement = "Move_Left"
            } else {
                playerMovement = "Move_Right"
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
                //print(self.characterName + " should attack")
                //print("Current Action: " + self.playerAction + " Last Action: " + self.playerLastAction)
            } else if self.position.y > player1!.position.y {
                playerAction = ""
                playerMovement = "Move_Left"
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
                if (abs(self.position.x - player1!.position.x) > player1!.size.width/2 + halfWidth! + 10 && abs(self.position.x - player1!.position.x) <= 600) {
                    if attackTypeAvailable("Ranged") {
                        self.playerMovement = ""
                        useAttack("Ranged")
                    } else if attackTypeAvailable("Moving_Buff") {
                        self.playerMovement = ""
                        useAttack("Moving_Buff")
                    } else if attackTypeAvailable("Slide") {
                        self.playerMovement = ""
                        useAttack("Slide")
                    }
                }
            }
            //print(characterName + " chasing " + player1!.characterName)
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && distanceFrom(player2!.position) < distanceFrom(player3!.position) && !self.isResting && !player2!.isDead {
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player2!.position.x {
                playerMovement = "Move_Left"
            } else {
                playerMovement = "Move_Right"
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
                //print(self.characterName + " should attack")
                //print("Current Action: " + self.playerAction + " Last Action: " + self.playerLastAction)
            } else if self.position.y > player2!.position.y {
                playerAction = ""
                playerMovement = "Move_Left"
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
                if (abs(self.position.x - player2!.position.x) > player2!.size.width/2 + halfWidth! + 10 && abs(self.position.x - player2!.position.x) <= 600)  {
                    if attackTypeAvailable("Ranged") {
                        self.playerMovement = ""
                        useAttack("Ranged")
                    } else if attackTypeAvailable("Moving_Buff") {
                        self.playerMovement = ""
                        useAttack("Moving_Buff")
                    } else if attackTypeAvailable("Slide") {
                        self.playerMovement = ""
                        useAttack("Slide")
                    }
                }
            }
            //print(characterName + " chasing " + player2!.characterName)
        } else if distanceFrom(player3!.position) < distanceFrom(player1!.position) && distanceFrom(player3!.position) < distanceFrom(player2!.position) && !self.isResting && !player3!.isDead {
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player3!.position.x {
                playerMovement = "Move_Left"
            } else if self.position.x < player3!.position.x {
                playerMovement = "Move_Right"
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
                //print(self.characterName + " should attack")
                //print("Current Action: " + self.playerAction + " Last Action: " + self.playerLastAction)
            } else if self.position.y > player3!.position.y {
                playerAction = ""
                playerMovement = "Move_Left"
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
                if (abs(self.position.x - player3!.position.x) > player3!.size.width/2 + halfWidth! + 10 && abs(self.position.x - player3!.position.x) <= 600) {
                    if attackTypeAvailable("Ranged") {
                        self.playerMovement = ""
                        useAttack("Ranged")
                    } else if attackTypeAvailable("Moving_Buff") {
                        self.playerMovement = ""
                        useAttack("Moving_Buff")
                    } else if attackTypeAvailable("Slide") {
                        self.playerMovement = ""
                        useAttack("Slide")
                    }
                }
            }
            //print(characterName + " chasing " + player3!.characterName)
        }
    }
    
    func distanceFrom(_ point:CGPoint) -> CGFloat {
        var dist:CGFloat = 0
        
        dist = sqrt(pow((point.x - self.position.x),2) + pow((point.y - self.position.y),2))
        
        return dist
    }
    
    func returnPlayer(_ world:GameScene,num:Int) -> Character {
        var otherPlayer:Character?
        
        if world.playerNode != self && !returnedP1 {
            returnedP1 = true
            otherPlayer = world.playerNode
        } else if world.playerNode2 != self && !returnedP2 {
            returnedP2 = true
            otherPlayer = world.playerNode2
        } else if world.playerNode3 != self && !returnedP3 {
            returnedP3 = true
            otherPlayer = world.playerNode3
        } else if world.playerNode4 != self && !returnedP4 {
            returnedP4 = true
            otherPlayer = world.playerNode4
        }

        //print("P1 Taken:" + String(returnedP1))
        //print("P2 Taken:" + String(returnedP2))
        //print("P3 Taken:" + String(returnedP3))
        //print("P4 Taken:" + String(returnedP4))
        //print(otherPlayer!)
        return otherPlayer!
    }
    
    func playerMovement(mod:CGFloat) {
        if playerMovement == "Move_Left" {
            self.xScale = -1
            self.physicsBody?.velocity = CGVector(dx: -self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
        } else if playerMovement == "Move_Right" {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
            self.xScale = 1
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        let position = CGPoint(x: (self.position.x), y: self.position.y - self.size.height/2)
        let column = (self.parent as! GameScene).tileMapNode?.tileColumnIndex(fromPosition: position)
        let row = (self.parent as! GameScene).tileMapNode?.tileRowIndex(fromPosition: position)
        let tile = (self.parent as! GameScene).tileMapNode?.tileGroup(atColumn: column!, row: row!)
        
        if playerAction == "" {
            timeSinceNoAction = currentTime
        }
        
        if tile?.name == "Dirt" {
            playerMovement(mod: 1.0)
            self.resetJumpsCount()
            if playerMovement == "" {
                self.physicsBody?.velocity.dx = 0
            }
            
            if self.isResting && self.allowedToRecover {
                self.recovered()
            }
        } else if tile?.name == "Water" {
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            self.physicsBody?.affectedByGravity = false
            playerMovement(mod: 0.4)
            self.resetJumpsCount()
        } else {
            self.physicsBody?.affectedByGravity = true
            playerMovement(mod: 0.75)
        }
        
        if self.isResting {
            playerMovement = ""
            playerLastMovement = ""
        }
        
        if self.isResting && self.currentHP >= self.maxHP {
            self.recovered()
        }
        
        if deathMode == 2 && (tile?.name == "Water" && self.isResting) {
            self.brain.invalidate()
            self.removeAllActions()
            self.removeFromParent()
            self.isDead = true
        } else if deathMode == 1 && self.lives <= 0 && self.isResting {
            self.brain.invalidate()
            self.removeAllActions()
            self.removeFromParent()
            self.isDead = true
        }
        
        if currentTime - self.skill_1_Last_Used >= self.skillCooldown_1 {
            self.skill_1_Last_Used = currentTime
            if self.skillCurrentCharges_1 < self.skillMaxCharges_1 {
                self.skillCurrentCharges_1 += 1
            }
        }
        
        if currentTime - self.skill_2_Last_Used >= self.skillCooldown_2 {
            self.skill_2_Last_Used = currentTime
            if self.skillCurrentCharges_2 < self.skillMaxCharges_2 {
                self.skillCurrentCharges_2 += 1
            }
        }
        
        if currentTime - self.skill_3_Last_Used >= self.skillCooldown_3 {
            self.skill_3_Last_Used = currentTime
            if self.skillCurrentCharges_3 < self.skillMaxCharges_3 {
                self.skillCurrentCharges_3 += 1
            }
        }
        
        playerAnimations()
        
        if playerAction != playerLastAction {
            if playerAction == "Jump" && self.currentJumps < self.maxJumps {
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.movespeed * 0.25))
                self.currentJumps += 1
                playerLastAction = playerAction
            } else if playerAction == "Skill_1" && self.isSkillReady_1() {
                self.skill_1_Last_Used = currentTime
                playerLastAction = playerAction
                self.skillCurrentCharges_1 -= 1
                self.doSkill_1()
            } else if playerAction == "Skill_2" && self.isSkillReady_2() {
                self.skill_2_Last_Used = currentTime
                playerLastAction = playerAction
                self.skillCurrentCharges_2 -= 1
                self.doSkill_2()
            } else if playerAction == "Skill_3" && self.isSkillReady_3() {
                self.skill_3_Last_Used = currentTime
                playerLastAction = playerAction
                self.skillCurrentCharges_3 -= 1
                self.doSkill_3()
            }
        }
        
        playerLastMovement = playerMovement
    }
}
