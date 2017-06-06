//
//  AttackBox.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 12/8/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class AttackBox:SKSpriteNode {
    var damage:CGFloat = 0
    var owner = ""
    var active = false
    var ownerChar = ""
    
    func setUp(owner:String) {
        self.owner = owner
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.pinned = true
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.mass = 0
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.categoryBitMask = AttackBoxCategory
        self.physicsBody?.contactTestBitMask = CharacterCategory | ItemCategory
        self.clearPos()
        gameScene?.run(SKAction.wait(forDuration: 0.15),completion:{
            self.ownerChar = (self.parent as! Character).characterName
        })
    }
    
    func activateFor(time:Double,damage:CGFloat) {
        update(0)
        self.damage = damage
        active = true
        gameScene?.run(SKAction.wait(forDuration: time),completion:{
            self.damage = 0
            self.active = false
            self.clearPos()
        })
    }
    
    func resetPos() {
        if self.name == "Skill3_Box" {
            if ownerChar == "Jack-O" {
                self.position = CGPoint(x: 35, y: -30)
            } else if ownerChar == "Sarah" {
                self.position = CGPoint(x: 25, y: -30)
            } else {
                self.position = CGPoint(x: 40, y: -30)
            }
        } else {
            if ownerChar == "Jack-O" {
                self.position = CGPoint(x: 35, y: -25)
            } else if ownerChar == "Silva" {
                self.position = CGPoint(x: 35, y: -25)
            } else if ownerChar == "Sarah" {
                self.position = CGPoint(x: 25, y: -7)
            } else if ownerChar == "Cog" {
                self.position = CGPoint(x: 40, y: -30)
            } else {
                self.position = CGPoint(x: 35, y: -7)
            }
        }
    }
    
    func clearPos() {
        self.position = CGPoint(x: 0, y: 5000)
    }
    
    func update(_ iteration:Int) {
        if iteration < 10 {
            let newI = iteration + 1
            gameScene?.run(SKAction.wait(forDuration: 0.05),completion:{
                if self.active {
                    self.resetPos()
                    self.update(newI)
                } else {
                    self.clearPos()
                }
            })
        } else {
            if !self.active {
                self.clearPos()
            }
        }
    }
}
