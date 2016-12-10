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
    
    func setUp(owner:String) {
        self.owner = owner
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = AttackBoxCategory
        self.physicsBody?.contactTestBitMask = CharacterCategory
    }
    
    func activateFor(time:Double,damage:CGFloat) {
        self.damage = damage
        active = true
        gameScene?.run(SKAction.wait(forDuration: time),completion:{
            self.damage = 0
            self.active = false
        })
    }
}
