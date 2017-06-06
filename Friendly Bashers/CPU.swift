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
    var currentTime:TimeInterval = 0
    var lastTimeChangedDirection: TimeInterval = 0
    var ticks = 0
    
    var returnedP1 = false
    var returnedP2 = false
    var returnedP3 = false
    var returnedP4 = false
    
    var player1:Character?
    var player2:Character?
    var player3:Character?
    
    var innateDirection = 1
    
    func startCPU() {
        self.run(SKAction.wait(forDuration: 0.25),completion:{
            self.player1 = self.returnPlayer(gameScene!,num: 1)
            self.player2 = self.returnPlayer(gameScene!,num: 2)
            self.player3 = self.returnPlayer(gameScene!,num: 3)
            self.run(self.animateIdle!)
            self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_A), userInfo: nil, repeats: true)
        })
    }
    
    func updateCPU() {
        if brain != nil {
            self.brain.invalidate()
            self.brain = nil
        }
        
        if !self.isDead {
            if !player1!.isDead && !player2!.isDead && !player3!.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_A), userInfo: nil, repeats: true)
            } else if !player1!.isDead && !player2!.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_B_1), userInfo: nil, repeats: true)
            } else if !player2!.isDead && !player3!.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_B_2), userInfo: nil, repeats: true)
            } else if !player1!.isDead && !player3!.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_B_3), userInfo: nil, repeats: true)
            } else if !player1!.isDead && !self.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_C_1), userInfo: nil, repeats: true)
            } else if !player2!.isDead && !self.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_C_2), userInfo: nil, repeats: true)
            } else if !player3!.isDead && !self.isDead {
                self.brain = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(CPU.think_C_3), userInfo: nil, repeats: true)
            }
        }
    }
    
    func isSkillReady_1() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_1 > 0 && !self.isResting && !self.isDead {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_2() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_2 > 0 && !self.isResting && !self.isDead {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_3() -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_3 > 0 && !self.isResting && !self.isDead {
            skillReady = true
        }
        
        return skillReady
    }
    
    func attackTypeAvailable(_ type:String) -> Bool {
        var available = false
        
        if characterName == "Jack-O" {
            if type == "Ranged" && isSkillReady_2() {
                available = true
            } else if type == "Slide" && isSkillReady_3() {
                available = true
            } else if type == "Melee" && isSkillReady_2() {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Plum" {
            if type == "Ranged" && isSkillReady_1() {
                available = true
            } else if type == "Slide" && isSkillReady_3() {
                available = true
            } else if type == "Melee" && isSkillReady_2() {
                available = true
            } else if type == "Still_Buff" {
                available = false
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Rosetta" {
            if type == "Ranged" && isSkillReady_1() {
                available = true
            } else if type == "Slide" && isSkillReady_3() {
                available = true
            } else if type == "Melee" && isSkillReady_2() {
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
            } else if type == "Melee" && isSkillReady_1() {
                available = true
            } else if type == "Still_Buff" && isSkillReady_2() {
                available = true
            } else if type == "Moving_Buff" && isSkillReady_3() {
                available = true
            }
        } else if characterName == "Cog" {
            if type == "Ranged" && isSkillReady_2() {
                available = true
            } else if type == "Slide" && isSkillReady_3() {
                available = true
            } else if type == "Melee" && isSkillReady_2() {
                available = true
            } else if type == "Still_Buff" && isSkillReady_1() {
                available = true
            } else if type == "Moving_Buff" {
                available = false
            }
        } else if characterName == "Sarah" {
            if type == "Ranged" && isSkillReady_2() {
                available = true
            } else if type == "Slide" && isSkillReady_3() {
                available = true
            } else if type == "Melee" && isSkillReady_1() {
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
        let rand = Int(arc4random_uniform(5) + 1)
        
        if rand == 4 || rand == 5  {
            playerAction = ""
        } else if characterName == "Jack-O" {
            if type == "Ranged" && isSkillReady_2() {
                playerAction = "Skill_2"
            } else if type == "Slide" && isSkillReady_3() {
                playerAction = "Skill_3"
            } else if type == "Melee" && isSkillReady_2() {
                playerAction = "Skill_2"
            }
        } else if characterName == "Plum" {
            if type == "Ranged" && isSkillReady_1() {
                playerAction = "Skill_1"
            } else if type == "Slide" && isSkillReady_3() {
                playerAction = "Skill_3"
            } else if type == "Melee" && isSkillReady_2() {
                playerAction = "Skill_2"
            }
        } else if characterName == "Rosetta" {
            if type == "Ranged" && isSkillReady_1() {
                playerAction = "Skill_1"
            } else if type == "Slide" && isSkillReady_3() {
                playerAction = "Skill_3"
            } else if type == "Melee" && isSkillReady_2() {
                playerAction = "Skill_2"
            }
        } else if characterName == "Silva" {
            if type == "Melee" && isSkillReady_1() {
                playerAction = "Skill_1"
            } else if type == "Still_Buff" && isSkillReady_2() {
                playerAction = "Skill_2"
            } else if type == "Moving_Buff" && isSkillReady_3() {
                playerAction = "Skill_3"
            }
        } else if characterName == "Cog" {
            if type == "Ranged" && isSkillReady_2() {
                playerAction = "Skill_2"
            } else if type == "Slide" && isSkillReady_3() {
                playerAction = "Skill_3"
            } else if type == "Melee" && isSkillReady_2() {
                playerAction = "Skill_2"
            } else if type == "Still_Buff" && isSkillReady_1() {
                playerAction = "Skill_1"
            }
        } else if characterName == "Sarah" {
            if type == "Ranged" && isSkillReady_2() {
                playerAction = "Skill_2"
            } else if type == "Slide" && isSkillReady_3() {
                playerAction = "Skill_3"
            } else if type == "Melee" && isSkillReady_1() {
                playerAction = "Skill_1"
            }
        }
    }
    
    func isLowHP() -> Bool {
        var low = false
        if self.currentHP <= self.maxHP * 0.15 {
            low = true
        }
        
        return low
    }
    
    func think_A() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && distanceFrom(player1!.position) < distanceFrom(player3!.position) && !self.isResting && !player1!.isDead && !self.isDead {
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player1!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player1!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player1!.position) && abs(self.position.x - player1!.position.x) <= 600) {
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
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && distanceFrom(player2!.position) < distanceFrom(player3!.position) && !self.isResting && !player2!.isDead && !self.isDead {
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player2!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player2!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player2!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player2!.position) && abs(self.position.x - player2!.position.x) <= 600)  {
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
        } else if distanceFrom(player3!.position) < distanceFrom(player1!.position) && distanceFrom(player3!.position) < distanceFrom(player2!.position) && !self.isResting && !player3!.isDead && !self.isDead{
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player3!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player3!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else if self.position.x < player3!.position.x {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player3!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player3!.position) && abs(self.position.x - player3!.position.x) <= 600) {
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
        }
    }
    
    func think_B_1() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player2!.position) && !self.isResting && !player1!.isDead && !self.isDead {
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player1!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player1!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player1!.position) && abs(self.position.x - player1!.position.x) <= 600) {
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
        } else if distanceFrom(player2!.position) < distanceFrom(player1!.position) && !self.isResting && !player2!.isDead && !self.isDead {
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player2!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player2!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player2!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player2!.position) && abs(self.position.x - player2!.position.x) <= 600)  {
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
        }
    }
    
    func think_B_2() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if distanceFrom(player2!.position) < distanceFrom(player3!.position) && !self.isResting && !player2!.isDead && !self.isDead {
            if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player2!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player2!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player2!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player2!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player2!.position) && abs(self.position.x - player2!.position.x) <= 600)  {
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
        } else if distanceFrom(player3!.position) < distanceFrom(player2!.position) && !self.isResting && !player3!.isDead && !self.isDead {
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player3!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player3!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else if self.position.x < player3!.position.x {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player3!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player3!.position) && abs(self.position.x - player3!.position.x) <= 600) {
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
        }
    }
    
    func think_B_3() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if distanceFrom(player1!.position) < distanceFrom(player3!.position) && !self.isResting && !player1!.isDead && !self.isDead {
            if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player1!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player1!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player1!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player1!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player1!.position) && abs(self.position.x - player1!.position.x) <= 600) {
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
        } else if distanceFrom(player3!.position) < distanceFrom(player1!.position) && !self.isResting && !player3!.isDead && !self.isDead {
            if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
                playerMovement = ""
                if self.position.x > player3!.position.x {
                    self.xScale = -1
                } else {
                    self.xScale = 1
                }
            } else if self.position.x > player3!.position.x {
                if self.isLowHP() && innateDirection == 2 {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                }
            } else if self.position.x < player3!.position.x {
                if self.isLowHP() && innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else if self.withinSight(player3!.position) && !self.isLowHP() {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
                if attackTypeAvailable("Melee") && playerMovement == "" {
                    useAttack("Melee")
                } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                    useAttack("Still_Buff")
                }
            } else if self.position.y > player3!.position.y {
                playerAction = ""
                if innateDirection == 1 {
                    playerMovement = "Move_Left"
                    self.xScale = -1
                } else {
                    playerMovement = "Move_Right"
                    self.xScale = 1
                }
            } else {
                playerAction = "Jump"
            }
            
            if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
                if (self.withinSight(player3!.position) && abs(self.position.x - player3!.position.x) <= 600) {
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
        }
    }
    
    func think_C_1() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if abs(self.position.x - player1!.position.x) <= player1!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
            playerMovement = ""
            if self.position.x > player1!.position.x {
                self.xScale = -1
            } else {
                self.xScale = 1
            }
        } else if self.position.x > player1!.position.x {
            if self.isLowHP() && innateDirection == 2 {
                playerMovement = "Move_Right"
                self.xScale = 1
            } else if self.withinSight(player1!.position) && !self.isLowHP() {
                playerMovement = "Move_Left"
                self.xScale = -1
            }
        } else {
            if self.isLowHP() && innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else if self.withinSight(player1!.position) && !self.isLowHP() {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        }
        
        if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
            if attackTypeAvailable("Melee") && playerMovement == "" {
                useAttack("Melee")
            } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                useAttack("Still_Buff")
            }
        } else if self.position.y > player1!.position.y {
            playerAction = ""
            if innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        } else {
            playerAction = "Jump"
        }
        
        if abs(self.position.y - player1!.position.y) <= player1!.size.height/2 + halfHeight! + 5 {
            if (self.withinSight(player1!.position) && abs(self.position.x - player1!.position.x) <= 600) {
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
    }
    
    func think_C_2() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if abs(self.position.x - player2!.position.x) <= player2!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
            playerMovement = ""
            if self.position.x > player2!.position.x {
                self.xScale = -1
            } else {
                self.xScale = 1
            }
        } else if self.position.x > player2!.position.x {
            if self.isLowHP() && innateDirection == 2 {
                playerMovement = "Move_Right"
                self.xScale = 1
            } else if self.withinSight(player2!.position) && !self.isLowHP() {
                playerMovement = "Move_Left"
                self.xScale = -1
            }
        } else {
            if self.isLowHP() && innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else if self.withinSight(player2!.position) && !self.isLowHP() {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        }
        
        if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 && !self.isLowHP() {
            if attackTypeAvailable("Melee") && playerMovement == "" {
                useAttack("Melee")
            } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                useAttack("Still_Buff")
            }
        } else if self.position.y > player2!.position.y {
            playerAction = ""
            if innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        } else {
            playerAction = "Jump"
        }
        
        if abs(self.position.y - player2!.position.y) <= player2!.size.height/2 + halfHeight! + 5 {
            if (self.withinSight(player2!.position) && abs(self.position.x - player2!.position.x) <= 600)  {
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
    }
    
    func think_C_3() {
        if ticks < 500 {
            ticks += 1
        } else {
            ticks = 0
            if innateDirection == 1 {
                innateDirection = 2
            } else {
                innateDirection = 1
            }
        }
        
        if abs(self.position.x - player3!.position.x) <= player3!.size.width/2 + halfWidth! + 10 && !self.isLowHP() {
            playerMovement = ""
            if self.position.x > player3!.position.x {
                self.xScale = -1
            } else {
                self.xScale = 1
            }
        } else if self.position.x > player3!.position.x {
            if self.isLowHP() && innateDirection == 2 {
                playerMovement = "Move_Right"
                self.xScale = 1
            } else if self.withinSight(player3!.position) && !self.isLowHP() {
                playerMovement = "Move_Left"
                self.xScale = -1
            }
        } else if self.position.x < player3!.position.x {
            if self.isLowHP() && innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else if self.withinSight(player3!.position) && !self.isLowHP() {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        }
        
        if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5  && !self.isLowHP() {
            if attackTypeAvailable("Melee") && playerMovement == "" {
                useAttack("Melee")
            } else if attackTypeAvailable("Still_Buff") && playerMovement == "" {
                useAttack("Still_Buff")
            }
        } else if self.position.y > player3!.position.y {
            playerAction = ""
            if innateDirection == 1 {
                playerMovement = "Move_Left"
                self.xScale = -1
            } else {
                playerMovement = "Move_Right"
                self.xScale = 1
            }
        } else {
            playerAction = "Jump"
        }
        
        if abs(self.position.y - player3!.position.y) <= player3!.size.height/2 + halfHeight! + 5 {
            if (self.withinSight(player3!.position) && abs(self.position.x - player3!.position.x) <= 600) {
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
    }
    
    func withinSight(_ point:CGPoint) -> Bool {
        var returnBool = false
        
        if distanceFrom(point) <= 600 {
            returnBool = true
        }
        
        return returnBool
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
        
        return otherPlayer!
    }
}
