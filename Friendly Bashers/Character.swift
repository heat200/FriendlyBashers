//
//  Character.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/18/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class Character:SKSpriteNode {
    var player = ""
    
    var characterName = "Default"
    var characterForm = ""
    var BASE_MAX_HP:CGFloat = 10
    var BASE_POWER:CGFloat = 10
    var BASE_RESISTANCE:CGFloat = 10
    var BASE_MOVESPEED:CGFloat = 100
    
    var BASE_MAX_HP_2:CGFloat = 10
    var BASE_POWER_2:CGFloat = 10
    var BASE_RESISTANCE_2:CGFloat = 10
    var BASE_MOVESPEED_2:CGFloat = 100
    
    var BASE_MAX_JUMPS:Int = 2
    var BASE_SKILL_COOLDOWN_1:Double = 10
    var BASE_SKILL_MAX_CHARGES_1:Int = 1
    var BASE_SKILL_COOLDOWN_2:Double = 10
    var BASE_SKILL_MAX_CHARGES_2:Int = 1
    var BASE_SKILL_COOLDOWN_3:Double = 10
    var BASE_SKILL_MAX_CHARGES_3:Int = 1
    
    var BASE_HP_REGEN:CGFloat = 0.1
    var hpRegen:CGFloat = 0.1
    
    var maxHP:CGFloat = 10
    var currentHP:CGFloat = 10
    var power:CGFloat = 10
    var resistance:CGFloat = 10
    var movespeed:CGFloat = 10
    
    var maxHP_2:CGFloat = 10
    var currentHP_2:CGFloat = 10
    var power_2:CGFloat = 10
    var resistance_2:CGFloat = 10
    var movespeed_2:CGFloat = 10
    
    var maxJumps:Int = 2
    var currentJumps:Int = 0
    
    var skillCooldown_1:Double = 10
    var skill_1_Last_Used:Double = 0
    var skillMaxCharges_1:Int = 1
    var skillCurrentCharges_1:Int = 0
    var skillCooldown_2:Double = 10
    var skill_2_Last_Used:Double = 0
    var skillMaxCharges_2:Int = 1
    var skillCurrentCharges_2:Int = 0
    var skillCooldown_3:Double = 10
    var skill_3_Last_Used:Double = 0
    var skillMaxCharges_3:Int = 1
    var skillCurrentCharges_3:Int = 0
    
    var halfHeight:CGFloat?
    var halfWidth:CGFloat?
    
    var isStunned = false
    var isInvuln = false
    var isResting = false
    var allowedToRecover = false
    var isDead = false
    
    var animateIdle:SKAction?
    var animateRun:SKAction?
    var animateJump:SKAction?
    var animateSkill_1:SKAction?
    var animateSkill_2:SKAction?
    var animateSkill_3:SKAction?
    var animateFaint:SKAction?
    
    var lives = 2
    
    func setUp(name:String) {
        halfHeight = self.size.height/2
        halfWidth = self.size.width/2
        if characterName == "Cog" {
            characterForm = "Cat"
        }
        
        if characterForm == "Boy" || characterForm == "Girl" {
            animateFaint = SKAction.animate(with: [SKTexture(imageNamed:name + characterForm + "_Faint_1"),SKTexture(imageNamed:name + characterForm + "_Faint_2"),SKTexture(imageNamed:name + characterForm + "_Faint_3"),SKTexture(imageNamed:name + characterForm + "_Faint_4"),SKTexture(imageNamed:name + characterForm + "_Faint_5"),SKTexture(imageNamed:name + characterForm + "_Faint_6"),SKTexture(imageNamed:name + characterForm + "_Faint_7"),SKTexture(imageNamed:name + characterForm + "_Faint_8"),SKTexture(imageNamed:name + characterForm + "_Faint_9"),SKTexture(imageNamed:name + characterForm + "_Faint_10"),SKTexture(imageNamed:name + characterForm + "_Faint_11"),SKTexture(imageNamed:name + characterForm + "_Faint_12")], timePerFrame: 0.0625,resize:true,restore:true)
        } else if characterForm == "Cat" || characterForm == "Dog" {
            animateFaint = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Faint_1"),SKTexture(imageNamed:characterForm + "_Faint_2"),SKTexture(imageNamed:characterForm + "_Faint_3"),SKTexture(imageNamed:characterForm + "_Faint_4"),SKTexture(imageNamed:characterForm + "_Faint_5"),SKTexture(imageNamed:characterForm + "_Faint_6"),SKTexture(imageNamed:characterForm + "_Faint_7"),SKTexture(imageNamed:characterForm + "_Faint_8"),SKTexture(imageNamed:characterForm + "_Faint_9"),SKTexture(imageNamed:characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else {
            animateFaint = SKAction.animate(with: [SKTexture(imageNamed:name + "_Faint_1"),SKTexture(imageNamed:name + "_Faint_2"),SKTexture(imageNamed:name + "_Faint_3"),SKTexture(imageNamed:name + "_Faint_4"),SKTexture(imageNamed:name + "_Faint_5"),SKTexture(imageNamed:name + "_Faint_6"),SKTexture(imageNamed:name + "_Faint_7"),SKTexture(imageNamed:name + "_Faint_8"),SKTexture(imageNamed:name + "_Faint_9"),SKTexture(imageNamed:name + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
        
        if name == "Jack-O" {
            characterName = name
            BASE_MAX_HP = 500
            BASE_POWER = 20
            BASE_RESISTANCE = 20
            BASE_MOVESPEED = 340
            BASE_MAX_JUMPS = 8
            
            BASE_SKILL_COOLDOWN_1 = 0
            BASE_SKILL_COOLDOWN_2 = 12
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 0
            BASE_SKILL_MAX_CHARGES_2 = 2
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            
            currentHP = maxHP
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            if characterForm == "Boy" {
                maxHP = 50 + (maxHP * 0.1)
                currentHP = maxHP
                power = 20 + (power * 0.4)
                resistance = -5 + (resistance * 0.5)
                movespeed = 20 + (movespeed * 1.0)
                
                animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_10"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_11"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_12"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_13"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_14"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_15")], timePerFrame: 0.065,resize:true,restore:true))
                
                animateRun = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_10")], timePerFrame: 0.09,resize:true,restore:true)
                
                animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_8")], timePerFrame: 0.035,resize:true,restore:true)
                
                animateFaint = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
            } else if characterForm == "Girl" {
                maxHP = 50 + (maxHP * 0.05)
                currentHP = maxHP
                power = (power * 0.2)
                resistance = -5 + (resistance * 1.0)
                movespeed = 20 + (movespeed * 1.75)
                
                animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_10"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_11"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_12"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_13"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_14"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Idle_15")], timePerFrame: 0.065,resize:true,restore:true))
                
                animateRun = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Run_10")], timePerFrame: 0.09,resize:true,restore:true)
                
                animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Attack_8")], timePerFrame: 0.035,resize:true,restore:true)
                
                animateFaint = SKAction.animate(with: [SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_1"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_2"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_3"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_4"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_5"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_6"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_7"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_8"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_9"),SKTexture(imageNamed:name + "_Zombie_" + characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
            } else {
                animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Idle_1"),SKTexture(imageNamed:name + "_Idle_2"),SKTexture(imageNamed:name + "_Idle_3"),SKTexture(imageNamed:name + "_Idle_4"),SKTexture(imageNamed:name + "_Idle_5"),SKTexture(imageNamed:name + "_Idle_6"),SKTexture(imageNamed:name + "_Idle_7"),SKTexture(imageNamed:name + "_Idle_8"),SKTexture(imageNamed:name + "_Idle_9"),SKTexture(imageNamed:name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
                
                animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Run_1"),SKTexture(imageNamed:name + "_Run_2"),SKTexture(imageNamed:name + "_Run_3"),SKTexture(imageNamed:name + "_Run_4"),SKTexture(imageNamed:name + "_Run_5"),SKTexture(imageNamed:name + "_Run_6"),SKTexture(imageNamed:name + "_Run_7"),SKTexture(imageNamed:name + "_Run_8")], timePerFrame: 0.0625,resize:true,restore:true))
                
                animateJump = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
                
                animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
                
                animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slide_1"),SKTexture(imageNamed:name + "_Slide_2"),SKTexture(imageNamed:name + "_Slide_3"),SKTexture(imageNamed:name + "_Slide_4"),SKTexture(imageNamed:name + "_Slide_5"),SKTexture(imageNamed:name + "_Slide_6"),SKTexture(imageNamed:name + "_Slide_7"),SKTexture(imageNamed:name + "_Slide_8"),SKTexture(imageNamed:name + "_Slide_9"),SKTexture(imageNamed:name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
                
            }
        } else if name == "Plum" {
            characterName = name
            BASE_MAX_HP = 250
            BASE_POWER = 50
            BASE_RESISTANCE = 10
            BASE_MOVESPEED = 400
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            
            currentHP = maxHP
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/10)
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2 + Int(power/25)
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Idle_1"),SKTexture(imageNamed:name + "_Idle_2"),SKTexture(imageNamed:name + "_Idle_3"),SKTexture(imageNamed:name + "_Idle_4"),SKTexture(imageNamed:name + "_Idle_5"),SKTexture(imageNamed:name + "_Idle_6"),SKTexture(imageNamed:name + "_Idle_7"),SKTexture(imageNamed:name + "_Idle_8"),SKTexture(imageNamed:name + "_Idle_9"),SKTexture(imageNamed:name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Run_1"),SKTexture(imageNamed:name + "_Run_2"),SKTexture(imageNamed:name + "_Run_3"),SKTexture(imageNamed:name + "_Run_4"),SKTexture(imageNamed:name + "_Run_5"),SKTexture(imageNamed:name + "_Run_6"),SKTexture(imageNamed:name + "_Run_7"),SKTexture(imageNamed:name + "_Run_8"),SKTexture(imageNamed:name + "_Run_9"),SKTexture(imageNamed:name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Throw_1"),SKTexture(imageNamed:name + "_Throw_2"),SKTexture(imageNamed:name + "_Throw_3"),SKTexture(imageNamed:name + "_Throw_4"),SKTexture(imageNamed:name + "_Throw_5"),SKTexture(imageNamed:name + "_Throw_6"),SKTexture(imageNamed:name + "_Throw_7"),SKTexture(imageNamed:name + "_Throw_8"),SKTexture(imageNamed:name + "_Throw_9"),SKTexture(imageNamed:name + "_Throw_10")], timePerFrame: 0.015,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slash_1"),SKTexture(imageNamed:name + "_Slash_2"),SKTexture(imageNamed:name + "_Slash_3"),SKTexture(imageNamed:name + "_Slash_4"),SKTexture(imageNamed:name + "_Slash_5"),SKTexture(imageNamed:name + "_Slash_6"),SKTexture(imageNamed:name + "_Slash_7"),SKTexture(imageNamed:name + "_Slash_8"),SKTexture(imageNamed:name + "_Slash_9"),SKTexture(imageNamed:name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slide_1"),SKTexture(imageNamed:name + "_Slide_2"),SKTexture(imageNamed:name + "_Slide_3"),SKTexture(imageNamed:name + "_Slide_4"),SKTexture(imageNamed:name + "_Slide_5"),SKTexture(imageNamed:name + "_Slide_6"),SKTexture(imageNamed:name + "_Slide_7"),SKTexture(imageNamed:name + "_Slide_8"),SKTexture(imageNamed:name + "_Slide_9"),SKTexture(imageNamed:name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Rosetta" {
            characterName = name
            BASE_MAX_HP = 100
            BASE_POWER = 75
            BASE_RESISTANCE = 10
            BASE_MOVESPEED = 525
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            currentHP = maxHP
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/10)
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2 + Int(power/25)
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Idle_1"),SKTexture(imageNamed:name + "_Idle_2"),SKTexture(imageNamed:name + "_Idle_3"),SKTexture(imageNamed:name + "_Idle_4"),SKTexture(imageNamed:name + "_Idle_5"),SKTexture(imageNamed:name + "_Idle_6"),SKTexture(imageNamed:name + "_Idle_7"),SKTexture(imageNamed:name + "_Idle_8"),SKTexture(imageNamed:name + "_Idle_9"),SKTexture(imageNamed:name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Run_1"),SKTexture(imageNamed:name + "_Run_2"),SKTexture(imageNamed:name + "_Run_3"),SKTexture(imageNamed:name + "_Run_4"),SKTexture(imageNamed:name + "_Run_5"),SKTexture(imageNamed:name + "_Run_6"),SKTexture(imageNamed:name + "_Run_7"),SKTexture(imageNamed:name + "_Run_8"),SKTexture(imageNamed:name + "_Run_9"),SKTexture(imageNamed:name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Throw_1"),SKTexture(imageNamed:name + "_Throw_2"),SKTexture(imageNamed:name + "_Throw_3"),SKTexture(imageNamed:name + "_Throw_4"),SKTexture(imageNamed:name + "_Throw_5"),SKTexture(imageNamed:name + "_Throw_6"),SKTexture(imageNamed:name + "_Throw_7"),SKTexture(imageNamed:name + "_Throw_8"),SKTexture(imageNamed:name + "_Throw_9"),SKTexture(imageNamed:name + "_Throw_10")], timePerFrame: 0.015,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slash_1"),SKTexture(imageNamed:name + "_Slash_2"),SKTexture(imageNamed:name + "_Slash_3"),SKTexture(imageNamed:name + "_Slash_4"),SKTexture(imageNamed:name + "_Slash_5"),SKTexture(imageNamed:name + "_Slash_6"),SKTexture(imageNamed:name + "_Slash_7"),SKTexture(imageNamed:name + "_Slash_8"),SKTexture(imageNamed:name + "_Slash_9"),SKTexture(imageNamed:name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slide_1"),SKTexture(imageNamed:name + "_Slide_2"),SKTexture(imageNamed:name + "_Slide_3"),SKTexture(imageNamed:name + "_Slide_4"),SKTexture(imageNamed:name + "_Slide_5"),SKTexture(imageNamed:name + "_Slide_6"),SKTexture(imageNamed:name + "_Slide_7"),SKTexture(imageNamed:name + "_Slide_8"),SKTexture(imageNamed:name + "_Slide_9"),SKTexture(imageNamed:name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Silva" {
            characterName = name
            BASE_MAX_HP = 1000
            BASE_POWER = 10
            BASE_RESISTANCE = 40
            BASE_MOVESPEED = 300
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.9
            BASE_SKILL_COOLDOWN_2 = 12.5
            BASE_SKILL_COOLDOWN_3 = 8
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            currentHP = maxHP
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/25)
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Idle_1"),SKTexture(imageNamed:name + "_Idle_2"),SKTexture(imageNamed:name + "_Idle_3"),SKTexture(imageNamed:name + "_Idle_4"),SKTexture(imageNamed:name + "_Idle_5"),SKTexture(imageNamed:name + "_Idle_6"),SKTexture(imageNamed:name + "_Idle_7"),SKTexture(imageNamed:name + "_Idle_8"),SKTexture(imageNamed:name + "_Idle_9"),SKTexture(imageNamed:name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Run_1"),SKTexture(imageNamed:name + "_Run_2"),SKTexture(imageNamed:name + "_Run_3"),SKTexture(imageNamed:name + "_Run_4"),SKTexture(imageNamed:name + "_Run_5"),SKTexture(imageNamed:name + "_Run_6"),SKTexture(imageNamed:name + "_Run_7"),SKTexture(imageNamed:name + "_Run_8"),SKTexture(imageNamed:name + "_Run_9"),SKTexture(imageNamed:name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slash_1"),SKTexture(imageNamed:name + "_Slash_2"),SKTexture(imageNamed:name + "_Slash_3"),SKTexture(imageNamed:name + "_Slash_4"),SKTexture(imageNamed:name + "_Slash_5"),SKTexture(imageNamed:name + "_Slash_6"),SKTexture(imageNamed:name + "_Slash_7"),SKTexture(imageNamed:name + "_Slash_8"),SKTexture(imageNamed:name + "_Slash_9"),SKTexture(imageNamed:name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
        } else if name == "Sarah" {
            characterName = name
            BASE_MAX_HP = 300
            BASE_POWER = 30
            BASE_RESISTANCE = 30
            BASE_MOVESPEED = 375
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 1.00
            BASE_SKILL_COOLDOWN_2 = 0.85
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            currentHP = maxHP
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/10)
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2 + Int(power/10)
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Idle_1"),SKTexture(imageNamed:name + "_Idle_2"),SKTexture(imageNamed:name + "_Idle_3"),SKTexture(imageNamed:name + "_Idle_4"),SKTexture(imageNamed:name + "_Idle_5"),SKTexture(imageNamed:name + "_Idle_6"),SKTexture(imageNamed:name + "_Idle_7"),SKTexture(imageNamed:name + "_Idle_8"),SKTexture(imageNamed:name + "_Idle_9"),SKTexture(imageNamed:name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:name + "_Run_1"),SKTexture(imageNamed:name + "_Run_2"),SKTexture(imageNamed:name + "_Run_3"),SKTexture(imageNamed:name + "_Run_4"),SKTexture(imageNamed:name + "_Run_5"),SKTexture(imageNamed:name + "_Run_6"),SKTexture(imageNamed:name + "_Run_7"),SKTexture(imageNamed:name + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:name + "_Jump_1"),SKTexture(imageNamed:name + "_Jump_2"),SKTexture(imageNamed:name + "_Jump_3"),SKTexture(imageNamed:name + "_Jump_4"),SKTexture(imageNamed:name + "_Jump_5"),SKTexture(imageNamed:name + "_Jump_6"),SKTexture(imageNamed:name + "_Jump_7"),SKTexture(imageNamed:name + "_Jump_8"),SKTexture(imageNamed:name + "_Jump_9"),SKTexture(imageNamed:name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slash_1"),SKTexture(imageNamed:name + "_Slash_2"),SKTexture(imageNamed:name + "_Slash_3"),SKTexture(imageNamed:name + "_Slash_4"),SKTexture(imageNamed:name + "_Slash_5"),SKTexture(imageNamed:name + "_Slash_6"),SKTexture(imageNamed:name + "_Slash_7")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Throw_1"),SKTexture(imageNamed:name + "_Throw_2"),SKTexture(imageNamed:name + "_Throw_3")], timePerFrame: 0.09,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:name + "_Slide_1"),SKTexture(imageNamed:name + "_Slide_2"),SKTexture(imageNamed:name + "_Slide_3"),SKTexture(imageNamed:name + "_Slide_4"),SKTexture(imageNamed:name + "_Slide_5")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Cog" {
            characterName = name
            
            BASE_MAX_HP = 160
            BASE_MAX_HP_2 = 240
            BASE_POWER = 5
            BASE_POWER_2 = 15
            BASE_RESISTANCE = 15
            BASE_RESISTANCE_2 = 15
            BASE_MOVESPEED = 420
            BASE_MOVESPEED_2 = 360
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 9
            BASE_SKILL_COOLDOWN_2 = 3
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 2
            BASE_SKILL_MAX_CHARGES_3 = 1
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed = BASE_MOVESPEED
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed = BASE_MOVESPEED * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed = BASE_MOVESPEED * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed = BASE_MOVESPEED * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed = BASE_MOVESPEED * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed = BASE_MOVESPEED * 1.01
                }
                
                if blessingList[chosenBlessing][0] >= 5 {
                    maxJumps = BASE_MAX_JUMPS + 2
                } else if blessingList[chosenBlessing][0] == 4 {
                    maxJumps = BASE_MAX_JUMPS + 1
                } else {
                    maxJumps = BASE_MAX_JUMPS
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power = BASE_POWER
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power = BASE_POWER * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power = BASE_POWER * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power = BASE_POWER * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power = BASE_POWER * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power = BASE_POWER * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE = BASE_RESISTANCE + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance = BASE_RESISTANCE
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance = BASE_RESISTANCE * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance = BASE_RESISTANCE * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance = BASE_RESISTANCE * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance = BASE_RESISTANCE * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance = BASE_RESISTANCE * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP = BASE_MAX_HP + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP = BASE_MAX_HP + 25
                } else {
                    maxHP = BASE_MAX_HP
                }
                
                if blessingList[chosenBlessing][3] == 0 {
                    hpRegen = BASE_HP_REGEN
                } else if blessingList[chosenBlessing][3] >= 9 {
                    hpRegen = BASE_HP_REGEN + 1.00
                } else if blessingList[chosenBlessing][3] >= 8 {
                    hpRegen = BASE_HP_REGEN + 0.75
                } else if blessingList[chosenBlessing][3] >= 3 {
                    hpRegen = BASE_HP_REGEN + 0.5
                } else if blessingList[chosenBlessing][3] >= 2 {
                    hpRegen = BASE_HP_REGEN + 0.25
                } else if blessingList[chosenBlessing][3] >= 1 {
                    hpRegen = BASE_HP_REGEN + 0.1
                }
                
                if blessingList[chosenBlessing][3] >= 7 {
                    hpRegen += (maxHP * 0.03)
                } else if blessingList[chosenBlessing][3] == 6 {
                    hpRegen += (maxHP * 0.015)
                }
                
                if blessingList[chosenBlessing][3] >= 5 {
                    hpRegen *= 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    hpRegen *= 1.025
                }
            } else {
                maxJumps = BASE_MAX_JUMPS
                movespeed = BASE_MOVESPEED
                power = BASE_POWER
                resistance = BASE_RESISTANCE
                maxHP = BASE_MAX_HP
                hpRegen = BASE_HP_REGEN
            }
            
            currentHP = maxHP
            
            if (!(self is CPU) && !(self is AI)) {
                if blessingList[chosenBlessing][0] == 0 {
                    movespeed_2 = BASE_MOVESPEED_2
                } else if blessingList[chosenBlessing][0] >= 9 {
                    movespeed_2 = BASE_MOVESPEED_2 * 1.1
                } else if blessingList[chosenBlessing][0] >= 8 {
                    movespeed_2 = BASE_MOVESPEED_2 * 1.075
                } else if blessingList[chosenBlessing][0] >= 3 {
                    movespeed_2 = BASE_MOVESPEED_2 * 1.05
                } else if blessingList[chosenBlessing][0] >= 2 {
                    movespeed_2 = BASE_MOVESPEED_2 * 1.025
                } else if blessingList[chosenBlessing][0] >= 1 {
                    movespeed_2 = BASE_MOVESPEED_2 * 1.01
                }
                
                if blessingList[chosenBlessing][1] == 0 {
                    power_2 = BASE_POWER_2
                } else if blessingList[chosenBlessing][1] >= 9 {
                    power_2 = BASE_POWER_2 * 1.1
                } else if blessingList[chosenBlessing][1] >= 8 {
                    power_2 = BASE_POWER_2 * 1.075
                } else if blessingList[chosenBlessing][1] >= 3 {
                    power_2 = BASE_POWER_2 * 1.05
                } else if blessingList[chosenBlessing][1] >= 2 {
                    power_2 = BASE_POWER_2 * 1.025
                } else if blessingList[chosenBlessing][1] >= 1 {
                    power_2 = BASE_POWER_2 * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 5 {
                    BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 10
                } else if blessingList[chosenBlessing][2] == 4 {
                    BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 5
                }
                
                if blessingList[chosenBlessing][2] == 0 {
                    resistance_2 = BASE_RESISTANCE_2
                } else if blessingList[chosenBlessing][2] >= 9 {
                    resistance_2 = BASE_RESISTANCE_2 * 1.1
                } else if blessingList[chosenBlessing][2] >= 8 {
                    resistance_2 = BASE_RESISTANCE_2 * 1.075
                } else if blessingList[chosenBlessing][2] >= 3 {
                    resistance_2 = BASE_RESISTANCE_2 * 1.05
                } else if blessingList[chosenBlessing][2] >= 2 {
                    resistance_2 = BASE_RESISTANCE_2 * 1.025
                } else if blessingList[chosenBlessing][2] >= 1 {
                    resistance_2 = BASE_RESISTANCE_2 * 1.01
                }
                
                if blessingList[chosenBlessing][2] >= 7 {
                    maxHP_2 = BASE_MAX_HP_2 + 50
                } else if blessingList[chosenBlessing][2] == 6 {
                    maxHP_2 = BASE_MAX_HP_2 + 25
                } else {
                    maxHP_2 = BASE_MAX_HP_2
                }
            } else {
                movespeed_2 = BASE_MOVESPEED_2
                power_2 = BASE_POWER_2
                resistance_2 = BASE_RESISTANCE_2
                maxHP_2 = BASE_MAX_HP_2
            }
            currentHP_2 = maxHP_2
            
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1
            skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2
            skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
            
            skillCooldown_1 = BASE_SKILL_COOLDOWN_1
            skillCooldown_2 = BASE_SKILL_COOLDOWN_2
            skillCooldown_3 = BASE_SKILL_COOLDOWN_3
            
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Idle_1"),SKTexture(imageNamed:characterForm + "_Idle_2"),SKTexture(imageNamed:characterForm + "_Idle_3"),SKTexture(imageNamed:characterForm + "_Idle_4"),SKTexture(imageNamed:characterForm + "_Idle_5"),SKTexture(imageNamed:characterForm + "_Idle_6"),SKTexture(imageNamed:characterForm + "_Idle_7"),SKTexture(imageNamed:characterForm + "_Idle_8"),SKTexture(imageNamed:characterForm + "_Idle_9"),SKTexture(imageNamed:characterForm + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Run_1"),SKTexture(imageNamed:characterForm + "_Run_2"),SKTexture(imageNamed:characterForm + "_Run_3"),SKTexture(imageNamed:characterForm + "_Run_4"),SKTexture(imageNamed:characterForm + "_Run_5"),SKTexture(imageNamed:characterForm + "_Run_6"),SKTexture(imageNamed:characterForm + "_Run_7"),SKTexture(imageNamed:characterForm + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Jump_1"),SKTexture(imageNamed:characterForm + "_Jump_2"),SKTexture(imageNamed:characterForm + "_Jump_3"),SKTexture(imageNamed:characterForm + "_Jump_4"),SKTexture(imageNamed:characterForm + "_Jump_5"),SKTexture(imageNamed:characterForm + "_Jump_6"),SKTexture(imageNamed:characterForm + "_Jump_7"),SKTexture(imageNamed:characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Jump_1"),SKTexture(imageNamed:characterForm + "_Jump_2"),SKTexture(imageNamed:characterForm + "_Jump_3"),SKTexture(imageNamed:characterForm + "_Jump_4"),SKTexture(imageNamed:characterForm + "_Jump_5"),SKTexture(imageNamed:characterForm + "_Jump_6"),SKTexture(imageNamed:characterForm + "_Jump_7"),SKTexture(imageNamed:characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Slide_1"),SKTexture(imageNamed:characterForm + "_Slide_2"),SKTexture(imageNamed:characterForm + "_Slide_3"),SKTexture(imageNamed:characterForm + "_Slide_4"),SKTexture(imageNamed:characterForm + "_Slide_5"),SKTexture(imageNamed:characterForm + "_Slide_6"),SKTexture(imageNamed:characterForm + "_Slide_7"),SKTexture(imageNamed:characterForm + "_Slide_8"),SKTexture(imageNamed:characterForm + "_Slide_9"),SKTexture(imageNamed:characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Slide_1"),SKTexture(imageNamed:characterForm + "_Slide_2"),SKTexture(imageNamed:characterForm + "_Slide_3"),SKTexture(imageNamed:characterForm + "_Slide_4"),SKTexture(imageNamed:characterForm + "_Slide_5"),SKTexture(imageNamed:characterForm + "_Slide_6"),SKTexture(imageNamed:characterForm + "_Slide_7"),SKTexture(imageNamed:characterForm + "_Slide_8"),SKTexture(imageNamed:characterForm + "_Slide_9"),SKTexture(imageNamed:characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
        
    }
    
    func resetJumpsCount() {
        currentJumps = 0
    }
    
    func checkEnvironmentForStatMods(envName:String) {
        
    }
    
    func applyDamage(_ damage:CGFloat) {
        let gameWorld = self.parent as! GameScene
        if abs(self.position.x - gameWorld.playerNode.position.x) <= gameWorld.playerNode.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameWorld.playerNode.position.y) <= gameWorld.playerNode.halfHeight! + 5 + self.halfHeight! && gameWorld.playerNode != self {
            if self.position.x > gameWorld.playerNode.position.x && self.xScale == -1 {
                gameWorld.playerNode.takeDamage(damage, direction: self.xScale)
            } else if self.position.x < gameWorld.playerNode.position.x && self.xScale == 1 {
                gameWorld.playerNode.takeDamage(damage, direction: self.xScale)
            }
        }
        
        if abs(self.position.x - gameWorld.playerNode2.position.x) <= gameWorld.playerNode2.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameWorld.playerNode2.position.y) <= gameWorld.playerNode2.halfHeight! + 5 + self.halfHeight! && gameWorld.playerNode2 != self{
            if self.position.x > gameWorld.playerNode2.position.x && self.xScale == -1 {
                gameWorld.playerNode2.takeDamage(damage, direction: self.xScale)
            } else if self.position.x < gameWorld.playerNode2.position.x && self.xScale == 1 {
                gameWorld.playerNode2.takeDamage(damage, direction: self.xScale)
            }
        }
        
        if abs(self.position.x - gameWorld.playerNode3.position.x) <= gameWorld.playerNode3.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameWorld.playerNode3.position.y) <= gameWorld.playerNode3.halfHeight! + 5 + self.halfHeight! && gameWorld.playerNode3 != self {
            if self.position.x > gameWorld.playerNode3.position.x && self.xScale == -1 {
                gameWorld.playerNode3.takeDamage(damage, direction: self.xScale)
            } else if self.position.x < gameWorld.playerNode3.position.x && self.xScale == 1 {
                gameWorld.playerNode3.takeDamage(damage, direction: self.xScale)
            }
        }
        
        if abs(self.position.x - gameWorld.playerNode4.position.x) <= gameWorld.playerNode4.halfWidth! + self.halfWidth! + 5 && abs(self.position.y - gameWorld.playerNode4.position.y) <= gameWorld.playerNode4.halfHeight! + 5 + self.halfHeight! && gameWorld.playerNode4 != self {
            if self.position.x > gameWorld.playerNode4.position.x && self.xScale == -1 {
                gameWorld.playerNode4.takeDamage(damage, direction: self.xScale)
            } else if self.position.x < gameWorld.playerNode4.position.x && self.xScale == 1 {
                gameWorld.playerNode4.takeDamage(damage, direction: self.xScale)
            }
        }
    }
    
    func doSkill_1() {
        if characterName == "Jack-O" {
            let damage:CGFloat = 0 + (power * 1.0)
            applyDamage(damage)
        } else if characterName == "Plum" {
            let damage:CGFloat = 5 + (power * 0.1)
            summon(damage)
        } else if characterName == "Rosetta" {
            let damage:CGFloat = 5 + (power * 0.1)
            summon(damage)
        } else if characterName == "Silva" {
            let damage:CGFloat = 5 + (power * 0.05)
            applyDamage(damage)
        } else if characterName == "Sarah" {
            let damage:CGFloat = 5 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Cog" {
            var passingVar:CGFloat = 0
            if characterForm == "Cat" {
                characterForm = "Dog"
                
                passingVar = maxHP
                maxHP = maxHP_2
                maxHP_2 = passingVar
                passingVar = BASE_MAX_HP
                BASE_MAX_HP = BASE_MAX_HP_2
                BASE_MAX_HP_2 = passingVar
                passingVar = currentHP
                currentHP = currentHP_2
                currentHP_2 = passingVar
                //print("Switched maxHP and BASE_MAX_HP and currentHP for Cog. (Cat -> Dog)")
                
                passingVar = BASE_POWER
                BASE_POWER = BASE_POWER_2
                BASE_POWER_2 = passingVar
                passingVar = power
                power = power_2
                power_2 = passingVar
                //print("Switched BASE_POWER and power for Cog. (Cat -> Dog)")
                
                passingVar = BASE_RESISTANCE
                BASE_RESISTANCE = BASE_RESISTANCE_2
                BASE_RESISTANCE_2 = passingVar
                passingVar = resistance
                resistance = resistance_2
                resistance_2 = passingVar
                //print("Switched BASE_RESISTANCE and resistance for Cog. (Cat -> Dog)")
                
                passingVar = BASE_MOVESPEED
                BASE_MOVESPEED = BASE_MOVESPEED_2
                BASE_MOVESPEED_2 = passingVar
                passingVar = movespeed
                movespeed = movespeed_2
                movespeed_2 = passingVar
                //print("Switched BASE_MOVESPEED and movespeed for Cog. (Cat -> Dog)")
                
                movespeed += 25 + (currentHP * 1.0)
                power += 20 + (movespeed * 0.2)
                self.parent!.run(SKAction.wait(forDuration: 5),completion:{
                    self.movespeed = self.BASE_MOVESPEED
                    self.power = self.BASE_POWER
                })
                //print("Applied Switch Bonuses. (Cat -> Dog)")
            } else {
                characterForm = "Cat"
                
                passingVar = maxHP
                maxHP = maxHP_2
                maxHP_2 = passingVar
                passingVar = BASE_MAX_HP
                BASE_MAX_HP = BASE_MAX_HP_2
                BASE_MAX_HP_2 = passingVar
                passingVar = currentHP
                currentHP = currentHP_2
                currentHP_2 = passingVar
                //print("Switched maxHP and BASE_MAX_HP and currentHP for Cog. (Dog -> Cat)")
                
                passingVar = BASE_POWER
                BASE_POWER = BASE_POWER_2
                BASE_POWER_2 = passingVar
                passingVar = power
                power = power_2
                power_2 = passingVar
                //print("Switched BASE_POWER and power for Cog. (Dog -> Cat)")
                
                passingVar = BASE_RESISTANCE
                BASE_RESISTANCE = BASE_RESISTANCE_2
                BASE_RESISTANCE_2 = passingVar
                passingVar = resistance
                resistance = resistance_2
                resistance_2 = passingVar
                //print("Switched BASE_RESISTANCE and resistance for Cog. (Dog -> Cat)")
                
                passingVar = BASE_MOVESPEED
                BASE_MOVESPEED = BASE_MOVESPEED_2
                BASE_MOVESPEED_2 = passingVar
                passingVar = movespeed
                movespeed = movespeed_2
                movespeed_2 = passingVar
                //print("Switched BASE_MOVESPEED and movespeed for Cog. (Dog -> Cat)")
                
                movespeed += 25 + (currentHP * 1.0)
                power += 20 + (movespeed * 0.2)
                self.parent!.run(SKAction.wait(forDuration: 5),completion:{
                    self.movespeed = self.BASE_MOVESPEED
                    self.power = self.BASE_POWER
                })
                //print("Applied Switch Bonuses. (Dog -> Cat)")
            }
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Idle_1"),SKTexture(imageNamed:characterForm + "_Idle_2"),SKTexture(imageNamed:characterForm + "_Idle_3"),SKTexture(imageNamed:characterForm + "_Idle_4"),SKTexture(imageNamed:characterForm + "_Idle_5"),SKTexture(imageNamed:characterForm + "_Idle_6"),SKTexture(imageNamed:characterForm + "_Idle_7"),SKTexture(imageNamed:characterForm + "_Idle_8"),SKTexture(imageNamed:characterForm + "_Idle_9"),SKTexture(imageNamed:characterForm + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Run_1"),SKTexture(imageNamed:characterForm + "_Run_2"),SKTexture(imageNamed:characterForm + "_Run_3"),SKTexture(imageNamed:characterForm + "_Run_4"),SKTexture(imageNamed:characterForm + "_Run_5"),SKTexture(imageNamed:characterForm + "_Run_6"),SKTexture(imageNamed:characterForm + "_Run_7"),SKTexture(imageNamed:characterForm + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Jump_1"),SKTexture(imageNamed:characterForm + "_Jump_2"),SKTexture(imageNamed:characterForm + "_Jump_3"),SKTexture(imageNamed:characterForm + "_Jump_4"),SKTexture(imageNamed:characterForm + "_Jump_5"),SKTexture(imageNamed:characterForm + "_Jump_6"),SKTexture(imageNamed:characterForm + "_Jump_7"),SKTexture(imageNamed:characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Jump_1"),SKTexture(imageNamed:characterForm + "_Jump_2"),SKTexture(imageNamed:characterForm + "_Jump_3"),SKTexture(imageNamed:characterForm + "_Jump_4"),SKTexture(imageNamed:characterForm + "_Jump_5"),SKTexture(imageNamed:characterForm + "_Jump_6"),SKTexture(imageNamed:characterForm + "_Jump_7"),SKTexture(imageNamed:characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Slide_1"),SKTexture(imageNamed:characterForm + "_Slide_2"),SKTexture(imageNamed:characterForm + "_Slide_3"),SKTexture(imageNamed:characterForm + "_Slide_4"),SKTexture(imageNamed:characterForm + "_Slide_5"),SKTexture(imageNamed:characterForm + "_Slide_6"),SKTexture(imageNamed:characterForm + "_Slide_7"),SKTexture(imageNamed:characterForm + "_Slide_8"),SKTexture(imageNamed:characterForm + "_Slide_9"),SKTexture(imageNamed:characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [SKTexture(imageNamed:characterForm + "_Slide_1"),SKTexture(imageNamed:characterForm + "_Slide_2"),SKTexture(imageNamed:characterForm + "_Slide_3"),SKTexture(imageNamed:characterForm + "_Slide_4"),SKTexture(imageNamed:characterForm + "_Slide_5"),SKTexture(imageNamed:characterForm + "_Slide_6"),SKTexture(imageNamed:characterForm + "_Slide_7"),SKTexture(imageNamed:characterForm + "_Slide_8"),SKTexture(imageNamed:characterForm + "_Slide_9"),SKTexture(imageNamed:characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
    }
    
    func doSkill_2() {
        if characterName == "Jack-O" {
            let damage:CGFloat = 0
            summon(damage)
        } else if characterName == "Plum" {
            let damage:CGFloat = (power * 1) - 25
            applyDamage(damage)
        } else if characterName == "Rosetta" {
            let damage:CGFloat = (power * 1) - 25
            applyDamage(damage)
        } else if characterName == "Silva" {
            let damage:CGFloat = 10 + ((maxHP - currentHP) * 0.5)
            self.power += damage
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/25)
            self.parent!.run(SKAction.wait(forDuration: 5),completion:{
                self.power = self.BASE_POWER
                self.skillMaxCharges_1 = self.BASE_SKILL_MAX_CHARGES_1 + Int(self.power/25)
            })
        } else if characterName == "Sarah" {
            let damage:CGFloat = 5 + (power * 0.15)
            summon(damage)
        } else if characterName == "Cog" {
            let damage:CGFloat = 15 + (power * 0.5)
            self.run(SKAction.moveTo(x: self.position.x + (250 * self.xScale), duration: 0.6))
            applyDamage(damage)
            summon(damage)
        }
    }
    
    func doSkill_3() {
        if characterName == "Jack-O" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Plum" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Rosetta" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Silva" {
            let damage:CGFloat = 10 + (currentHP * 0.25)
            self.movespeed += damage
            self.parent!.run(SKAction.wait(forDuration: 10),completion:{
                self.movespeed = self.BASE_MOVESPEED
            })
        } else if characterName == "Sarah" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Cog" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        }
    }
    
    func summon(_ damage:CGFloat) {
        if !(self is AI) {
            if characterName == "Jack-O" {
                let zombie_boy = AI(imageNamed: characterName + "_Zombie_Boy_Idle_1")
                zombie_boy.characterForm = "Boy"
                zombie_boy.player = self.player
                zombie_boy.setUp(name: characterName)
                zombie_boy.startAI()
                zombie_boy.xScale = self.xScale
                zombie_boy.position.x = self.position.x + (150 * self.xScale)
                zombie_boy.position.y = self.position.y
                zombie_boy.physicsBody = SKPhysicsBody(texture: zombie_boy.texture!, size: zombie_boy.texture!.size())
                zombie_boy.physicsBody?.allowsRotation = false
                zombie_boy.physicsBody!.contactTestBitMask = ProjectileCategory | WorldCategory | CharacterCategory
                zombie_boy.physicsBody!.categoryBitMask = ProjectileCategory
                zombie_boy.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                self.parent!.addChild(zombie_boy)
                
                let zombie_girl = AI(imageNamed: characterName + "_Zombie_Girl_Idle_1")
                zombie_girl.characterForm = "Girl"
                zombie_girl.player = self.player
                zombie_girl.setUp(name: characterName)
                zombie_girl.startAI()
                zombie_girl.xScale = self.xScale
                zombie_girl.position.x = self.position.x + (100 * self.xScale)
                zombie_girl.position.y = self.position.y
                zombie_girl.physicsBody = SKPhysicsBody(texture: zombie_girl.texture!, size: zombie_girl.texture!.size())
                zombie_girl.physicsBody?.allowsRotation = false
                zombie_girl.physicsBody!.contactTestBitMask = ProjectileCategory | WorldCategory | CharacterCategory
                zombie_girl.physicsBody!.categoryBitMask = ProjectileCategory
                zombie_girl.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                self.parent!.addChild(zombie_girl)
            } else if characterName == "Plum" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (kunai.damage * self.xScale) * 2.5, dy: 0))
            } else if characterName == "Rosetta" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (kunai.damage * self.xScale) * 2.5, dy: 0))
            } else if characterName == "Sarah" {
                let bullet = Projectile(imageNamed: "Bullet")
                bullet.setUp(damage, direction: self.xScale, owner: self.player)
                bullet.position.y = self.position.y
                bullet.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(bullet)
                bullet.physicsBody!.applyImpulse(CGVector(dx: (bullet.damage * self.xScale) * 2.5, dy: 0))
            } else if characterName == "Cog" {
                if characterForm == "Cat" {
                    let dog = AI(imageNamed: "Dog_Idle_1")
                    dog.characterForm = "Dog"
                    dog.player = self.player
                    dog.setUp(name: characterName)
                    dog.startAI()
                    dog.xScale = self.xScale * -1
                    dog.position.x = self.position.x + (530 * self.xScale)
                    dog.position.y = self.position.y
                    dog.physicsBody = SKPhysicsBody(texture: dog.texture!, size: dog.texture!.size())
                    dog.physicsBody?.allowsRotation = false
                    dog.physicsBody!.contactTestBitMask = ProjectileCategory | WorldCategory | CharacterCategory
                    dog.physicsBody!.categoryBitMask = ProjectileCategory
                    dog.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                    self.parent!.addChild(dog)
                    self.parent!.run(SKAction.wait(forDuration: 2.5),completion:{
                        dog.brain.invalidate()
                        dog.removeFromParent()
                        dog.removeAllActions()
                    })
                } else {
                    let cat = AI(imageNamed: "Cat_Idle_1")
                    cat.characterForm = "Cat"
                    cat.player = self.player
                    cat.setUp(name: characterName)
                    cat.startAI()
                    cat.xScale = self.xScale * -1
                    cat.position.x = self.position.x + (530 * self.xScale)
                    cat.position.y = self.position.y
                    cat.physicsBody = SKPhysicsBody(texture: cat.texture!, size: cat.texture!.size())
                    cat.physicsBody?.allowsRotation = false
                    cat.physicsBody!.contactTestBitMask = ProjectileCategory | WorldCategory | CharacterCategory
                    cat.physicsBody!.categoryBitMask = ProjectileCategory
                    cat.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                    self.parent!.addChild(cat)
                    self.parent!.run(SKAction.wait(forDuration: 2.5),completion:{
                        cat.brain.invalidate()
                        cat.removeFromParent()
                        cat.removeAllActions()
                    })
                }
            }
        }
    }
    
    func takeDamage(_ damageToTake: CGFloat, direction: CGFloat) {
        let damageModified = damageToTake * (1 - resistance/100)
        print("Damage could've been: " + String(describing: damageToTake))
        print("Lost " + String(describing: damageModified) + "HP")
        
        currentHP -= damageModified
        
        if currentHP <= 0 {
            currentHP = 0
            if !isResting {
                isResting = true
                self.removeAllActions()
                self.run(animateFaint!,completion:{
                    var new = SKTexture(imageNamed:self.characterName + "_Faint_10")
                    if self.characterName == "Cog" {
                        new = SKTexture(imageNamed: self.characterForm + "_Faint_10")
                    }
                    self.run(SKAction.setTexture(new))
                    self.size = new.size()
                })
            } else {
                var new = SKTexture(imageNamed:self.characterName + "_Faint_10")
                if self.characterName == "Cog" {
                    new = SKTexture(imageNamed: self.characterForm + "_Faint_10")
                }
                self.run(SKAction.setTexture(new))
                self.size = new.size()
            }
            
            self.parent?.run(SKAction.wait(forDuration: Double(damageModified/2)),completion:{
                self.allowedToRecover = true
            })
        }
        
        if currentHP <= 10 {
            self.physicsBody?.applyImpulse(CGVector(dx: (damageToTake * direction) * (maxHP/10), dy: damageToTake * (maxHP/10)))
        } else {
            self.physicsBody?.applyImpulse(CGVector(dx: (damageToTake * direction) * (maxHP/currentHP), dy: damageToTake * (maxHP/currentHP)))
        }
    }
    
    func recovered() {
        self.isResting = false
        self.allowedToRecover = false
        var new = SKTexture(imageNamed:self.characterName + "_Idle_1")
        if self.characterName == "Cog" {
            new = SKTexture(imageNamed: self.characterForm + "_Idle_10")
        }
        self.run(SKAction.setTexture(new))
        self.size = new.size()
        lives -= 1
    }
    
}
