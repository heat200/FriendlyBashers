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
    
    var itemHeld = ""
    var itemInUse = ""
    
    var usedLimbo = false
    
    var childCount = 0
    
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
    
    var gemsCollected = 0
    
    var lives = 2
    var currentTimeCopy:Double = 0
    var lastRegenTime:Double = 0
    var lastBlessingTime:Double = 0
    
    var soundJump:SKAudioNode?
    var soundPickup:SKAudioNode?
    var soundSlide:SKAudioNode?
    var soundShoot:SKAudioNode?
    var soundSlash:SKAudioNode?
    var soundSummon:SKAudioNode?
    var soundBuff:SKAudioNode?
    
    var CharAtlas:SKTextureAtlas!
    
    func setUp(_ name:String) {
        self.zPosition = charLayer
        
        let jumpSound = SKAudioNode(fileNamed: "Jumping_fins.wav")
        jumpSound.autoplayLooped = false
        jumpSound.isPositional = true
        self.addChild(jumpSound)
        jumpSound.run(SKAction.stop())
        soundJump = jumpSound
        
        let pickupSound = SKAudioNode(fileNamed: "Pickup_fins.wav")
        pickupSound.autoplayLooped = false
        pickupSound.isPositional = true
        self.addChild(pickupSound)
        pickupSound.run(SKAction.stop())
        soundPickup = pickupSound
        
        let slideSound = SKAudioNode(fileNamed: "Slide_fins.wav")
        slideSound.autoplayLooped = false
        slideSound.isPositional = true
        self.addChild(slideSound)
        slideSound.run(SKAction.stop())
        soundSlide = slideSound
        
        if characterName == "Sarah" {
            let shootSound = SKAudioNode(fileNamed: "Shoot_fins.wav")
            shootSound.autoplayLooped = false
            shootSound.isPositional = true
            self.addChild(shootSound)
            shootSound.run(SKAction.stop())
            soundShoot = shootSound
        } else {
            let shootSound = SKAudioNode(fileNamed: "Throw_fins.wav")
            shootSound.autoplayLooped = false
            shootSound.isPositional = true
            self.addChild(shootSound)
            shootSound.run(SKAction.stop())
            soundShoot = shootSound
        }
        
        let slashSound = SKAudioNode(fileNamed: "Slash_fins.wav")
        slashSound.autoplayLooped = false
        slashSound.isPositional = true
        self.addChild(slashSound)
        slashSound.run(SKAction.stop())
        soundSlash = slashSound
        
        let summonSound = SKAudioNode(fileNamed: "Summon_fins.wav")
        summonSound.autoplayLooped = false
        summonSound.isPositional = true
        self.addChild(summonSound)
        summonSound.run(SKAction.stop())
        soundSummon = summonSound
        
        let buffSound = SKAudioNode(fileNamed: "Buff_fins.wav")
        buffSound.autoplayLooped = false
        buffSound.isPositional = true
        self.addChild(buffSound)
        buffSound.run(SKAction.stop())
        soundBuff = buffSound
        
        halfHeight = self.size.height/2
        halfWidth = self.size.width/2
        
        if characterForm == "" {
            animateFaint = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Faint_1"),self.CharAtlas.textureNamed(name + "_Faint_2"),self.CharAtlas.textureNamed(name + "_Faint_3"),self.CharAtlas.textureNamed(name + "_Faint_4"),self.CharAtlas.textureNamed(name + "_Faint_5"),self.CharAtlas.textureNamed(name + "_Faint_6"),self.CharAtlas.textureNamed(name + "_Faint_7"),self.CharAtlas.textureNamed(name + "_Faint_8"),self.CharAtlas.textureNamed(name + "_Faint_9"),self.CharAtlas.textureNamed(name + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if characterForm == "Boy" || characterForm == "Girl" {
            animateFaint = SKAction.animate(with: [self.CharAtlas.textureNamed(name + characterForm + "_Faint_1"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_2"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_3"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_4"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_5"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_6"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_7"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_8"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_9"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_10"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_11"),self.CharAtlas.textureNamed(name + characterForm + "_Faint_12")], timePerFrame: 0.0625,resize:true,restore:true)
        } else if characterForm == "Cat" || characterForm == "Dog" {
            animateFaint = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Faint_1"),self.CharAtlas.textureNamed(characterForm + "_Faint_2"),self.CharAtlas.textureNamed(characterForm + "_Faint_3"),self.CharAtlas.textureNamed(characterForm + "_Faint_4"),self.CharAtlas.textureNamed(characterForm + "_Faint_5"),self.CharAtlas.textureNamed(characterForm + "_Faint_6"),self.CharAtlas.textureNamed(characterForm + "_Faint_7"),self.CharAtlas.textureNamed(characterForm + "_Faint_8"),self.CharAtlas.textureNamed(characterForm + "_Faint_9"),self.CharAtlas.textureNamed(characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
        
        if name == "Jack-O" {
            characterName = name
            BASE_MAX_HP = 400
            BASE_POWER = 20
            BASE_RESISTANCE = 40
            BASE_MOVESPEED = 375
            BASE_MAX_JUMPS = 8
            
            BASE_SKILL_COOLDOWN_1 = 0
            BASE_SKILL_COOLDOWN_2 = 6
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 0
            BASE_SKILL_MAX_CHARGES_2 = 4
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            if characterForm == "" {
                animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
                
                animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Run_1"),self.CharAtlas.textureNamed(name + "_Run_2"),self.CharAtlas.textureNamed(name + "_Run_3"),self.CharAtlas.textureNamed(name + "_Run_4"),self.CharAtlas.textureNamed(name + "_Run_5"),self.CharAtlas.textureNamed(name + "_Run_6"),self.CharAtlas.textureNamed(name + "_Run_7"),self.CharAtlas.textureNamed(name + "_Run_8")], timePerFrame: 0.0625,resize:true,restore:true))
                
                animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
                
                animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
                
                animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slide_1"),self.CharAtlas.textureNamed(name + "_Slide_2"),self.CharAtlas.textureNamed(name + "_Slide_3"),self.CharAtlas.textureNamed(name + "_Slide_4"),self.CharAtlas.textureNamed(name + "_Slide_5"),self.CharAtlas.textureNamed(name + "_Slide_6"),self.CharAtlas.textureNamed(name + "_Slide_7"),self.CharAtlas.textureNamed(name + "_Slide_8"),self.CharAtlas.textureNamed(name + "_Slide_9"),self.CharAtlas.textureNamed(name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
                
            }
        } else if name == "Plum" {
            characterName = name
            BASE_MAX_HP = 225
            BASE_POWER = 50
            BASE_RESISTANCE = 35
            BASE_MOVESPEED = 400
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Run_1"),self.CharAtlas.textureNamed(name + "_Run_2"),self.CharAtlas.textureNamed(name + "_Run_3"),self.CharAtlas.textureNamed(name + "_Run_4"),self.CharAtlas.textureNamed(name + "_Run_5"),self.CharAtlas.textureNamed(name + "_Run_6"),self.CharAtlas.textureNamed(name + "_Run_7"),self.CharAtlas.textureNamed(name + "_Run_8"),self.CharAtlas.textureNamed(name + "_Run_9"),self.CharAtlas.textureNamed(name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Throw_1"),self.CharAtlas.textureNamed(name + "_Throw_2"),self.CharAtlas.textureNamed(name + "_Throw_3"),self.CharAtlas.textureNamed(name + "_Throw_4"),self.CharAtlas.textureNamed(name + "_Throw_5"),self.CharAtlas.textureNamed(name + "_Throw_6"),self.CharAtlas.textureNamed(name + "_Throw_7"),self.CharAtlas.textureNamed(name + "_Throw_8"),self.CharAtlas.textureNamed(name + "_Throw_9"),self.CharAtlas.textureNamed(name + "_Throw_10")], timePerFrame: 0.015,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slash_1"),self.CharAtlas.textureNamed(name + "_Slash_2"),self.CharAtlas.textureNamed(name + "_Slash_3"),self.CharAtlas.textureNamed(name + "_Slash_4"),self.CharAtlas.textureNamed(name + "_Slash_5"),self.CharAtlas.textureNamed(name + "_Slash_6"),self.CharAtlas.textureNamed(name + "_Slash_7"),self.CharAtlas.textureNamed(name + "_Slash_8"),self.CharAtlas.textureNamed(name + "_Slash_9"),self.CharAtlas.textureNamed(name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slide_1"),self.CharAtlas.textureNamed(name + "_Slide_2"),self.CharAtlas.textureNamed(name + "_Slide_3"),self.CharAtlas.textureNamed(name + "_Slide_4"),self.CharAtlas.textureNamed(name + "_Slide_5"),self.CharAtlas.textureNamed(name + "_Slide_6"),self.CharAtlas.textureNamed(name + "_Slide_7"),self.CharAtlas.textureNamed(name + "_Slide_8"),self.CharAtlas.textureNamed(name + "_Slide_9"),self.CharAtlas.textureNamed(name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Rosetta" {
            characterName = name
            BASE_MAX_HP = 120
            BASE_POWER = 60
            BASE_RESISTANCE = 35
            BASE_MOVESPEED = 525
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.8
            BASE_SKILL_COOLDOWN_2 = 1.5
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Run_1"),self.CharAtlas.textureNamed(name + "_Run_2"),self.CharAtlas.textureNamed(name + "_Run_3"),self.CharAtlas.textureNamed(name + "_Run_4"),self.CharAtlas.textureNamed(name + "_Run_5"),self.CharAtlas.textureNamed(name + "_Run_6"),self.CharAtlas.textureNamed(name + "_Run_7"),self.CharAtlas.textureNamed(name + "_Run_8"),self.CharAtlas.textureNamed(name + "_Run_9"),self.CharAtlas.textureNamed(name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Throw_1"),self.CharAtlas.textureNamed(name + "_Throw_2"),self.CharAtlas.textureNamed(name + "_Throw_3"),self.CharAtlas.textureNamed(name + "_Throw_4"),self.CharAtlas.textureNamed(name + "_Throw_5"),self.CharAtlas.textureNamed(name + "_Throw_6"),self.CharAtlas.textureNamed(name + "_Throw_7"),self.CharAtlas.textureNamed(name + "_Throw_8"),self.CharAtlas.textureNamed(name + "_Throw_9"),self.CharAtlas.textureNamed(name + "_Throw_10")], timePerFrame: 0.015,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slash_1"),self.CharAtlas.textureNamed(name + "_Slash_2"),self.CharAtlas.textureNamed(name + "_Slash_3"),self.CharAtlas.textureNamed(name + "_Slash_4"),self.CharAtlas.textureNamed(name + "_Slash_5"),self.CharAtlas.textureNamed(name + "_Slash_6"),self.CharAtlas.textureNamed(name + "_Slash_7"),self.CharAtlas.textureNamed(name + "_Slash_8"),self.CharAtlas.textureNamed(name + "_Slash_9"),self.CharAtlas.textureNamed(name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slide_1"),self.CharAtlas.textureNamed(name + "_Slide_2"),self.CharAtlas.textureNamed(name + "_Slide_3"),self.CharAtlas.textureNamed(name + "_Slide_4"),self.CharAtlas.textureNamed(name + "_Slide_5"),self.CharAtlas.textureNamed(name + "_Slide_6"),self.CharAtlas.textureNamed(name + "_Slide_7"),self.CharAtlas.textureNamed(name + "_Slide_8"),self.CharAtlas.textureNamed(name + "_Slide_9"),self.CharAtlas.textureNamed(name + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Silva" {
            characterName = name
            BASE_MAX_HP = 750
            BASE_POWER = 10
            BASE_RESISTANCE = 50
            BASE_MOVESPEED = 375
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 0.9
            BASE_SKILL_COOLDOWN_2 = 12.5
            BASE_SKILL_COOLDOWN_3 = 8
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 1
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Run_1"),self.CharAtlas.textureNamed(name + "_Run_2"),self.CharAtlas.textureNamed(name + "_Run_3"),self.CharAtlas.textureNamed(name + "_Run_4"),self.CharAtlas.textureNamed(name + "_Run_5"),self.CharAtlas.textureNamed(name + "_Run_6"),self.CharAtlas.textureNamed(name + "_Run_7"),self.CharAtlas.textureNamed(name + "_Run_8"),self.CharAtlas.textureNamed(name + "_Run_9"),self.CharAtlas.textureNamed(name + "_Run_10")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slash_1"),self.CharAtlas.textureNamed(name + "_Slash_2"),self.CharAtlas.textureNamed(name + "_Slash_3"),self.CharAtlas.textureNamed(name + "_Slash_4"),self.CharAtlas.textureNamed(name + "_Slash_5"),self.CharAtlas.textureNamed(name + "_Slash_6"),self.CharAtlas.textureNamed(name + "_Slash_7"),self.CharAtlas.textureNamed(name + "_Slash_8"),self.CharAtlas.textureNamed(name + "_Slash_9"),self.CharAtlas.textureNamed(name + "_Slash_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.035,resize:true,restore:true)
        } else if name == "Sarah" {
            characterName = name
            BASE_MAX_HP = 300
            BASE_POWER = 30
            BASE_RESISTANCE = 35
            BASE_MOVESPEED = 395
            BASE_MAX_JUMPS = 2
            
            BASE_SKILL_COOLDOWN_1 = 1.00
            BASE_SKILL_COOLDOWN_2 = 0.85
            BASE_SKILL_COOLDOWN_3 = 1.75
            
            BASE_SKILL_MAX_CHARGES_1 = 1
            BASE_SKILL_MAX_CHARGES_2 = 3
            BASE_SKILL_MAX_CHARGES_3 = 1
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Run_1"),self.CharAtlas.textureNamed(name + "_Run_2"),self.CharAtlas.textureNamed(name + "_Run_3"),self.CharAtlas.textureNamed(name + "_Run_4"),self.CharAtlas.textureNamed(name + "_Run_5"),self.CharAtlas.textureNamed(name + "_Run_6"),self.CharAtlas.textureNamed(name + "_Run_7"),self.CharAtlas.textureNamed(name + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Jump_1"),self.CharAtlas.textureNamed(name + "_Jump_2"),self.CharAtlas.textureNamed(name + "_Jump_3"),self.CharAtlas.textureNamed(name + "_Jump_4"),self.CharAtlas.textureNamed(name + "_Jump_5"),self.CharAtlas.textureNamed(name + "_Jump_6"),self.CharAtlas.textureNamed(name + "_Jump_7"),self.CharAtlas.textureNamed(name + "_Jump_8"),self.CharAtlas.textureNamed(name + "_Jump_9"),self.CharAtlas.textureNamed(name + "_Jump_10")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slash_1"),self.CharAtlas.textureNamed(name + "_Slash_2"),self.CharAtlas.textureNamed(name + "_Slash_3"),self.CharAtlas.textureNamed(name + "_Slash_4"),self.CharAtlas.textureNamed(name + "_Slash_5"),self.CharAtlas.textureNamed(name + "_Slash_6"),self.CharAtlas.textureNamed(name + "_Slash_7")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Throw_1"),self.CharAtlas.textureNamed(name + "_Throw_2"),self.CharAtlas.textureNamed(name + "_Throw_3")], timePerFrame: 0.09,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Slide_1"),self.CharAtlas.textureNamed(name + "_Slide_2"),self.CharAtlas.textureNamed(name + "_Slide_3"),self.CharAtlas.textureNamed(name + "_Slide_4"),self.CharAtlas.textureNamed(name + "_Slide_5")], timePerFrame: 0.065,resize:true,restore:true)
        } else if name == "Cog" {
            characterName = name
            
            BASE_MAX_HP = 160
            BASE_MAX_HP_2 = 240
            BASE_POWER = 5
            BASE_POWER_2 = 15
            BASE_RESISTANCE = 20
            BASE_RESISTANCE_2 = 20
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
                    
                    if otherPlayerBlessings[2][2] == 0 {
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
            } else {
                movespeed_2 = BASE_MOVESPEED_2
                power_2 = BASE_POWER_2
                resistance_2 = BASE_RESISTANCE_2
                maxHP_2 = BASE_MAX_HP_2
                maxJumps = BASE_MAX_JUMPS
                hpRegen = BASE_HP_REGEN
            }
            
            currentHP_2 = maxHP_2
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Idle_1"),self.CharAtlas.textureNamed(characterForm + "_Idle_2"),self.CharAtlas.textureNamed(characterForm + "_Idle_3"),self.CharAtlas.textureNamed(characterForm + "_Idle_4"),self.CharAtlas.textureNamed(characterForm + "_Idle_5"),self.CharAtlas.textureNamed(characterForm + "_Idle_6"),self.CharAtlas.textureNamed(characterForm + "_Idle_7"),self.CharAtlas.textureNamed(characterForm + "_Idle_8"),self.CharAtlas.textureNamed(characterForm + "_Idle_9"),self.CharAtlas.textureNamed(characterForm + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Run_1"),self.CharAtlas.textureNamed(characterForm + "_Run_2"),self.CharAtlas.textureNamed(characterForm + "_Run_3"),self.CharAtlas.textureNamed(characterForm + "_Run_4"),self.CharAtlas.textureNamed(characterForm + "_Run_5"),self.CharAtlas.textureNamed(characterForm + "_Run_6"),self.CharAtlas.textureNamed(characterForm + "_Run_7"),self.CharAtlas.textureNamed(characterForm + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Jump_1"),self.CharAtlas.textureNamed(characterForm + "_Jump_2"),self.CharAtlas.textureNamed(characterForm + "_Jump_3"),self.CharAtlas.textureNamed(characterForm + "_Jump_4"),self.CharAtlas.textureNamed(characterForm + "_Jump_5"),self.CharAtlas.textureNamed(characterForm + "_Jump_6"),self.CharAtlas.textureNamed(characterForm + "_Jump_7"),self.CharAtlas.textureNamed(characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Jump_1"),self.CharAtlas.textureNamed(characterForm + "_Jump_2"),self.CharAtlas.textureNamed(characterForm + "_Jump_3"),self.CharAtlas.textureNamed(characterForm + "_Jump_4"),self.CharAtlas.textureNamed(characterForm + "_Jump_5"),self.CharAtlas.textureNamed(characterForm + "_Jump_6"),self.CharAtlas.textureNamed(characterForm + "_Jump_7"),self.CharAtlas.textureNamed(characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Slide_1"),self.CharAtlas.textureNamed(characterForm + "_Slide_2"),self.CharAtlas.textureNamed(characterForm + "_Slide_3"),self.CharAtlas.textureNamed(characterForm + "_Slide_4"),self.CharAtlas.textureNamed(characterForm + "_Slide_5"),self.CharAtlas.textureNamed(characterForm + "_Slide_6"),self.CharAtlas.textureNamed(characterForm + "_Slide_7"),self.CharAtlas.textureNamed(characterForm + "_Slide_8"),self.CharAtlas.textureNamed(characterForm + "_Slide_9"),self.CharAtlas.textureNamed(characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Slide_1"),self.CharAtlas.textureNamed(characterForm + "_Slide_2"),self.CharAtlas.textureNamed(characterForm + "_Slide_3"),self.CharAtlas.textureNamed(characterForm + "_Slide_4"),self.CharAtlas.textureNamed(characterForm + "_Slide_5"),self.CharAtlas.textureNamed(characterForm + "_Slide_6"),self.CharAtlas.textureNamed(characterForm + "_Slide_7"),self.CharAtlas.textureNamed(characterForm + "_Slide_8"),self.CharAtlas.textureNamed(characterForm + "_Slide_9"),self.CharAtlas.textureNamed(characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
        
        if characterForm == "Boy" {
            maxHP = 20 + (maxHP * 0.1)
            currentHP = maxHP
            power = (power * 0.01)
            resistance = (resistance * 0.6)
            movespeed = (movespeed * 0.5)
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_10"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_11"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_12"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_13"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_14"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_15")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_10")], timePerFrame: 0.09,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_8")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateFaint = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        } else if characterForm == "Girl" {
            maxHP = 20 + (maxHP * 0.05)
            currentHP = maxHP
            power = (power * 0.005)
            resistance = (resistance * 0.2)
            movespeed = (movespeed * 1.0)
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_10"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_11"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_12"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_13"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_14"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Idle_15")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Run_10")], timePerFrame: 0.09,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Attack_8")], timePerFrame: 0.035,resize:true,restore:true)
            
            animateFaint = SKAction.animate(with: [self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_1"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_2"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_3"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_4"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_5"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_6"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_7"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_8"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_9"),self.CharAtlas.textureNamed(name + "_Zombie_" + characterForm + "_Faint_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
        
        if self == gameScene?.playerNode {
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
        } else if self == gameScene?.playerNode2 {
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
        } else if self == gameScene?.playerNode3 {
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
        } else if self == gameScene?.playerNode4 {
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
        
        currentHP = maxHP
        
        skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1
        skillMaxCharges_2 = BASE_SKILL_MAX_CHARGES_2
        skillMaxCharges_3 = BASE_SKILL_MAX_CHARGES_3
        
        skillCooldown_1 = BASE_SKILL_COOLDOWN_1
        skillCooldown_2 = BASE_SKILL_COOLDOWN_2
        skillCooldown_3 = BASE_SKILL_COOLDOWN_3
        self.applyChargeTimerReductions()
        self.fixMaxCharges()
    }
    
    func resetJumpsCount() {
        currentJumps = 0
    }
    
    func fixMaxCharges() {
        if characterName == "Plum" {
            skillMaxCharges_1 += Int(power/10)
            skillMaxCharges_2 += Int(power/25)
        } else if characterName == "Rosetta" {
            skillMaxCharges_1 += Int(power/10)
            skillMaxCharges_2 += Int(power/25)
        } else if characterName == "Silva" {
            skillMaxCharges_1 += Int(power/25)
        } else if characterName == "Sarah" {
            skillMaxCharges_1 += Int(power/10)
            skillMaxCharges_2 += Int(power/10)
        }
        
        self.setUpAttackBoxes()
    }
    
    func applyChargeTimerReductions() {
        if self == gameScene?.playerNode {
            if chosenMode == "Chaos" {
                skillCooldown_1 = skillCooldown_1 * 0.2
                skillCooldown_2 = skillCooldown_2 * 0.2
                skillCooldown_3 = skillCooldown_3 * 0.2
                movespeed = movespeed * 1.4
            } else if chosenMode == "GemBash" {
                hpRegen += 2.0
            }
            
            if blessingList[chosenBlessing][4] >= 9 {
                skillCooldown_1 = skillCooldown_1 * 0.6
                skillCooldown_2 = skillCooldown_2 * 0.6
                skillCooldown_3 = skillCooldown_3 * 0.6
            } else if blessingList[chosenBlessing][4] >= 8 {
                skillCooldown_1 = skillCooldown_1 * 0.7
                skillCooldown_2 = skillCooldown_2 * 0.7
                skillCooldown_3 = skillCooldown_3 * 0.7
            } else if blessingList[chosenBlessing][4] >= 3 {
                skillCooldown_1 = skillCooldown_1 * 0.8
                skillCooldown_2 = skillCooldown_2 * 0.8
                skillCooldown_3 = skillCooldown_3 * 0.8
            } else if blessingList[chosenBlessing][4] >= 2 {
                skillCooldown_1 = skillCooldown_1 * 0.9
                skillCooldown_2 = skillCooldown_2 * 0.9
                skillCooldown_3 = skillCooldown_3 * 0.9
            } else if blessingList[chosenBlessing][4] >= 1 {
                skillCooldown_1 = skillCooldown_1 * 0.96
                skillCooldown_2 = skillCooldown_2 * 0.96
                skillCooldown_3 = skillCooldown_3 * 0.96
            }
        } else if self == gameScene?.playerNode2 {
            if chosenMode == "Chaos" {
                skillCooldown_1 = skillCooldown_1 * 0.2
                skillCooldown_2 = skillCooldown_2 * 0.2
                skillCooldown_3 = skillCooldown_3 * 0.2
                movespeed = movespeed * 1.4
            } else if chosenMode == "GemBash" {
                hpRegen += 2.0
            }
            
            if otherPlayerBlessings[0][4] >= 9 {
                skillCooldown_1 = skillCooldown_1 * 0.6
                skillCooldown_2 = skillCooldown_2 * 0.6
                skillCooldown_3 = skillCooldown_3 * 0.6
            } else if otherPlayerBlessings[0][4] >= 8 {
                skillCooldown_1 = skillCooldown_1 * 0.7
                skillCooldown_2 = skillCooldown_2 * 0.7
                skillCooldown_3 = skillCooldown_3 * 0.7
            } else if otherPlayerBlessings[0][4] >= 3 {
                skillCooldown_1 = skillCooldown_1 * 0.8
                skillCooldown_2 = skillCooldown_2 * 0.8
                skillCooldown_3 = skillCooldown_3 * 0.8
            } else if otherPlayerBlessings[0][4] >= 2 {
                skillCooldown_1 = skillCooldown_1 * 0.9
                skillCooldown_2 = skillCooldown_2 * 0.9
                skillCooldown_3 = skillCooldown_3 * 0.9
            } else if otherPlayerBlessings[0][4] >= 1 {
                skillCooldown_1 = skillCooldown_1 * 0.96
                skillCooldown_2 = skillCooldown_2 * 0.96
                skillCooldown_3 = skillCooldown_3 * 0.96
            }
        } else if self == gameScene?.playerNode3 {
            if chosenMode == "Chaos" {
                skillCooldown_1 = skillCooldown_1 * 0.2
                skillCooldown_2 = skillCooldown_2 * 0.2
                skillCooldown_3 = skillCooldown_3 * 0.2
                movespeed = movespeed * 1.4
            } else if chosenMode == "GemBash" {
                hpRegen += 2.0
            }
            
            if otherPlayerBlessings[1][4] >= 9 {
                skillCooldown_1 = skillCooldown_1 * 0.6
                skillCooldown_2 = skillCooldown_2 * 0.6
                skillCooldown_3 = skillCooldown_3 * 0.6
            } else if otherPlayerBlessings[1][4] >= 8 {
                skillCooldown_1 = skillCooldown_1 * 0.7
                skillCooldown_2 = skillCooldown_2 * 0.7
                skillCooldown_3 = skillCooldown_3 * 0.7
            } else if otherPlayerBlessings[1][4] >= 3 {
                skillCooldown_1 = skillCooldown_1 * 0.8
                skillCooldown_2 = skillCooldown_2 * 0.8
                skillCooldown_3 = skillCooldown_3 * 0.8
            } else if otherPlayerBlessings[1][4] >= 2 {
                skillCooldown_1 = skillCooldown_1 * 0.9
                skillCooldown_2 = skillCooldown_2 * 0.9
                skillCooldown_3 = skillCooldown_3 * 0.9
            } else if otherPlayerBlessings[1][4] >= 1 {
                skillCooldown_1 = skillCooldown_1 * 0.96
                skillCooldown_2 = skillCooldown_2 * 0.96
                skillCooldown_3 = skillCooldown_3 * 0.96
            }
        } else if self == gameScene?.playerNode4 {
            if chosenMode == "Chaos" {
                skillCooldown_1 = skillCooldown_1 * 0.2
                skillCooldown_2 = skillCooldown_2 * 0.2
                skillCooldown_3 = skillCooldown_3 * 0.2
                movespeed = movespeed * 1.4
            } else if chosenMode == "GemBash" {
                hpRegen += 2.0
            }
            
            if otherPlayerBlessings[2][4] >= 9 {
                skillCooldown_1 = skillCooldown_1 * 0.6
                skillCooldown_2 = skillCooldown_2 * 0.6
                skillCooldown_3 = skillCooldown_3 * 0.6
            } else if otherPlayerBlessings[2][4] >= 8 {
                skillCooldown_1 = skillCooldown_1 * 0.7
                skillCooldown_2 = skillCooldown_2 * 0.7
                skillCooldown_3 = skillCooldown_3 * 0.7
            } else if otherPlayerBlessings[2][4] >= 3 {
                skillCooldown_1 = skillCooldown_1 * 0.8
                skillCooldown_2 = skillCooldown_2 * 0.8
                skillCooldown_3 = skillCooldown_3 * 0.8
            } else if otherPlayerBlessings[2][4] >= 2 {
                skillCooldown_1 = skillCooldown_1 * 0.9
                skillCooldown_2 = skillCooldown_2 * 0.9
                skillCooldown_3 = skillCooldown_3 * 0.9
            } else if otherPlayerBlessings[2][4] >= 1 {
                skillCooldown_1 = skillCooldown_1 * 0.96
                skillCooldown_2 = skillCooldown_2 * 0.96
                skillCooldown_3 = skillCooldown_3 * 0.96
            }
        }
    }
    
    func applyLifeSteal(_ damage:CGFloat) {
        if self == gameScene?.playerNode {
            if blessingList[chosenBlessing][1] >= 7 {
                let hpToHeal = damage * 0.5
                applyHealing(hpToHeal)
            } else if blessingList[chosenBlessing][1] >= 6 {
                let hpToHeal = damage * 0.35
                applyHealing(hpToHeal)
            } else if blessingList[chosenBlessing][1] >= 5 {
                let hpToHeal = damage * 0.2
                applyHealing(hpToHeal)
            } else if blessingList[chosenBlessing][1] >= 4 {
                let hpToHeal = damage * 0.05
                applyHealing(hpToHeal)
            }
        } else if self == gameScene?.playerNode2 {
            if otherPlayerBlessings[0][1] >= 7 {
                let hpToHeal = damage * 0.5
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[0][1] >= 6 {
                let hpToHeal = damage * 0.35
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[0][1] >= 5 {
                let hpToHeal = damage * 0.2
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[0][1] >= 4 {
                let hpToHeal = damage * 0.05
                applyHealing(hpToHeal)
            }
        } else if self == gameScene?.playerNode3 {
            if otherPlayerBlessings[1][1] >= 7 {
                let hpToHeal = damage * 0.5
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[1][1] >= 6 {
                let hpToHeal = damage * 0.35
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[1][1] >= 5 {
                let hpToHeal = damage * 0.2
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[1][1] >= 4 {
                let hpToHeal = damage * 0.05
                applyHealing(hpToHeal)
            }
        } else if self == gameScene?.playerNode4 {
            if otherPlayerBlessings[2][1] >= 7 {
                let hpToHeal = damage * 0.5
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[2][1] >= 6 {
                let hpToHeal = damage * 0.35
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[2][1] >= 5 {
                let hpToHeal = damage * 0.2
                applyHealing(hpToHeal)
            } else if otherPlayerBlessings[2][1] >= 4 {
                let hpToHeal = damage * 0.05
                applyHealing(hpToHeal)
            }
        } else {
            if self.player == gameScene?.playerNode.player {
                if blessingList[chosenBlessing][1] >= 7 {
                    let hpToHeal = damage * 0.5
                    applyHealing(hpToHeal)
                    gameScene?.playerNode.applyHealing(hpToHeal)
                } else if blessingList[chosenBlessing][1] >= 6 {
                    let hpToHeal = damage * 0.35
                    applyHealing(hpToHeal)
                    gameScene?.playerNode.applyHealing(hpToHeal)
                } else if blessingList[chosenBlessing][1] >= 5 {
                    let hpToHeal = damage * 0.2
                    applyHealing(hpToHeal)
                    gameScene?.playerNode.applyHealing(hpToHeal)
                } else if blessingList[chosenBlessing][1] >= 4 {
                    let hpToHeal = damage * 0.05
                    applyHealing(hpToHeal)
                    gameScene?.playerNode.applyHealing(hpToHeal)
                }
            } else if self.player == gameScene?.playerNode2.player {
                if otherPlayerBlessings[0][1] >= 7 {
                    let hpToHeal = damage * 0.5
                    applyHealing(hpToHeal)
                    gameScene?.playerNode2.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[0][1] >= 6 {
                    let hpToHeal = damage * 0.35
                    applyHealing(hpToHeal)
                    gameScene?.playerNode2.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[0][1] >= 5 {
                    let hpToHeal = damage * 0.2
                    applyHealing(hpToHeal)
                    gameScene?.playerNode2.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[0][1] >= 4 {
                    let hpToHeal = damage * 0.05
                    applyHealing(hpToHeal)
                    gameScene?.playerNode2.applyHealing(hpToHeal)
                }
            } else if self.player == gameScene?.playerNode3.player {
                if otherPlayerBlessings[1][1] >= 7 {
                    let hpToHeal = damage * 0.5
                    applyHealing(hpToHeal)
                    gameScene?.playerNode3.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[1][1] >= 6 {
                    let hpToHeal = damage * 0.35
                    applyHealing(hpToHeal)
                    gameScene?.playerNode3.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[1][1] >= 5 {
                    let hpToHeal = damage * 0.2
                    applyHealing(hpToHeal)
                    gameScene?.playerNode3.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[1][1] >= 4 {
                    let hpToHeal = damage * 0.05
                    applyHealing(hpToHeal)
                    gameScene?.playerNode3.applyHealing(hpToHeal)
                }
            } else if self.player == gameScene?.playerNode4.player {
                if otherPlayerBlessings[2][1] >= 7 {
                    let hpToHeal = damage * 0.5
                    applyHealing(hpToHeal)
                    gameScene?.playerNode4.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[2][1] >= 6 {
                    let hpToHeal = damage * 0.35
                    applyHealing(hpToHeal)
                    gameScene?.playerNode4.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[2][1] >= 5 {
                    let hpToHeal = damage * 0.2
                    applyHealing(hpToHeal)
                    gameScene?.playerNode4.applyHealing(hpToHeal)
                } else if otherPlayerBlessings[2][1] >= 4 {
                    let hpToHeal = damage * 0.05
                    applyHealing(hpToHeal)
                    gameScene?.playerNode4.applyHealing(hpToHeal)
                }
            }
        }
    }
    
    func applyPowerSteal(_ player:Character) {
        if self == gameScene?.playerNode {
            if blessingList[chosenBlessing][4] >= 7 {
                let change = player.power * 0.15
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if blessingList[chosenBlessing][4] >= 6 {
                let change = player.power * 0.125
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if blessingList[chosenBlessing][4] >= 5 {
                let change = player.power * 0.1
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if blessingList[chosenBlessing][4] >= 4 {
                let change = player.power * 0.05
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            }
        } else if self == gameScene?.playerNode2 {
            if otherPlayerBlessings[0][4] >= 7 {
                let change = player.power * 0.15
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[0][4] >= 6 {
                let change = player.power * 0.125
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[0][4] >= 5 {
                let change = player.power * 0.1
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[0][4] >= 4 {
                let change = player.power * 0.05
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            }
        } else if self == gameScene?.playerNode3 {
            if otherPlayerBlessings[1][4] >= 7 {
                let change = player.power * 0.15
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[1][4] >= 6 {
                let change = player.power * 0.125
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[1][4] >= 5 {
                let change = player.power * 0.1
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[1][4] >= 4 {
                let change = player.power * 0.05
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            }
        } else if self == gameScene?.playerNode4 {
            if otherPlayerBlessings[2][4] >= 7 {
                let change = player.power * 0.15
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[2][4] >= 6 {
                let change = player.power * 0.125
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[2][4] >= 5 {
                let change = player.power * 0.1
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            } else if otherPlayerBlessings[2][4] >= 4 {
                let change = player.power * 0.05
                self.power += change
                player.power -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.power -= change
                    player.power += change
                })
            }
        } else {
            if self.player == gameScene?.playerNode.player {
                if blessingList[chosenBlessing][4] >= 7 {
                    let change = player.power * 0.15
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if blessingList[chosenBlessing][4] >= 6 {
                    let change = player.power * 0.125
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if blessingList[chosenBlessing][4] >= 5 {
                    let change = player.power * 0.1
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if blessingList[chosenBlessing][4] >= 4 {
                    let change = player.power * 0.05
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                }
            } else if self.player == gameScene?.playerNode2.player {
                if otherPlayerBlessings[0][4] >= 7 {
                    let change = player.power * 0.15
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[0][4] >= 6 {
                    let change = player.power * 0.125
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[0][4] >= 5 {
                    let change = player.power * 0.1
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[0][4] >= 4 {
                    let change = player.power * 0.05
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                }
            } else if self.player == gameScene?.playerNode3.player {
                if otherPlayerBlessings[1][4] >= 7 {
                    let change = player.power * 0.15
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[1][4] >= 6 {
                    let change = player.power * 0.125
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[1][4] >= 5 {
                    let change = player.power * 0.1
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[1][4] >= 4 {
                    let change = player.power * 0.05
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                }
            } else if self.player == gameScene?.playerNode4.player {
                if otherPlayerBlessings[2][4] >= 7 {
                    let change = player.power * 0.15
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[2][4] >= 6 {
                    let change = player.power * 0.125
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[2][4] >= 5 {
                    let change = player.power * 0.1
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                } else if otherPlayerBlessings[2][4] >= 4 {
                    let change = player.power * 0.05
                    self.power += change
                    player.power -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.power -= change
                        player.power += change
                    })
                }
            }
        }
    }
    
    func applyHealing(_ hpToReturn:CGFloat) {
        if self == gameScene?.playerNode {
            if blessingList[chosenBlessing][3] >= 5 {
                self.currentHP += hpToReturn * 1.05
            } else if blessingList[chosenBlessing][3] == 4 {
                self.currentHP += hpToReturn * 1.025
            } else {
                self.currentHP += hpToReturn
            }
        } else if self == gameScene?.playerNode2 {
            if otherPlayerBlessings[0][3] >= 5 {
                self.currentHP += hpToReturn * 1.05
            } else if otherPlayerBlessings[0][3] == 4 {
                self.currentHP += hpToReturn * 1.025
            } else {
                self.currentHP += hpToReturn
            }
        } else if self == gameScene?.playerNode3 {
            if otherPlayerBlessings[1][3] >= 5 {
                self.currentHP += hpToReturn * 1.05
            } else if otherPlayerBlessings[1][3] == 4 {
                self.currentHP += hpToReturn * 1.025
            } else {
                self.currentHP += hpToReturn
            }
        } else if self == gameScene?.playerNode4 {
            if otherPlayerBlessings[2][3] >= 5 {
                self.currentHP += hpToReturn * 1.05
            } else if otherPlayerBlessings[2][3] == 4 {
                self.currentHP += hpToReturn * 1.025
            } else {
                self.currentHP += hpToReturn
            }
        } else {
            if self.player == gameScene?.playerNode.player {
                if blessingList[chosenBlessing][3] >= 5 {
                    self.currentHP += hpToReturn * 1.05
                } else if blessingList[chosenBlessing][3] == 4 {
                    self.currentHP += hpToReturn * 1.025
                } else {
                    self.currentHP += hpToReturn
                }
            } else if self.player == gameScene?.playerNode2.player {
                if otherPlayerBlessings[0][3] >= 5 {
                    self.currentHP += hpToReturn * 1.05
                } else if otherPlayerBlessings[0][3] == 4 {
                    self.currentHP += hpToReturn * 1.025
                } else {
                    self.currentHP += hpToReturn
                }
            } else if self.player == gameScene?.playerNode3.player {
                if otherPlayerBlessings[1][3] >= 5 {
                    self.currentHP += hpToReturn * 1.05
                } else if otherPlayerBlessings[1][3] == 4 {
                    self.currentHP += hpToReturn * 1.025
                } else {
                    self.currentHP += hpToReturn
                }
            } else if self.player == gameScene?.playerNode4.player {
                if otherPlayerBlessings[2][3] >= 5 {
                    self.currentHP += hpToReturn * 1.05
                } else if otherPlayerBlessings[2][3] == 4 {
                    self.currentHP += hpToReturn * 1.025
                } else {
                    self.currentHP += hpToReturn
                }
            }
        }
        
        if self.currentHP > self.maxHP * 1.05 {
            self.currentHP = self.maxHP * 1.05
        }
    }
    
    func applyMovespeedSteal(_ player:Character) {
        if self == gameScene?.playerNode {
            if blessingList[chosenBlessing][0] >= 7 {
                let change = player.movespeed * 0.12
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            } else if blessingList[chosenBlessing][0] >= 6 {
                let change = player.movespeed * 0.06
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            }
        } else if self == gameScene?.playerNode2 {
            if otherPlayerBlessings[0][0] >= 7 {
                let change = player.movespeed * 0.12
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            } else if otherPlayerBlessings[0][0] >= 6 {
                let change = player.movespeed * 0.06
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            }
        } else if self == gameScene?.playerNode3 {
            if otherPlayerBlessings[1][0] >= 7 {
                let change = player.movespeed * 0.12
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            } else if otherPlayerBlessings[1][0] >= 6 {
                let change = player.movespeed * 0.06
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            }
        } else if self == gameScene?.playerNode4 {
            if otherPlayerBlessings[2][0] >= 7 {
                let change = player.movespeed * 0.12
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            } else if otherPlayerBlessings[2][0] >= 6 {
                let change = player.movespeed * 0.06
                self.movespeed += change
                player.movespeed -= change
                self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                    self.movespeed -= change
                    player.movespeed += change
                })
            }
        } else {
            if self.player == gameScene?.playerNode.player {
                if blessingList[chosenBlessing][0] >= 7 {
                    let change = player.movespeed * 0.12
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                } else if blessingList[chosenBlessing][0] >= 6 {
                    let change = player.movespeed * 0.06
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                }
            } else if self.player == gameScene?.playerNode2.player {
                if otherPlayerBlessings[0][0] >= 7 {
                    let change = player.movespeed * 0.12
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                } else if otherPlayerBlessings[0][0] >= 6 {
                    let change = player.movespeed * 0.06
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                }
            } else if self.player == gameScene?.playerNode3.player {
                if otherPlayerBlessings[1][0] >= 7 {
                    let change = player.movespeed * 0.12
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                } else if otherPlayerBlessings[1][0] >= 6 {
                    let change = player.movespeed * 0.06
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                }
            } else if self.player == gameScene?.playerNode4.player {
                if otherPlayerBlessings[2][0] >= 7 {
                    let change = player.movespeed * 0.12
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                } else if otherPlayerBlessings[2][0] >= 6 {
                    let change = player.movespeed * 0.06
                    self.movespeed += change
                    player.movespeed -= change
                    self.parent?.run(SKAction.wait(forDuration: 2.5),completion:{
                        self.movespeed -= change
                        player.movespeed += change
                    })
                }
            }
        }
    }
    
    func doSkill_1() {
        doSkillAnimation("Skill_1")
        if characterName == "Jack-O" {            
            let damage:CGFloat = 0 + (power * 1.0)
            let attackBox = (self.childNode(withName: "Skill1_Box") as! AttackBox)
            attackBox.activateFor(time: 0.5, damage: damage)
        } else if characterName == "Plum" {
            if sfxEnabled && self.parent != nil {
                self.soundShoot?.run(SKAction.stop())
                self.soundShoot?.run(SKAction.play())
            }
            
            let damage:CGFloat = 5 + (power * 0.1)
            summon(damage)
        } else if characterName == "Rosetta" {
            if sfxEnabled && self.parent != nil {
                self.soundShoot?.run(SKAction.stop())
                self.soundShoot?.run(SKAction.play())
            }
            
            let damage:CGFloat = 5 + (power * 0.1)
            summon(damage)
        } else if characterName == "Silva" {
            if sfxEnabled && self.parent != nil {
                self.soundSlash?.run(SKAction.stop())
                self.soundSlash?.run(SKAction.play())
            }
            
            let damage:CGFloat = 5 + (power * 0.05)
            let attackBox = (self.childNode(withName: "Skill1_Box") as! AttackBox)
            attackBox.activateFor(time: 0.5, damage: damage)
        } else if characterName == "Sarah" {
            if sfxEnabled && self.parent != nil {
                self.soundSlash?.run(SKAction.stop())
                self.soundSlash?.run(SKAction.play())
            }
            
            let damage:CGFloat = 5 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill1_Box") as! AttackBox)
            attackBox.activateFor(time: 0.5, damage: damage)
        } else if characterName == "Cog" {
            if sfxEnabled && self.parent != nil {
                self.soundSummon?.run(SKAction.stop())
                self.soundSummon?.run(SKAction.play())
            }
            
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
            
            animateIdle = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Idle_1"),self.CharAtlas.textureNamed(characterForm + "_Idle_2"),self.CharAtlas.textureNamed(characterForm + "_Idle_3"),self.CharAtlas.textureNamed(characterForm + "_Idle_4"),self.CharAtlas.textureNamed(characterForm + "_Idle_5"),self.CharAtlas.textureNamed(characterForm + "_Idle_6"),self.CharAtlas.textureNamed(characterForm + "_Idle_7"),self.CharAtlas.textureNamed(characterForm + "_Idle_8"),self.CharAtlas.textureNamed(characterForm + "_Idle_9"),self.CharAtlas.textureNamed(characterForm + "_Idle_10")], timePerFrame: 0.065,resize:true,restore:true))
            
            animateRun = SKAction.repeatForever(SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Run_1"),self.CharAtlas.textureNamed(characterForm + "_Run_2"),self.CharAtlas.textureNamed(characterForm + "_Run_3"),self.CharAtlas.textureNamed(characterForm + "_Run_4"),self.CharAtlas.textureNamed(characterForm + "_Run_5"),self.CharAtlas.textureNamed(characterForm + "_Run_6"),self.CharAtlas.textureNamed(characterForm + "_Run_7"),self.CharAtlas.textureNamed(characterForm + "_Run_8")], timePerFrame: 0.06,resize:true,restore:true))
            
            animateJump = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Jump_1"),self.CharAtlas.textureNamed(characterForm + "_Jump_2"),self.CharAtlas.textureNamed(characterForm + "_Jump_3"),self.CharAtlas.textureNamed(characterForm + "_Jump_4"),self.CharAtlas.textureNamed(characterForm + "_Jump_5"),self.CharAtlas.textureNamed(characterForm + "_Jump_6"),self.CharAtlas.textureNamed(characterForm + "_Jump_7"),self.CharAtlas.textureNamed(characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_1 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Jump_1"),self.CharAtlas.textureNamed(characterForm + "_Jump_2"),self.CharAtlas.textureNamed(characterForm + "_Jump_3"),self.CharAtlas.textureNamed(characterForm + "_Jump_4"),self.CharAtlas.textureNamed(characterForm + "_Jump_5"),self.CharAtlas.textureNamed(characterForm + "_Jump_6"),self.CharAtlas.textureNamed(characterForm + "_Jump_7"),self.CharAtlas.textureNamed(characterForm + "_Jump_8")], timePerFrame: 0.07,resize:true,restore:true)
            
            animateSkill_2 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Slide_1"),self.CharAtlas.textureNamed(characterForm + "_Slide_2"),self.CharAtlas.textureNamed(characterForm + "_Slide_3"),self.CharAtlas.textureNamed(characterForm + "_Slide_4"),self.CharAtlas.textureNamed(characterForm + "_Slide_5"),self.CharAtlas.textureNamed(characterForm + "_Slide_6"),self.CharAtlas.textureNamed(characterForm + "_Slide_7"),self.CharAtlas.textureNamed(characterForm + "_Slide_8"),self.CharAtlas.textureNamed(characterForm + "_Slide_9"),self.CharAtlas.textureNamed(characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
            
            animateSkill_3 = SKAction.animate(with: [self.CharAtlas.textureNamed(characterForm + "_Slide_1"),self.CharAtlas.textureNamed(characterForm + "_Slide_2"),self.CharAtlas.textureNamed(characterForm + "_Slide_3"),self.CharAtlas.textureNamed(characterForm + "_Slide_4"),self.CharAtlas.textureNamed(characterForm + "_Slide_5"),self.CharAtlas.textureNamed(characterForm + "_Slide_6"),self.CharAtlas.textureNamed(characterForm + "_Slide_7"),self.CharAtlas.textureNamed(characterForm + "_Slide_8"),self.CharAtlas.textureNamed(characterForm + "_Slide_9"),self.CharAtlas.textureNamed(characterForm + "_Slide_10")], timePerFrame: 0.065,resize:true,restore:true)
        }
    }
    
    func doSkill_2() {
        doSkillAnimation("Skill_2")
        if characterName == "Jack-O" {
            if sfxEnabled && self.parent != nil {
                self.soundSummon?.run(SKAction.stop())
                self.soundSummon?.run(SKAction.play())
            }
            
            let damage:CGFloat = 0
            summon(damage)
        } else if characterName == "Plum" {
            if sfxEnabled && self.parent != nil {
                self.soundSlash?.run(SKAction.stop())
                self.soundSlash?.run(SKAction.play())
            }
            
            let damage:CGFloat = (power * 1) - 25
            let attackBox = (self.childNode(withName: "Skill2_Box") as! AttackBox)
            attackBox.activateFor(time: 0.5, damage: damage)
        } else if characterName == "Rosetta" {
            if sfxEnabled && self.parent != nil {
                self.soundSlash?.run(SKAction.stop())
                self.soundSlash?.run(SKAction.play())
            }
            
            let damage:CGFloat = (power * 1) - 25
            let attackBox = (self.childNode(withName: "Skill2_Box") as! AttackBox)
            attackBox.activateFor(time: 0.5, damage: damage)
        } else if characterName == "Silva" {
            if sfxEnabled && self.parent != nil {
                self.soundBuff?.run(SKAction.stop())
                self.soundBuff?.run(SKAction.play())
            }
            
            let damage:CGFloat = 10 + ((maxHP - currentHP) * 0.5)
            self.power += damage
            skillMaxCharges_1 = BASE_SKILL_MAX_CHARGES_1 + Int(power/25)
            self.parent!.run(SKAction.wait(forDuration: 7),completion:{
                self.power = self.BASE_POWER
                self.skillMaxCharges_1 = self.BASE_SKILL_MAX_CHARGES_1 + Int(self.power/25)
            })
        } else if characterName == "Sarah" {
            if sfxEnabled && self.parent != nil {
                self.soundShoot?.run(SKAction.stop())
                self.soundShoot?.run(SKAction.play())
            }
            
            let damage:CGFloat = 5 + (power * 0.15)
            summon(damage)
        } else if characterName == "Cog" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let distance:CGFloat = 65 * self.xScale
            let distance2:CGFloat = distance/2
            let distance3:CGFloat = distance/3
            let distance4:CGFloat = distance/4
            
            if self.position.x + distance < 1560 && self.position.x + distance > -1560 {
                self.physicsBody?.applyImpulse(CGVector(dx: distance, dy: 0))
            } else if self.position.x + distance2 < 1560 && self.position.x + distance2 > -1560 {
                self.physicsBody?.applyImpulse(CGVector(dx: distance2, dy: 0))
            } else if self.position.x + distance3 < 1560 && self.position.x + distance3 > -1560 {
                self.physicsBody?.applyImpulse(CGVector(dx: distance3, dy: 0))
            } else if self.position.x + distance4 < 1560 && self.position.x + distance4 > -1560 {
                self.physicsBody?.applyImpulse(CGVector(dx: distance4, dy: 0))
            }
            
            let attackBox = (self.childNode(withName: "Skill2_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
            //print("Cog did: " + String(describing: damage))
            summon(damage)
        }
    }
    
    func doSkill_3() {
        doSkillAnimation("Skill_3")
        if characterName == "Jack-O" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill3_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
        } else if characterName == "Plum" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill3_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
        } else if characterName == "Rosetta" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill3_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
        } else if characterName == "Silva" {
            if sfxEnabled && self.parent != nil {
                self.soundBuff?.run(SKAction.stop())
                self.soundBuff?.run(SKAction.play())
            }
            
            let damage:CGFloat = 10 + (currentHP * 0.25)
            self.movespeed += damage
            self.parent!.run(SKAction.wait(forDuration: 5),completion:{
                self.movespeed = self.BASE_MOVESPEED
            })
        } else if characterName == "Sarah" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill3_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
        } else if characterName == "Cog" {
            if sfxEnabled && self.parent != nil {
                self.soundSlide?.run(SKAction.stop())
                self.soundSlide?.run(SKAction.play())
            }
            
            let damage:CGFloat = 15 + (power * 0.5)
            let attackBox = (self.childNode(withName: "Skill3_Box") as! AttackBox)
            attackBox.activateFor(time: 0.75, damage: damage)
        }
    }
    
    func checkIfUnderMaxSummonedAI() -> Bool {
        var returnBool = false
        if self == gameScene?.playerNode && gameScene!.p1SummonCount < 4 {
            returnBool = true
        } else if self == gameScene?.playerNode2 && gameScene!.p2SummonCount < 4 {
            returnBool = true
        } else if self == gameScene?.playerNode3 && gameScene!.p3SummonCount < 4 {
            returnBool = true
        } else if self == gameScene?.playerNode4 && gameScene!.p4SummonCount < 4 {
            returnBool = true
        }
        
        return returnBool
    }
    
    func summon(_ damage:CGFloat) {
        if !(self is AI) {
            if characterName == "Jack-O" {
                let pos1 = CGPoint(x: self.position.x + (150 * self.xScale), y: self.position.y)
                let pos2 = CGPoint(x: self.position.x + (100 * self.xScale), y: self.position.y)
                
                if self.returnBlock(pos1) != "Dirt" && checkIfUnderMaxSummonedAI() && skillCurrentCharges_2 > 0 && (abs(pos1.x) < 1595 && pos1.y < 2014 && pos1.y > -1280) {
                    let zombie_boy = AI(imageNamed: characterName + "_Zombie_Boy_Idle_1")
                    zombie_boy.name = self.player + "_Girl" + String(childCount)
                    zombie_boy.characterForm = "Boy"
                    zombie_boy.player = self.player
                    zombie_boy.CharAtlas = gameScene!.zombieboyAtlas
                    zombie_boy.setUp(characterName)
                    zombie_boy.startAI()
                    zombie_boy.xScale = self.xScale
                    zombie_boy.position = pos1
                    zombie_boy.physicsBody = SKPhysicsBody(texture: zombie_boy.texture!, size: zombie_boy.texture!.size())
                    zombie_boy.physicsBody?.allowsRotation = false
                    zombie_boy.physicsBody!.categoryBitMask = SummonedCategory
                    zombie_boy.physicsBody!.collisionBitMask = WorldCategory
                    self.parent!.addChild(zombie_boy)
                    skillCurrentCharges_2 -= 1
                }
                
                if self.returnBlock(pos2) != "Dirt" && checkIfUnderMaxSummonedAI() && skillCurrentCharges_2 > 0 && (abs(pos2.x) < 1595 && pos2.y < 2014 && pos2.y > -1280) {
                    let zombie_girl = AI(imageNamed: characterName + "_Zombie_Girl_Idle_1")
                    zombie_girl.name = self.player + "_Girl" + String(childCount)
                    zombie_girl.characterForm = "Girl"
                    zombie_girl.player = self.player
                    zombie_girl.CharAtlas = gameScene!.zombiegirlAtlas
                    zombie_girl.setUp(characterName)
                    zombie_girl.startAI()
                    zombie_girl.xScale = self.xScale
                    zombie_girl.position = pos2
                    zombie_girl.physicsBody = SKPhysicsBody(texture: zombie_girl.texture!, size: zombie_girl.texture!.size())
                    zombie_girl.physicsBody?.allowsRotation = false
                    zombie_girl.physicsBody!.categoryBitMask = SummonedCategory
                    zombie_girl.physicsBody!.collisionBitMask = WorldCategory
                    self.parent!.addChild(zombie_girl)
                    skillCurrentCharges_2 -= 1
                }
                
                if ((self.returnBlock(pos1) != "Dirt" && (abs(pos1.x) < 1595 && pos1.y < 2014 && pos1.y > -1280)) || ((self.returnBlock(pos2)) != "Dirt" && (abs(pos2.x) < 1595 && pos2.y < 2014 && pos2.y > -1280))) && skillCurrentCharges_2 > 0 {
                    childCount += 1
                    if self == gameScene?.playerNode {
                        gameScene?.p1SummonCount += 1
                    } else if self == gameScene?.playerNode2 {
                        gameScene?.p2SummonCount += 1
                    } else if self == gameScene?.playerNode3 {
                        gameScene?.p3SummonCount += 1
                    } else if self == gameScene?.playerNode4 {
                        gameScene?.p4SummonCount += 1
                    }
                }
            } else if characterName == "Plum" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (25 * self.xScale), dy: 0))
            } else if characterName == "Rosetta" {
                let kunai = Projectile(imageNamed: "Kunai")
                kunai.setUp(damage, direction: self.xScale, owner: self.player)
                kunai.position.y = self.position.y
                kunai.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(kunai)
                kunai.physicsBody!.applyImpulse(CGVector(dx: (25 * self.xScale), dy: 0))
            } else if characterName == "Sarah" {
                let bullet = Projectile(imageNamed: "Bullet")
                bullet.setUp(damage, direction: self.xScale, owner: self.player)
                bullet.position.y = self.position.y
                bullet.position.x = self.position.x + (35 * self.xScale)
                self.parent!.addChild(bullet)
                bullet.physicsBody!.applyImpulse(CGVector(dx: (40 * self.xScale), dy: 0))
            } else if characterName == "Cog" {
                let pos = CGPoint(x: self.position.x + (530 * self.xScale), y: self.position.y)
                if self.returnBlock(pos) != "Dirt" && checkIfUnderMaxSummonedAI() && skillCurrentCharges_2 > 0 && (abs(pos.x) < 1595 && pos.y < 2014 && pos.y > -1280) {
                    if characterForm == "Cat" {
                        let dog = AI(imageNamed: "Dog_Idle_1")
                        dog.characterForm = "Dog"
                        dog.player = self.player
                        dog.CharAtlas = self.CharAtlas
                        dog.setUp(characterName)
                        dog.startAI()
                        dog.xScale = self.xScale * -1
                        dog.position.x = self.position.x + (530 * self.xScale)
                        dog.position.y = self.position.y
                        self.parent!.addChild(dog)
                        skillCurrentCharges_2 -= 1
                    } else {
                        let cat = AI(imageNamed: "Cat_Idle_1")
                        cat.characterForm = "Cat"
                        cat.player = self.player
                        cat.CharAtlas = self.CharAtlas
                        cat.setUp(characterName)
                        cat.startAI()
                        cat.xScale = self.xScale * -1
                        cat.position.x = self.position.x + (530 * self.xScale)
                        cat.position.y = self.position.y
                        self.parent!.addChild(cat)
                        skillCurrentCharges_2 -= 1
                    }
                }
                
                if (self.returnBlock(pos) != "Dirt" && checkIfUnderMaxSummonedAI() && (abs(pos.x) < 1595 && pos.y < 2014 && pos.y > -1280)) && skillCurrentCharges_2 > 0 {
                    if self == gameScene?.playerNode {
                        gameScene?.p1SummonCount += 1
                    } else if self == gameScene?.playerNode2 {
                        gameScene?.p2SummonCount += 1
                    } else if self == gameScene?.playerNode3 {
                        gameScene?.p3SummonCount += 1
                    } else if self == gameScene?.playerNode4 {
                        gameScene?.p4SummonCount += 1
                    }
                }
            }
        }
    }
    
    func takeDamage(_ damageToTake: CGFloat, direction: CGFloat) {
        let damageModified = damageToTake * (1 - resistance/100)
        
        currentHP -= damageModified
        
        if currentHP <= 0 {
            currentHP = 0
            if !isResting {
                isResting = true
                self.removeAllActions()
                self.run(animateFaint!,completion:{
                    var new = self.CharAtlas.textureNamed(self.characterName + "_Faint_10")
                    if self.characterName == "Cog" {
                        new = self.CharAtlas.textureNamed(self.characterForm + "_Faint_10")
                    }
                    self.run(SKAction.setTexture(new))
                    self.size = new.size()
                })
            } else {
                var new = self.CharAtlas.textureNamed(self.characterName + "_Faint_10")
                if self.characterName == "Cog" {
                    new = self.CharAtlas.textureNamed(self.characterForm + "_Faint_10")
                }
                self.run(SKAction.setTexture(new))
                self.size = new.size()
            }
        } else if !self.isStunned && !self.isResting && damageModified > 0 {
            var new = [self.CharAtlas.textureNamed(self.characterName + "_Faint_1"),self.CharAtlas.textureNamed(self.characterName + "_Faint_2"),self.CharAtlas.textureNamed(self.characterName + "_Faint_3"),self.CharAtlas.textureNamed(self.characterName + "_Faint_2"),self.CharAtlas.textureNamed(self.characterName + "_Faint_1")]
            if self.characterName == "Cog" {
                new = [self.CharAtlas.textureNamed(self.characterForm + "_Faint_1"),self.CharAtlas.textureNamed(self.characterForm + "_Faint_2"),self.CharAtlas.textureNamed(self.characterForm + "_Faint_3"),self.CharAtlas.textureNamed(self.characterForm + "_Faint_2"),self.CharAtlas.textureNamed(self.characterForm + "_Faint_1")]
            }
            self.playerAction = ""
            self.playerMovement = ""
            if self.childNode(withName: "Skill1_Box") != nil {
                (self.childNode(withName: "Skill1_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill1_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill2_Box") != nil {
                (self.childNode(withName: "Skill2_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill2_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill3_Box") != nil {
                (self.childNode(withName: "Skill3_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill3_Box") as! AttackBox).damage = 0
            }
            self.isStunned = true
            self.run(SKAction.animate(with: new, timePerFrame: 0.07, resize: true, restore: false),completion:{
                self.isStunned = false
            })
        }
        
        var X_MOD:CGFloat = 0
        var Y_MOD:CGFloat = 0
        
        if damageToTake < 11 {
            X_MOD = 0.75
            Y_MOD = 0.75
        } else if damageToTake < 21 && damageToTake > 10 {
            X_MOD = 1.5
            Y_MOD = 1.5
        } else if damageToTake < 31 && damageToTake > 20 {
            X_MOD = 2.25
            Y_MOD = 2.25
        } else if damageToTake < 41 && damageToTake > 30 {
            X_MOD = 3
            Y_MOD = 3
        } else {
            X_MOD = 3.75
            Y_MOD = 3.75
        }
        
        
        let impX:CGFloat = (1 - (currentHP/maxHP)) * 30 * X_MOD
        let impY:CGFloat = (1 - (currentHP/maxHP)) * 15 * Y_MOD
        
        self.physicsBody?.applyImpulse(CGVector(dx: impX * direction, dy: impY))
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.confirmPlayerStats()
        } else if GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.confirmPlayerStats()
        }
    }
    
    func playerMovement(_ mod:CGFloat) {
        if playerMovement == "Move_Left" && !self.isResting && !self.isStunned && !self.isDead {
            self.physicsBody?.velocity = CGVector(dx: -self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
            
            if appDelegate.mpcHandler.session != nil {
                MP_TRAFFIC_HANDLER.confirmPlayerStats()
            } else if GK_TRAFFIC_HANDLER.match != nil {
                GK_TRAFFIC_HANDLER.confirmPlayerStats()
            }
        } else if playerMovement == "Move_Right"  && !self.isResting && !self.isStunned && !self.isDead {
            self.physicsBody?.velocity = CGVector(dx: self.movespeed * mod, dy: (self.physicsBody?.velocity.dy)!)
            
            if appDelegate.mpcHandler.session != nil {
                MP_TRAFFIC_HANDLER.confirmPlayerStats()
            } else if GK_TRAFFIC_HANDLER.match != nil {
                GK_TRAFFIC_HANDLER.confirmPlayerStats()
            }
        }
    }
    
    func checkBlockUnder() {
        let tile = self.returnBlockBelow()
        
        if tile == "Dirt" {
            self.playerMovement(1.0)
            self.resetJumpsCount()
            if self.action(forKey: "Skill_2") == nil && self.action(forKey: "Skill_3") == nil && self.action(forKey: "Jump") == nil && self.playerMovement == "" && !isStunned && !isDead && !isResting {
                self.physicsBody?.velocity.dx = 0
            }
            
            if self.isResting && self.allowedToRecover && !self.isDead {
                self.recovered()
            }
        } else if tile == "Water" {
            self.physicsBody?.applyForce(CGVector(dx: 0, dy: 30))
            self.physicsBody?.affectedByGravity = false
            self.playerMovement(0.4)
            self.resetJumpsCount()
        } else {
            self.physicsBody?.affectedByGravity = true
            self.playerMovement(0.75)
        }
        
        if self.isResting && !isDead {
            self.playerMovement = ""
            self.playerLastMovement = ""
        }
        
        if self.isResting && self.currentHP >= self.maxHP && !isDead {
            self.recovered()
        }
        
        if (abs(self.position.x) > 1595 || self.position.y > 2014 || self.position.y < -1280) && !isDead {
            self.isDead = true
            self.currentHP = 0
            gameScene!.someoneDied = true
        }
        
        if deathMode == 2 && (tile == "Water" && self.isResting) && !isDead {
            self.isDead = true
            self.currentHP = 0
            gameScene!.someoneDied = true
        } else if deathMode == 1 && self.lives <= 0 && self.isResting && !isDead {
            self.isDead = true
            self.currentHP = 0
            gameScene!.someoneDied = true
        }
    }
    
    func returnBlock(_ at:CGPoint) -> String {
        let position = at
        let column = gameScene?.tileMapNode?.tileColumnIndex(fromPosition: position)
        let row = gameScene?.tileMapNode?.tileRowIndex(fromPosition: position)
        let tile = gameScene?.tileMapNode?.tileGroup(atColumn: column!, row: row!)
        var block = ""
        
        if tile?.name == "Water" {
            block = "Water"
        } else if tile?.name == "Dirt" {
            block = "Dirt"
        }
        
        return block
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
    
    func checkIfStuck() -> Bool {
        let position = CGPoint(x: self.position.x, y: self.position.y)
        let column = gameScene?.tileMapNode?.tileColumnIndex(fromPosition: position)
        let row = gameScene?.tileMapNode?.tileRowIndex(fromPosition: position)
        let tile = gameScene?.tileMapNode?.tileGroup(atColumn: column!, row: row!)
        var isStuck = false
        
        if tile?.name == "Dirt" {
            isStuck = true
        }
        
        return isStuck
    }
    
    func isSkillReady_1(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_1 > 0  && !isStunned {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_2(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_2 > 0  && !isStunned {
            skillReady = true
        }
        
        return skillReady
    }
    
    func isSkillReady_3(_ currentTime:TimeInterval) -> Bool {
        var skillReady = false
        
        if self.skillCurrentCharges_3 > 0 && !isStunned {
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
        
        if !isResting && !isDead && !isStunned {
            if (playerMovement == "Move_Right" || playerMovement == "Move_Left") && playerMovement != playerLastMovement {
                doMoveAnimation(playerMovement)
            } else if playerMovement == "" && playerMovement != playerLastMovement {
                doMoveAnimation(playerMovement)
            }
            
            if self.playerAction == "Jump" && self.currentJumps < self.maxJumps {
                self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: self.movespeed * 0.25))
                self.currentJumps += 1
                self.doSkillAnimation(playerAction)
                if sfxEnabled && self.parent != nil {
                    self.soundJump?.run(SKAction.stop())
                    self.soundJump?.run(SKAction.play())
                }
            } else if self.playerAction == "Skill_1" && self.isSkillReady_1(currentTime) {
                self.skill_1_Last_Used = currentTime
                self.skillCurrentCharges_1 -= 1
                self.doSkill_1()
            } else if self.playerAction == "Skill_2" && self.isSkillReady_2(currentTime) {
                self.skill_2_Last_Used = currentTime
                if self.characterName == "Jack-O" || self.characterName == "Cog" {
                    self.skillCurrentCharges_2 -= 0
                } else {
                    self.skillCurrentCharges_2 -= 1
                }
                self.doSkill_2()
            } else if self.playerAction == "Skill_3" && self.isSkillReady_3(currentTime) {
                self.skill_3_Last_Used = currentTime
                self.skillCurrentCharges_3 -= 1
                self.doSkill_3()
            } else {
                self.playerAction = ""
            }
        }
    }
    
    func doSkillAnimation(_ skill:String) {
        if skill == "Skill_1" {
            self.removeAction(forKey: skill)
            self.run(self.animateSkill_1!,withKey:skill)
            if self.childNode(withName: "Skill2_Box") != nil {
                (self.childNode(withName: "Skill2_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill2_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill3_Box") != nil {
                (self.childNode(withName: "Skill3_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill3_Box") as! AttackBox).damage = 0
            }
        } else if skill == "Skill_2" {
            self.removeAction(forKey: skill)
            self.run(self.animateSkill_2!,withKey:skill)
            if self.childNode(withName: "Skill1_Box") != nil {
                (self.childNode(withName: "Skill1_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill1_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill3_Box") != nil {
                (self.childNode(withName: "Skill3_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill3_Box") as! AttackBox).damage = 0
            }
        } else if skill == "Skill_3" {
            self.removeAction(forKey: skill)
            self.run(self.animateSkill_3!,withKey:skill)
            if self.childNode(withName: "Skill1_Box") != nil {
                (self.childNode(withName: "Skill1_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill1_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill2_Box") != nil {
                (self.childNode(withName: "Skill2_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill2_Box") as! AttackBox).damage = 0
            }
        } else if skill == "Jump" {
            self.removeAction(forKey: skill)
            self.run(self.animateJump!,withKey:skill)
            if self.childNode(withName: "Skill1_Box") != nil {
                (self.childNode(withName: "Skill1_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill1_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill2_Box") != nil {
                (self.childNode(withName: "Skill2_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill2_Box") as! AttackBox).damage = 0
            }
            
            if self.childNode(withName: "Skill3_Box") != nil {
                (self.childNode(withName: "Skill3_Box") as! AttackBox).active = false
                (self.childNode(withName: "Skill3_Box") as! AttackBox).damage = 0
            }
        }
        
        playerAction = ""
    }
    
    func doMoveAnimation(_ move:String) {
        if move == "Move_Left" || move == "Move_Right" {
            self.removeAction(forKey: "Idle")
            self.run(self.animateRun!,withKey:"Run")
        } else {
            self.removeAction(forKey: "Run")
            self.run(self.animateIdle!,withKey:"Idle")
        }
    }
    
    func followNaturalRegen(_ currentTime:TimeInterval) {
        self.playerLastMovement = self.playerMovement
        currentTimeCopy = currentTime
        if currentTime - lastRegenTime >= 0.5 && !isDead {
            if self.currentHP < self.maxHP {
                if self.isResting {
                    self.currentHP += (self.maxHP/6)
                } else {
                    self.currentHP += (self.hpRegen/2)
                }
                
                if self.currentHP > self.maxHP {
                    self.currentHP = self.maxHP
                    self.allowedToRecover = true
                }
            }
            lastRegenTime = currentTime
        }
    }
    
    func useBlessingPower(_ move:String) {
        if move == "Limbo" && self.currentTimeCopy - self.lastBlessingTime >= 3 {
            self.usedLimbo = true
            lastBlessingTime = currentTimeCopy
        } else if move == "Enrage" && self.currentTimeCopy - self.lastBlessingTime >= 12 {
            let skill1Old:Double = skillCooldown_1
            let skill2Old:Double = skillCooldown_2
            let skill3Old:Double = skillCooldown_3
            
            skillCooldown_1 = skillCooldown_1 * 0.25
            skillCooldown_2 = skillCooldown_2 * 0.25
            skillCooldown_3 = skillCooldown_3 * 0.25
            
            self.parent?.run(SKAction.wait(forDuration: 6),completion:{
                self.skillCooldown_1 = skill1Old
                self.skillCooldown_2 = skill2Old
                self.skillCooldown_3 = skill3Old
            })
            lastBlessingTime = currentTimeCopy
        } else if move == "Survival" && self.currentTimeCopy - self.lastBlessingTime >= 18 {
            let hpToAdd = (self.maxHP - self.currentHP) * 0.3
            self.applyHealing(hpToAdd)
            lastBlessingTime = currentTimeCopy
        } else if move == "Lucky_Soul" && self.currentTimeCopy - self.lastBlessingTime >= 18 {
            let oldRegen:CGFloat = self.hpRegen
            self.hpRegen = self.hpRegen * 1.75
            
            self.parent?.run(SKAction.wait(forDuration: 4),completion:{
                self.hpRegen = oldRegen
            })
            lastBlessingTime = currentTimeCopy
        } else if move == "Hoarder" && self.currentTimeCopy - self.lastBlessingTime >= 3 && itemHeld != "" {
            self.useItem(self.itemHeld)
            self.itemHeld = ""
            lastBlessingTime = currentTimeCopy
        }
        
        if appDelegate.mpcHandler.session != nil && self == gameScene?.playerNode {
            MP_TRAFFIC_HANDLER.sendBlessingMoveUsed(move)
        } else if GK_TRAFFIC_HANDLER.match != nil && self == gameScene?.playerNode {
            GK_TRAFFIC_HANDLER.sendBlessingMoveUsed(move)
        }
    }
    
    func recovered() {
        self.isResting = false
        self.allowedToRecover = false
        self.isStunned = false
        var new = self.CharAtlas.textureNamed(self.characterName + "_Idle_1")
        if self.characterName == "Cog" {
            new = self.CharAtlas.textureNamed( self.characterForm + "_Idle_10")
        }
        self.run(SKAction.setTexture(new))
        self.size = new.size()
        lives -= 1
        
        if appDelegate.mpcHandler.session != nil {
            MP_TRAFFIC_HANDLER.confirmPlayerStats()
        } else if GK_TRAFFIC_HANDLER.match != nil {
            GK_TRAFFIC_HANDLER.confirmPlayerStats()
        }
    }
    
    func useItem(_ item:String) {
        if item == "Icy_Grasp" {
            itemInUse = item
            let effect = SKEmitterNode(fileNamed: "CoolParticle.sks")
            effect?.position.y = 225
            self.addChild(effect!)
            self.parent?.run(SKAction.wait(forDuration: 5),completion:{
                effect?.removeFromParent()
                if self.itemInUse == "Icy_Grasp" {
                    self.itemInUse = ""
                }
            })
        } else if item == "Golems_Curse" || item == "Air_Blast" {
            itemInUse = ""
            if gameScene!.multiplayerType == 0 || gameScene!.otherPlayersCount == 3 {
                if self == gameScene?.playerNode {
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode3.position.x)! >= self.position.x - 250 && (gameScene?.playerNode3.position.x)! <= self.position.x + 250 && (gameScene?.playerNode3.position.y)! >= self.position.y - 250 && (gameScene?.playerNode3.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode3.position.x {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode3.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode3.resistance * 0.25
                            gameScene!.playerNode3.movespeed -= oldMS
                            gameScene!.playerNode3.resistance += oldResist
                            gameScene!.playerNode3.physicsBody?.pinned = true
                            gameScene!.playerNode3.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode3.movespeed += oldMS
                                gameScene!.playerNode3.resistance -= oldResist
                                gameScene!.playerNode3.physicsBody?.pinned = false
                                gameScene!.playerNode3.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode4.position.x)! >= self.position.x - 250 && (gameScene?.playerNode4.position.x)! <= self.position.x + 250 && (gameScene?.playerNode4.position.y)! >= self.position.y - 250 && (gameScene?.playerNode4.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode4.position.x {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode4.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode4.resistance * 0.25
                            gameScene!.playerNode4.movespeed -= oldMS
                            gameScene!.playerNode4.resistance += oldResist
                            gameScene!.playerNode4.physicsBody?.pinned = true
                            gameScene!.playerNode4.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode4.movespeed += oldMS
                                gameScene!.playerNode4.resistance -= oldResist
                                gameScene!.playerNode4.physicsBody?.pinned = false
                                gameScene!.playerNode4.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode2 {
                    if (gameScene?.playerNode.position.x)! >= self.position.x - 250 && (gameScene?.playerNode.position.x)! <= self.position.x + 250 && (gameScene?.playerNode.position.y)! >= self.position.y - 250 && (gameScene?.playerNode.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode.position.x {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode.resistance * 0.25
                            gameScene!.playerNode.movespeed -= oldMS
                            gameScene!.playerNode.resistance += oldResist
                            gameScene!.playerNode.physicsBody?.pinned = true
                            gameScene!.playerNode.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode.movespeed += oldMS
                                gameScene!.playerNode.resistance -= oldResist
                                gameScene!.playerNode.physicsBody?.pinned = false
                                gameScene!.playerNode.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode3.position.x)! >= self.position.x - 250 && (gameScene?.playerNode3.position.x)! <= self.position.x + 250 && (gameScene?.playerNode3.position.y)! >= self.position.y - 250 && (gameScene?.playerNode3.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode3.position.x {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode3.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode3.resistance * 0.25
                            gameScene!.playerNode3.movespeed -= oldMS
                            gameScene!.playerNode3.resistance += oldResist
                            gameScene!.playerNode3.physicsBody?.pinned = true
                            gameScene!.playerNode3.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode3.movespeed += oldMS
                                gameScene!.playerNode3.resistance -= oldResist
                                gameScene!.playerNode3.physicsBody?.pinned = false
                                gameScene!.playerNode3.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode4.position.x)! >= self.position.x - 250 && (gameScene?.playerNode4.position.x)! <= self.position.x + 250 && (gameScene?.playerNode4.position.y)! >= self.position.y - 250 && (gameScene?.playerNode4.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode4.position.x {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode4.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode4.resistance * 0.25
                            gameScene!.playerNode4.movespeed -= oldMS
                            gameScene!.playerNode4.resistance += oldResist
                            gameScene!.playerNode4.physicsBody?.pinned = true
                            gameScene!.playerNode4.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode4.movespeed += oldMS
                                gameScene!.playerNode4.resistance -= oldResist
                                gameScene!.playerNode4.physicsBody?.pinned = false
                                gameScene!.playerNode4.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode3 {
                    if (gameScene?.playerNode.position.x)! >= self.position.x - 250 && (gameScene?.playerNode.position.x)! <= self.position.x + 250 && (gameScene?.playerNode.position.y)! >= self.position.y - 250 && (gameScene?.playerNode.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode.position.x {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode.resistance * 0.25
                            gameScene!.playerNode.movespeed -= oldMS
                            gameScene!.playerNode.resistance += oldResist
                            gameScene!.playerNode.physicsBody?.pinned = true
                            gameScene!.playerNode.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode.movespeed += oldMS
                                gameScene!.playerNode.resistance -= oldResist
                                gameScene!.playerNode.physicsBody?.pinned = false
                                gameScene!.playerNode.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode4.position.x)! >= self.position.x - 250 && (gameScene?.playerNode4.position.x)! <= self.position.x + 250 && (gameScene?.playerNode4.position.y)! >= self.position.y - 250 && (gameScene?.playerNode4.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode4.position.x {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode4.position.y {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode4.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode4.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode4.resistance * 0.25
                            gameScene!.playerNode4.movespeed -= oldMS
                            gameScene!.playerNode4.resistance += oldResist
                            gameScene!.playerNode4.physicsBody?.pinned = true
                            gameScene!.playerNode4.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode4.movespeed += oldMS
                                gameScene!.playerNode4.resistance -= oldResist
                                gameScene!.playerNode4.physicsBody?.pinned = false
                                gameScene!.playerNode4.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode4 {
                    if (gameScene?.playerNode.position.x)! >= self.position.x - 250 && (gameScene?.playerNode.position.x)! <= self.position.x + 250 && (gameScene?.playerNode.position.y)! >= self.position.y - 250 && (gameScene?.playerNode.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode.position.x {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode.resistance * 0.25
                            gameScene!.playerNode.movespeed -= oldMS
                            gameScene!.playerNode.resistance += oldResist
                            gameScene!.playerNode.physicsBody?.pinned = true
                            gameScene!.playerNode.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode.movespeed += oldMS
                                gameScene!.playerNode.resistance -= oldResist
                                gameScene!.playerNode.physicsBody?.pinned = false
                                gameScene!.playerNode.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode3.position.x)! >= self.position.x - 250 && (gameScene?.playerNode3.position.x)! <= self.position.x + 250 && (gameScene?.playerNode3.position.y)! >= self.position.y - 250 && (gameScene?.playerNode3.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode3.position.x {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode3.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode3.resistance * 0.25
                            gameScene!.playerNode3.movespeed -= oldMS
                            gameScene!.playerNode3.resistance += oldResist
                            gameScene!.playerNode3.physicsBody?.pinned = true
                            gameScene!.playerNode3.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode3.movespeed += oldMS
                                gameScene!.playerNode3.resistance -= oldResist
                                gameScene!.playerNode3.physicsBody?.pinned = false
                                gameScene!.playerNode3.isStunned = false
                            })
                        }
                    }
                }
            } else if gameScene!.otherPlayersCount == 2 {
                if self == gameScene?.playerNode {
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode3.position.x)! >= self.position.x - 250 && (gameScene?.playerNode3.position.x)! <= self.position.x + 250 && (gameScene?.playerNode3.position.y)! >= self.position.y - 250 && (gameScene?.playerNode3.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode3.position.x {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode3.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode3.resistance * 0.25
                            gameScene!.playerNode3.movespeed -= oldMS
                            gameScene!.playerNode3.resistance += oldResist
                            gameScene!.playerNode3.physicsBody?.pinned = true
                            gameScene!.playerNode3.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode3.movespeed += oldMS
                                gameScene!.playerNode3.resistance -= oldResist
                                gameScene!.playerNode3.physicsBody?.pinned = false
                                gameScene!.playerNode3.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode2 {
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode3.position.x)! >= self.position.x - 250 && (gameScene?.playerNode3.position.x)! <= self.position.x + 250 && (gameScene?.playerNode3.position.y)! >= self.position.y - 250 && (gameScene?.playerNode3.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode3.position.x {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode3.position.y {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode3.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode3.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode3.resistance * 0.25
                            gameScene!.playerNode3.movespeed -= oldMS
                            gameScene!.playerNode3.resistance += oldResist
                            gameScene!.playerNode3.physicsBody?.pinned = true
                            gameScene!.playerNode3.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode3.movespeed += oldMS
                                gameScene!.playerNode3.resistance -= oldResist
                                gameScene!.playerNode3.physicsBody?.pinned = false
                                gameScene!.playerNode3.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode3 {
                    if (gameScene?.playerNode.position.x)! >= self.position.x - 250 && (gameScene?.playerNode.position.x)! <= self.position.x + 250 && (gameScene?.playerNode.position.y)! >= self.position.y - 250 && (gameScene?.playerNode.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode.position.x {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode.movespeed -= oldMS
                            gameScene!.playerNode.resistance += oldResist
                            gameScene!.playerNode.physicsBody?.pinned = true
                            gameScene!.playerNode.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode.movespeed += oldMS
                                gameScene!.playerNode.resistance -= oldResist
                                gameScene!.playerNode.physicsBody?.pinned = false
                                gameScene!.playerNode.isStunned = false
                            })
                        }
                    }
                    
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                }
            } else if gameScene!.otherPlayersCount == 1 {
                if self == gameScene?.playerNode {
                    if (gameScene?.playerNode2.position.x)! >= self.position.x - 250 && (gameScene?.playerNode2.position.x)! <= self.position.x + 250 && (gameScene?.playerNode2.position.y)! >= self.position.y - 250 && (gameScene?.playerNode2.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode2.position.x {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode2.position.y {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode2.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode2.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode2.resistance * 0.25
                            gameScene!.playerNode2.movespeed -= oldMS
                            gameScene!.playerNode2.resistance += oldResist
                            gameScene!.playerNode2.physicsBody?.pinned = true
                            gameScene!.playerNode2.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode2.movespeed += oldMS
                                gameScene!.playerNode2.resistance -= oldResist
                                gameScene!.playerNode2.physicsBody?.pinned = false
                                gameScene!.playerNode2.isStunned = false
                            })
                        }
                    }
                } else if self == gameScene?.playerNode2 {
                    if (gameScene?.playerNode.position.x)! >= self.position.x - 250 && (gameScene?.playerNode.position.x)! <= self.position.x + 250 && (gameScene?.playerNode.position.y)! >= self.position.y - 250 && (gameScene?.playerNode.position.y)! <= self.position.y + 250 {
                        if item == "Air_Blast" {
                            if self.position.x > gameScene!.playerNode.position.x {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: -750, dy: 750))
                                }
                            } else {
                                if self.position.y > gameScene!.playerNode.position.y {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: -750))
                                } else {
                                    gameScene!.playerNode.physicsBody?.applyImpulse(CGVector(dx: 750, dy: 750))
                                }
                            }
                        } else {
                            let oldMS = gameScene!.playerNode.movespeed
                            let oldResist:CGFloat = gameScene!.playerNode.resistance * 0.25
                            gameScene!.playerNode.movespeed -= oldMS
                            gameScene!.playerNode.resistance += oldResist
                            gameScene!.playerNode.physicsBody?.pinned = true
                            gameScene!.playerNode.isStunned = true
                            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                                gameScene!.playerNode.movespeed += oldMS
                                gameScene!.playerNode.resistance -= oldResist
                                gameScene!.playerNode.physicsBody?.pinned = false
                                gameScene!.playerNode.isStunned = false
                            })
                        }
                    }
                }
            }
            
            if item == "Air_Blast" {
                let effect = SKEmitterNode(fileNamed: "PushParticle.sks")
                effect?.position.y = 0
                self.addChild(effect!)
                gameScene!.run(SKAction.wait(forDuration: 1),completion:{
                    effect?.removeFromParent()
                })
            } else if item == "Golems_Curse" {
                let effect = SKEmitterNode(fileNamed: "PetrifyParticle.sks")
                effect?.position.y = 0
                self.addChild(effect!)
                gameScene!.run(SKAction.wait(forDuration: 1),completion:{
                    effect?.removeFromParent()
                })
            }
        } else if item == "Fires_Passion" {
            itemInUse = item
            let effect = SKEmitterNode(fileNamed: "HeatParticle.sks")
            effect?.position.y = 35
            self.addChild(effect!)
            self.parent?.run(SKAction.wait(forDuration: 5),completion:{
                effect?.removeFromParent()
                if self.itemInUse == "Fires_Passion" {
                    self.itemInUse = ""
                }
            })
        } else if item == "Sugar_Rush" {
            itemInUse = item
            let speedChange = self.movespeed * 0.5
            let cd1Change = self.skillCooldown_1 * 0.3
            let cd2Change = self.skillCooldown_2 * 0.3
            let cd3Change = self.skillCooldown_3 * 0.3
            
            self.movespeed += speedChange
            self.skillCooldown_1 -= cd1Change
            self.skillCooldown_2 -= cd2Change
            self.skillCooldown_3 -= cd3Change
            let effect = SKEmitterNode(fileNamed: "HyperParticle.sks")
            effect?.position.y = 25
            self.addChild(effect!)
            gameScene!.run(SKAction.wait(forDuration: 4),completion:{
                self.movespeed -= speedChange
                self.skillCooldown_1 += cd1Change
                self.skillCooldown_2 += cd2Change
                self.skillCooldown_3 += cd3Change
                effect?.removeFromParent()
                if self.itemInUse == "Sugar_Rush" {
                    self.itemInUse = ""
                }
            })
        } else if item == "Fairys_Heart" {
            itemInUse = item
            let hpToHeal:CGFloat = maxHP * 0.25
            applyHealing(hpToHeal)
            itemInUse = ""
            
            let effect = SKEmitterNode(fileNamed: "HealParticle.sks")
            effect?.position.y = 30
            self.addChild(effect!)
            gameScene!.run(SKAction.wait(forDuration: 3),completion:{
                effect?.removeFromParent()
            })
        }
    }
    
    func pickUpItem(_ item:String) {
        if sfxEnabled && self.parent != nil {
            self.soundPickup?.run(SKAction.stop())
            self.soundPickup?.run(SKAction.play())
        }
        
        if self == gameScene?.playerNode {
            if blessingList[chosenBlessing][4] == 10 && itemHeld == "" {
                itemHeld = item
            } else {
                useItem(item)
                //print("Using item: " + item)
            }
        } else if self == gameScene?.playerNode2 {
            if otherPlayerBlessings[0][4] == 10 && itemHeld == "" {
                itemHeld = item
            } else {
                useItem(item)
                //print("Using item: " + item)
            }
        } else if self == gameScene?.playerNode3 {
            if otherPlayerBlessings[1][4] == 10 && itemHeld == "" {
                itemHeld = item
            } else {
                useItem(item)
                //print("Using item: " + item)
            }
        } else if self == gameScene?.playerNode4 {
            if otherPlayerBlessings[2][4] == 10 && itemHeld == "" {
                itemHeld = item
            } else {
                useItem(item)
                //print("Using item: " + item)
            }
        }
    }
    
    func applyDebuff(_ player:Character, damage:CGFloat) {
        if itemInUse == "Icy_Grasp" {
            let speedChange = player.movespeed * 0.20
            player.movespeed -= speedChange
            gameScene?.run(SKAction.wait(forDuration: 1.5),completion:{
                player.movespeed += speedChange
            })
            let colorize = SKAction.colorize(with: .cyan, colorBlendFactor: 0.6, duration: 0.75)
            let colorize2 = SKAction.colorize(with: .white, colorBlendFactor: 0.25, duration: 0.75)
            player.run(colorize,completion:{
                player.run(colorize2)
            })
        } else if itemInUse == "Fires_Passion" {
            let colorize = SKAction.colorize(with: .red, colorBlendFactor: 0.6, duration: 1.5)
            let colorize2 = SKAction.colorize(with: .white, colorBlendFactor: 0.25, duration: 1.5)
            player.run(colorize,completion:{
                player.run(colorize2)
            })
            let damageModded = damage/3
            gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                player.takeDamage(damageModded, direction: 0)
                gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                    player.takeDamage(damageModded, direction: 0)
                    gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                        player.takeDamage(damageModded, direction: 0)
                        gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                            player.takeDamage(damageModded, direction: 0)
                            gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                                player.takeDamage(damageModded, direction: 0)
                                gameScene?.run(SKAction.wait(forDuration: 0.5),completion:{
                                    player.takeDamage(damageModded, direction: 0)
                                })
                            })
                        })
                    })
                })
            })
        }
    }
    
    func applyStatMods() {
        if characterName == "Jack-O" && characterForm == "" {
            if currentTheme == "SUMMER" {
                let cdChange1 = skillCooldown_1 * 0.1
                let cdChange2 = skillCooldown_2 * 0.1
                let cdChange3 = skillCooldown_3 * 0.1
                skillCooldown_1 += cdChange1
                skillCooldown_2 += cdChange2
                skillCooldown_3 += cdChange3
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.skillCooldown_1 -= cdChange1
                    self.skillCooldown_2 -= cdChange2
                    self.skillCooldown_3 -= cdChange3
                })
            } else if currentTheme == "FALL" {
                let powerChange = power * 0.4
                let resistChange = resistance * 0.4
                let speedChange = movespeed * 0.4
                power += powerChange
                resistance += resistChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.power -= powerChange
                    self.resistance -= resistChange
                    self.movespeed -= speedChange
                })
            } else if currentTheme == "WINTER" {
                let speedChange = movespeed * 0.25
                movespeed -= speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.movespeed += speedChange
                })
            }
        } else if characterName == "Plum" || characterName == "Rosetta" {
            if currentTheme == "SUMMER" {
                let cdChange1 = skillCooldown_1 * 0.3
                let cdChange2 = skillCooldown_2 * 0.3
                let cdChange3 = skillCooldown_3 * 0.3
                skillCooldown_1 += cdChange1
                skillCooldown_2 += cdChange2
                skillCooldown_3 += cdChange3
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.skillCooldown_1 -= cdChange1
                    self.skillCooldown_2 -= cdChange2
                    self.skillCooldown_3 -= cdChange3
                })
            } else if currentTheme == "FALL" {
                let resistChange = resistance * 0.4
                let speedChange = movespeed * 0.20
                resistance -= resistChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.resistance += resistChange
                    self.movespeed -= speedChange
                })
            } else if currentTheme == "WINTER" {
                let speedChange = movespeed * 0.35
                movespeed -= speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.movespeed += speedChange
                })
            }
        } else if characterName == "Silva" {
            if currentTheme == "SUMMER" {
                let cdChange1 = skillCooldown_1 * 0.2
                let cdChange2 = skillCooldown_2 * 0.2
                let cdChange3 = skillCooldown_3 * 0.2
                skillCooldown_1 += cdChange1
                skillCooldown_2 += cdChange2
                skillCooldown_3 += cdChange3
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.skillCooldown_1 -= cdChange1
                    self.skillCooldown_2 -= cdChange2
                    self.skillCooldown_3 -= cdChange3
                })

            } else if currentTheme == "FALL" {
                let resistChange = resistance * 0.2
                let speedChange = movespeed * 0.35
                resistance -= resistChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.resistance += resistChange
                    self.movespeed -= speedChange
                })
            } else if currentTheme == "WINTER" {
                let cdChange1 = skillCooldown_1 * 0.15
                let cdChange2 = skillCooldown_2 * 0.15
                let cdChange3 = skillCooldown_3 * 0.15
                let speedChange = movespeed * 0.1
                skillCooldown_1 += cdChange1
                skillCooldown_2 += cdChange2
                skillCooldown_3 += cdChange3
                movespeed -= speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.skillCooldown_1 -= cdChange1
                    self.skillCooldown_2 -= cdChange2
                    self.skillCooldown_3 -= cdChange3
                    self.movespeed += speedChange
                })
            }
        } else if characterName == "Cog" {
            if characterForm == "Cat" {
                if currentTheme == "SUMMER" {
                    let cdChange1 = skillCooldown_1 * 0.2
                    let cdChange2 = skillCooldown_2 * 0.2
                    let cdChange3 = skillCooldown_3 * 0.2
                    let speedChange = movespeed * 0.1
                    skillCooldown_1 += cdChange1
                    skillCooldown_2 += cdChange2
                    skillCooldown_3 += cdChange3
                    movespeed -= speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.skillCooldown_1 -= cdChange1
                        self.skillCooldown_2 -= cdChange2
                        self.skillCooldown_3 -= cdChange3
                        self.movespeed += speedChange
                    })
                } else if currentTheme == "FALL" {
                    let resistChange = resistance * 0.4
                    let speedChange = movespeed * 0.25
                    resistance -= resistChange
                    movespeed += speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.resistance += resistChange
                        self.movespeed -= speedChange
                    })
                } else if currentTheme == "WINTER" {
                    let cdChange1 = skillCooldown_1 * 0.1
                    let cdChange2 = skillCooldown_2 * 0.1
                    let cdChange3 = skillCooldown_3 * 0.1
                    let speedChange = movespeed * 0.35
                    skillCooldown_1 += cdChange1
                    skillCooldown_2 += cdChange2
                    skillCooldown_3 += cdChange3
                    movespeed -= speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.skillCooldown_1 -= cdChange1
                        self.skillCooldown_2 -= cdChange2
                        self.skillCooldown_3 -= cdChange3
                        self.movespeed += speedChange
                    })
                }
            } else if characterForm == "Dog" {
                if currentTheme == "SUMMER" {
                    let cdChange1 = skillCooldown_1 * 0.2
                    let cdChange2 = skillCooldown_2 * 0.2
                    let cdChange3 = skillCooldown_3 * 0.2
                    let speedChange = movespeed * 0.2
                    skillCooldown_1 += cdChange1
                    skillCooldown_2 += cdChange2
                    skillCooldown_3 += cdChange3
                    movespeed -= speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.skillCooldown_1 -= cdChange1
                        self.skillCooldown_2 -= cdChange2
                        self.skillCooldown_3 -= cdChange3
                        self.movespeed += speedChange
                    })
                } else if currentTheme == "FALL" {
                    let resistChange = resistance * 0.4
                    let speedChange = movespeed * 0.35
                    resistance -= resistChange
                    movespeed -= speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.resistance += resistChange
                        self.movespeed += speedChange
                    })
                } else if currentTheme == "WINTER" {
                    let cdChange1 = skillCooldown_1 * 0.1
                    let cdChange2 = skillCooldown_2 * 0.1
                    let cdChange3 = skillCooldown_3 * 0.1
                    let speedChange = movespeed * 0.1
                    skillCooldown_1 += cdChange1
                    skillCooldown_2 += cdChange2
                    skillCooldown_3 += cdChange3
                    movespeed -= speedChange
                    self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                        self.skillCooldown_1 -= cdChange1
                        self.skillCooldown_2 -= cdChange2
                        self.skillCooldown_3 -= cdChange3
                        self.movespeed += speedChange
                    })
                }
            }
        } else if characterName == "Sarah" {
            if currentTheme == "SUMMER" {
                let powerChange = power * 0.3
                let speedChange = movespeed * 0.3
                power += powerChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.power -= powerChange
                    self.movespeed -= speedChange
                })
            } else if currentTheme == "FALL" {
                let resistChange = resistance * 0.25
                let speedChange = movespeed * 0.25
                resistance += resistChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.resistance -= resistChange
                    self.movespeed -= speedChange
                })
            } else if currentTheme == "WINTER" {
                let cdChange1 = skillCooldown_1 * 0.25
                let cdChange2 = skillCooldown_2 * 0.25
                let cdChange3 = skillCooldown_3 * 0.25
                let powerChange = power * 0.15
                let speedChange = movespeed * 0.15
                skillCooldown_1 -= cdChange1
                skillCooldown_2 -= cdChange2
                skillCooldown_3 -= cdChange3
                power += powerChange
                movespeed += speedChange
                self.parent?.run(SKAction.wait(forDuration: 44.5),completion:{
                    self.skillCooldown_1 += cdChange1
                    self.skillCooldown_2 += cdChange2
                    self.skillCooldown_3 += cdChange3
                    self.power -= powerChange
                    self.movespeed -= speedChange
                })
            }
        }
    }
    
    func setUpAttackBoxes() {
        if characterName == "Jack-O" {
            let attackBox1 = AttackBox(color: .clear, size: CGSize(width: 40, height: 40))
            attackBox1.setUp(owner: self.player)
            attackBox1.name = "Skill1_Box"
            self.addChild(attackBox1)
            let attackBox3 = AttackBox(color: .clear, size: CGSize(width: 50, height: 40))
            attackBox3.setUp(owner: self.player)
            attackBox3.name = "Skill3_Box"
            self.addChild(attackBox3)
        } else if characterName == "Cog" {
            let attackBox2 = AttackBox(color: .clear, size: CGSize(width: 50, height: 30))
            attackBox2.setUp(owner: self.player)
            attackBox2.name = "Skill2_Box"
            self.addChild(attackBox2)
            let attackBox3 = AttackBox(color: .clear, size: CGSize(width: 50, height: 30))
            attackBox3.setUp(owner: self.player)
            attackBox3.name = "Skill3_Box"
            self.addChild(attackBox3)
        } else if characterName == "Plum" || characterName == "Rosetta" {
            let attackBox2 = AttackBox(color: .clear, size: CGSize(width: 40, height: 80))
            attackBox2.setUp(owner: self.player)
            attackBox2.name = "Skill2_Box"
            self.addChild(attackBox2)
            let attackBox3 = AttackBox(color: .clear, size: CGSize(width: 80, height: 45))
            attackBox3.setUp(owner: self.player)
            attackBox3.name = "Skill3_Box"
            self.addChild(attackBox3)
        } else if characterName == "Silva" {
            let attackBox1 = AttackBox(color: .clear, size: CGSize(width: 40, height: 65))
            attackBox1.setUp(owner: self.player)
            attackBox1.name = "Skill1_Box"
            self.addChild(attackBox1)
        } else if characterName == "Sarah" {
            let attackBox1 = AttackBox(color: .clear, size: CGSize(width: 40, height: 55))
            attackBox1.setUp(owner: self.player)
            attackBox1.name = "Skill1_Box"
            self.addChild(attackBox1)
            let attackBox3 = AttackBox(color: .clear, size: CGSize(width: 80, height: 35))
            attackBox3.setUp(owner: self.player)
            attackBox3.name = "Skill3_Box"
            self.addChild(attackBox3)
        }
    }
}
