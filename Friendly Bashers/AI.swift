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
    var thoughtCount = 0
    
    var facingCharacter:Character?
    
    func startAI() {
        self.run(animateIdle!)
        brain = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(AI.processInfo), userInfo: nil, repeats: true)
    }
    
    func processInfo() {
        if characterName == "Cog" {
            if !inAction {
                self.doSkill_2()
                self.run(animateSkill_2!)
                inAction = true
            }
        } else if characterName == "Jack-O" {
            if self.facingCharacter != nil && !inAction {
                inAction = true
                self.doSkill_1()
                self.facingCharacter = nil
                self.run(animateSkill_1!,completion:{
                    self.inAction = false
                })
            } else {
                thoughtCount += 1
                if thoughtCount >= 160 {
                    self.brain.invalidate()
                    self.removeAllActions()
                    self.removeFromParent()
                } else {
                    if ableToWalkForward() {
                        self.physicsBody?.velocity = CGVector(dx: self.movespeed * self.xScale, dy: (self.physicsBody?.velocity.dy)!)
                        if !inAction {
                            inAction = true
                            self.run(animateRun!,completion:{
                                self.inAction = false
                            })
                        }
                    }
                }
            }
        }
    }
    
    func ableToWalkForward() -> Bool {
        var able = false
        
        if self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character == nil {
            //print((self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character)?.BASE_MAX_HP)
            able = true
        } else if self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character != nil && (self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character)?.player == self.player {
            self.xScale *= -1
        } else if self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character != nil && (self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character)?.player != self.player {
            self.facingCharacter = self.parent!.atPoint(CGPoint(x: self.position.x + (65 * self.xScale), y: self.position.y)) as? Character
        }
        return able
    }
}
