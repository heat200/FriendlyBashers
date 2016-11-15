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
    
    var playerMovement = ""
    var playerLastMovement = ""
    var playerAction = ""
    var playerLastAction = ""
    
    
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
    var faintCount = 0
    var lastRegenTime:Double = 0
    
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
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            BASE_MAX_HP = 200
            BASE_POWER = 50
            BASE_RESISTANCE = 15
            BASE_MOVESPEED = 400
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            BASE_RESISTANCE = 15
            BASE_MOVESPEED = 525
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            BASE_RESISTANCE = 35
            BASE_MOVESPEED = 350
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.9
            BASE_SKILL_COOLDOWN_2 = 12.5
            BASE_SKILL_COOLDOWN_3 = 8
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[0][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[0][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[0][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[0][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[0][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[0][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[0][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[0][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[0][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[0][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[0][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[0][3] == 4 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[1][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[1][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[1][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[1][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[1][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[1][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[1][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[1][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[1][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[1][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[1][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[1][3] == 4 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed = BASE_MOVESPEED
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed = BASE_MOVESPEED * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed = BASE_MOVESPEED * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed = BASE_MOVESPEED * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed = BASE_MOVESPEED * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed = BASE_MOVESPEED * 1.01
                    }
                    
                    if otherPlayerBlessings[2][0] >= 5 {
                        maxJumps = BASE_MAX_JUMPS + 2
                    } else if otherPlayerBlessings[2][0] == 4 {
                        maxJumps = BASE_MAX_JUMPS + 1
                    } else {
                        maxJumps = BASE_MAX_JUMPS
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power = BASE_POWER
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power = BASE_POWER * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power = BASE_POWER * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power = BASE_POWER * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power = BASE_POWER * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power = BASE_POWER * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE = BASE_RESISTANCE + 5
                    }
                    
                    if otherPlayerBlessings[2][2] == 0 {
                        resistance = BASE_RESISTANCE
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance = BASE_RESISTANCE * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance = BASE_RESISTANCE * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance = BASE_RESISTANCE * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance = BASE_RESISTANCE * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance = BASE_RESISTANCE * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP = BASE_MAX_HP + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
                        maxHP = BASE_MAX_HP + 25
                    } else {
                        maxHP = BASE_MAX_HP
                    }
                    
                    if otherPlayerBlessings[2][3] == 0 {
                        hpRegen = BASE_HP_REGEN
                    } else if otherPlayerBlessings[2][3] >= 9 {
                        hpRegen = BASE_HP_REGEN + 1.00
                    } else if otherPlayerBlessings[2][3] >= 8 {
                        hpRegen = BASE_HP_REGEN + 0.75
                    } else if otherPlayerBlessings[2][3] >= 3 {
                        hpRegen = BASE_HP_REGEN + 0.5
                    } else if otherPlayerBlessings[2][3] >= 2 {
                        hpRegen = BASE_HP_REGEN + 0.25
                    } else if otherPlayerBlessings[2][3] >= 1 {
                        hpRegen = BASE_HP_REGEN + 0.1
                    }
                    
                    if otherPlayerBlessings[2][3] >= 7 {
                        hpRegen += (maxHP * 0.03)
                    } else if otherPlayerBlessings[2][3] == 6 {
                        hpRegen += (maxHP * 0.015)
                    }
                    
                    if otherPlayerBlessings[2][3] >= 5 {
                        hpRegen *= 1.05
                    } else if otherPlayerBlessings[2][3] == 4 {
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
            }
            
            currentHP = maxHP
            
            if self == gameScene?.playerNode {
                if (!(self is AI)) {
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
            } else if self == gameScene?.playerNode2 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[0][0] == 0 {
                        movespeed_2 = BASE_MOVESPEED_2
                    } else if otherPlayerBlessings[0][0] >= 9 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.1
                    } else if otherPlayerBlessings[0][0] >= 8 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.075
                    } else if otherPlayerBlessings[0][0] >= 3 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.05
                    } else if otherPlayerBlessings[0][0] >= 2 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.025
                    } else if otherPlayerBlessings[0][0] >= 1 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[0][1] == 0 {
                        power_2 = BASE_POWER_2
                    } else if otherPlayerBlessings[0][1] >= 9 {
                        power_2 = BASE_POWER_2 * 1.1
                    } else if otherPlayerBlessings[0][1] >= 8 {
                        power_2 = BASE_POWER_2 * 1.075
                    } else if otherPlayerBlessings[0][1] >= 3 {
                        power_2 = BASE_POWER_2 * 1.05
                    } else if otherPlayerBlessings[0][1] >= 2 {
                        power_2 = BASE_POWER_2 * 1.025
                    } else if otherPlayerBlessings[0][1] >= 1 {
                        power_2 = BASE_POWER_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 5 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 10
                    } else if otherPlayerBlessings[0][2] == 4 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance_2 = BASE_RESISTANCE_2
                    } else if otherPlayerBlessings[0][2] >= 9 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.1
                    } else if otherPlayerBlessings[0][2] >= 8 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.075
                    } else if otherPlayerBlessings[0][2] >= 3 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.05
                    } else if otherPlayerBlessings[0][2] >= 2 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.025
                    } else if otherPlayerBlessings[0][2] >= 1 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[0][2] >= 7 {
                        maxHP_2 = BASE_MAX_HP_2 + 50
                    } else if otherPlayerBlessings[0][2] == 6 {
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
            } else if self == gameScene?.playerNode3 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[1][0] == 0 {
                        movespeed_2 = BASE_MOVESPEED_2
                    } else if otherPlayerBlessings[1][0] >= 9 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.1
                    } else if otherPlayerBlessings[1][0] >= 8 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.075
                    } else if otherPlayerBlessings[1][0] >= 3 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.05
                    } else if otherPlayerBlessings[1][0] >= 2 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.025
                    } else if otherPlayerBlessings[1][0] >= 1 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[1][1] == 0 {
                        power_2 = BASE_POWER_2
                    } else if otherPlayerBlessings[1][1] >= 9 {
                        power_2 = BASE_POWER_2 * 1.1
                    } else if otherPlayerBlessings[1][1] >= 8 {
                        power_2 = BASE_POWER_2 * 1.075
                    } else if otherPlayerBlessings[1][1] >= 3 {
                        power_2 = BASE_POWER_2 * 1.05
                    } else if otherPlayerBlessings[1][1] >= 2 {
                        power_2 = BASE_POWER_2 * 1.025
                    } else if otherPlayerBlessings[1][1] >= 1 {
                        power_2 = BASE_POWER_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 5 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 10
                    } else if otherPlayerBlessings[1][2] == 4 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 5
                    }
                    
                    if otherPlayerBlessings[1][2] == 0 {
                        resistance_2 = BASE_RESISTANCE_2
                    } else if otherPlayerBlessings[1][2] >= 9 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.1
                    } else if otherPlayerBlessings[1][2] >= 8 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.075
                    } else if otherPlayerBlessings[1][2] >= 3 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.05
                    } else if otherPlayerBlessings[1][2] >= 2 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.025
                    } else if otherPlayerBlessings[1][2] >= 1 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[1][2] >= 7 {
                        maxHP_2 = BASE_MAX_HP_2 + 50
                    } else if otherPlayerBlessings[1][2] == 6 {
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
            } else if self == gameScene?.playerNode4 {
                if (!(self is AI)) {
                    if otherPlayerBlessings[2][0] == 0 {
                        movespeed_2 = BASE_MOVESPEED_2
                    } else if otherPlayerBlessings[2][0] >= 9 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.1
                    } else if otherPlayerBlessings[2][0] >= 8 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.075
                    } else if otherPlayerBlessings[2][0] >= 3 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.05
                    } else if otherPlayerBlessings[2][0] >= 2 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.025
                    } else if otherPlayerBlessings[2][0] >= 1 {
                        movespeed_2 = BASE_MOVESPEED_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[2][1] == 0 {
                        power_2 = BASE_POWER_2
                    } else if otherPlayerBlessings[2][1] >= 9 {
                        power_2 = BASE_POWER_2 * 1.1
                    } else if otherPlayerBlessings[2][1] >= 8 {
                        power_2 = BASE_POWER_2 * 1.075
                    } else if otherPlayerBlessings[2][1] >= 3 {
                        power_2 = BASE_POWER_2 * 1.05
                    } else if otherPlayerBlessings[2][1] >= 2 {
                        power_2 = BASE_POWER_2 * 1.025
                    } else if otherPlayerBlessings[2][1] >= 1 {
                        power_2 = BASE_POWER_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 5 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 10
                    } else if otherPlayerBlessings[2][2] == 4 {
                        BASE_RESISTANCE_2 = BASE_RESISTANCE_2 + 5
                    }
                    
                    if otherPlayerBlessings[0][2] == 0 {
                        resistance_2 = BASE_RESISTANCE_2
                    } else if otherPlayerBlessings[2][2] >= 9 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.1
                    } else if otherPlayerBlessings[2][2] >= 8 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.075
                    } else if otherPlayerBlessings[2][2] >= 3 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.05
                    } else if otherPlayerBlessings[2][2] >= 2 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.025
                    } else if otherPlayerBlessings[2][2] >= 1 {
                        resistance_2 = BASE_RESISTANCE_2 * 1.01
                    }
                    
                    if otherPlayerBlessings[2][2] >= 7 {
                        maxHP_2 = BASE_MAX_HP_2 + 50
                    } else if otherPlayerBlessings[2][2] == 6 {
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
        if abs(self.position.x - gameScene!.playerNode.position.x) <= gameScene!.playerNode.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameScene!.playerNode.position.y) <= gameScene!.playerNode.halfHeight! + 5 + self.halfHeight! && gameScene!.playerNode != self {
            if self.position.x > gameScene!.playerNode.position.x && self.xScale == -1 {
                gameScene!.playerNode.takeDamage(damage, direction: self.xScale)
            } else if self.position.x < gameScene!.playerNode.position.x && self.xScale == 1 {
                gameScene!.playerNode.takeDamage(damage, direction: self.xScale)
            }
        }
        
        if !gameScene!.multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 1 {
            if abs(self.position.x - gameScene!.playerNode2.position.x) <= gameScene!.playerNode2.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameScene!.playerNode2.position.y) <= gameScene!.playerNode2.halfHeight! + 5 + self.halfHeight! && gameScene!.playerNode2 != self{
                if self.position.x > gameScene!.playerNode2.position.x && self.xScale == -1 {
                    gameScene!.playerNode2.takeDamage(damage, direction: self.xScale)
                } else if self.position.x < gameScene!.playerNode2.position.x && self.xScale == 1 {
                    gameScene!.playerNode2.takeDamage(damage, direction: self.xScale)
                }
            }
        }
        
        if !gameScene!.multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 2 {
            if abs(self.position.x - gameScene!.playerNode3.position.x) <= gameScene!.playerNode3.halfWidth! + self.halfWidth! + 15 && abs(self.position.y - gameScene!.playerNode3.position.y) <= gameScene!.playerNode3.halfHeight! + 5 + self.halfHeight! && gameScene!.playerNode3 != self {
                if self.position.x > gameScene!.playerNode3.position.x && self.xScale == -1 {
                    gameScene!.playerNode3.takeDamage(damage, direction: self.xScale)
                } else if self.position.x < gameScene!.playerNode3.position.x && self.xScale == 1 {
                    gameScene!.playerNode3.takeDamage(damage, direction: self.xScale)
                }
            }
        }
        
        if !gameScene!.multiplayerGame || appDelegate.mpcHandler.session.connectedPeers.count == 3 {
            if abs(self.position.x - gameScene!.playerNode4.position.x) <= gameScene!.playerNode4.halfWidth! + self.halfWidth! + 5 && abs(self.position.y - gameScene!.playerNode4.position.y) <= gameScene!.playerNode4.halfHeight! + 5 + self.halfHeight! && gameScene!.playerNode4 != self {
                if self.position.x > gameScene!.playerNode4.position.x && self.xScale == -1 {
                    gameScene!.playerNode4.takeDamage(damage, direction: self.xScale)
                } else if self.position.x < gameScene!.playerNode4.position.x && self.xScale == 1 {
                    gameScene!.playerNode4.takeDamage(damage, direction: self.xScale)
                }
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
        
        self.parent?.run(SKAction.wait(forDuration: 1.5),completion:{
            self.returnToIdle()
        })
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
            self.parent!.run(SKAction.wait(forDuration: 7),completion:{
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
        
        self.parent?.run(SKAction.wait(forDuration: 1.5),completion:{
            self.returnToIdle()
        })
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
            self.parent!.run(SKAction.wait(forDuration: 5),completion:{
                self.movespeed = self.BASE_MOVESPEED
            })
        } else if characterName == "Sarah" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        } else if characterName == "Cog" {
            let damage:CGFloat = 15 + (power * 0.5)
            applyDamage(damage)
        }
        
        self.parent?.run(SKAction.wait(forDuration: 2),completion:{
            self.returnToIdle()
        })
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
                zombie_boy.physicsBody!.contactTestBitMask = 0
                zombie_boy.physicsBody!.categoryBitMask = ProjectileCategory
                zombie_boy.physicsBody!.collisionBitMask = WorldCategory
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
                zombie_girl.physicsBody!.contactTestBitMask = 0
                zombie_girl.physicsBody!.categoryBitMask = ProjectileCategory
                zombie_girl.physicsBody!.collisionBitMask = WorldCategory
                self.parent!.addChild(zombie_girl)
            } else if characterName == "Plum" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (15 * self.xScale), dy: 0))
            } else if characterName == "Rosetta" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (15 * self.xScale), dy: 0))
            } else if characterName == "Sarah" {
                let bullet = Projectile(imageNamed: "Bullet")
                bullet.setUp(damage, direction: self.xScale, owner: self.player)
                bullet.position.y = self.position.y
                bullet.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(bullet)
                bullet.physicsBody!.applyImpulse(CGVector(dx: (35 * self.xScale), dy: 0))
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
                    dog.physicsBody!.categoryBitMask = SummonedCategory
                    dog.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                    self.parent!.addChild(dog)
                    self.parent!.run(SKAction.wait(forDuration: 2),completion:{
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
                    cat.physicsBody!.categoryBitMask = SummonedCategory
                    cat.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
                    self.parent!.addChild(cat)
                    self.parent!.run(SKAction.wait(forDuration: 2),completion:{
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
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.confirmPlayerStats()
        }
    }
    
    func returnToIdle() {
        if self.physicsBody?.velocity.dx == 0 {
            self.removeAllActions()
            self.run(animateIdle!)
        }
    }
    
    func playerMovement(mod:CGFloat) {
        if playerMovement == "Move_Left" {
            self.physicsBody?.velocity = CGVector(dx: -self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
        } else if playerMovement == "Move_Right" {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
        }
    }
    
    func checkBlockUnder() {
        let tile = self.returnBlockBelow()
        
        if tile == "Dirt" {
            playerMovement(mod: 1.0)
            self.resetJumpsCount()
            if playerMovement == "" {
                self.physicsBody?.velocity.dx = 0
            }
            
            if self.isResting && self.allowedToRecover {
                self.recovered()
            }
        } else if tile == "Water" {
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            self.physicsBody?.affectedByGravity = false
            playerMovement(mod: 0.4)
            self.resetJumpsCount()
        } else {
            self.physicsBody?.affectedByGravity = true
            playerMovement(mod: 0.75)
        }
        
        if self.isResting {
            self.playerMovement = ""
            self.playerLastMovement = ""
        }
        
        if self.isResting && self.currentHP >= self.maxHP {
            self.recovered()
        }
        
        if deathMode == 2 && (tile == "Water" && self.isResting) && !isDead {
            self.isDead = true
            self.parent?.run(SKAction.wait(forDuration: 0.2),completion:{
                self.removeFromParent()
                self.removeAllChildren()
                self.removeAllActions()
            })
        } else if deathMode == 1 && self.lives <= 0 && self.isResting && !isDead {
            self.isDead = true
            self.parent?.run(SKAction.wait(forDuration: 0.2),completion:{
                self.removeFromParent()
                self.removeAllChildren()
                self.removeAllActions()
            })
        }
    }
    
    func returnBlockBelow() -> String {
        let position = CGPoint(x: self.position.x, y: self.position.y - self.size.height/2)
        let column = gameScene?.tileMapNode?.tileColumnIndex(fromPosition: position)
        let row = gameScene?.tileMapNode?.tileRowIndex(fromPosition: position)
        let tile = gameScene?.tileMapNode?.tileGroup(atColumn: column!, row: row!)
        var blockBelow = ""
        
        if tile?.name == "Water" {
            blockBelow = "Water"
        } else if tile?.name == "Dirt" {
            blockBelow = "Dirt"
        }
        
        return blockBelow
    }
    
    func isSkillReady_1(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_1 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_2(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_2 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_3(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_3 > 0 {
            skillReady = true
        }
        
        return skillReady
    }
    
    func performFrameBasedUpdates(_ currentTime:TimeInterval) {
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
        
        if self.playerAction != self.playerLastAction {
            if self.playerAction == "Jump" && self.currentJumps < self.maxJumps {
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.movespeed * 0.25))
                self.currentJumps += 1
            } else if self.playerAction == "Skill_1" && self.isSkillReady_1(currentTime) {
                self.skill_1_Last_Used = currentTime
                self.skillCurrentCharges_1 -= 1
                self.doSkill_1()
            } else if self.playerAction == "Skill_2" && self.isSkillReady_2(currentTime) {
                self.skill_2_Last_Used = currentTime
                self.skillCurrentCharges_2 -= 1
                self.doSkill_2()
            } else if self.playerAction == "Skill_3" && self.isSkillReady_3(currentTime) {
                self.skill_3_Last_Used = currentTime
                self.skillCurrentCharges_3 -= 1
                self.doSkill_3()
            }
        }
    }
    
    func playerAnimations(_ currentTime: TimeInterval) {
        if !isResting {
            if playerAction != playerLastAction || playerMovement != playerLastMovement {
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
                
                if playerAction == "" && playerMovement == "" {
                    self.removeAllActions()
                    self.run(self.animateIdle!)
                } else if playerAction == "Jump" && self.currentJumps < self.maxJumps {
                    self.run((self.animateJump)!)
                } else if playerAction == "Skill_1" && isSkillReady_1(currentTime) {
                    self.run(self.animateSkill_1!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_1" && self.playerAction == "Skill_1" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_1" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.removeAllActions()
                            self.run(self.animateIdle!)
                        }
                    })
                } else if playerAction == "Skill_2" && isSkillReady_2(currentTime) {
                    self.run((self.animateSkill_2)!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_2" && self.playerAction == "Skill_2" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_2" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.removeAllActions()
                            self.run((self.animateIdle)!)
                        }
                    })
                } else if playerAction == "Skill_3" && isSkillReady_3(currentTime) {
                    self.run((self.animateSkill_3)!)
                    self.run(SKAction.wait(forDuration: 0.75),completion:{
                        if self.playerLastAction == "Skill_3" && self.playerAction == "Skill_3" {
                            self.playerAction = ""
                            self.playerLastAction = ""
                        } else if self.playerLastAction == "Skill_3" {
                            self.playerLastAction = ""
                        }
                        
                        if self.playerMovement == ""  {
                            self.removeAllActions()
                            self.run((self.animateIdle)!)
                        }
                    })
                }
            }
        }
    }
    
    func followNaturalRegen(_ currentTime:TimeInterval) {
        self.playerLastAction = self.playerAction
        self.playerLastMovement = self.playerMovement
        
        if currentTime - lastRegenTime >= 0.5 && !isDead {
            if self.currentHP < self.maxHP {
                if self.isResting {
                    self.currentHP += (self.maxHP/6)
                } else {
                    self.currentHP += self.hpRegen
                }
                
                if self.currentHP > self.maxHP {
                    self.currentHP = self.maxHP
                }
            }
            lastRegenTime = currentTime
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
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.confirmPlayerStats()
        }
    }
    
}
