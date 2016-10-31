//
//  Projectile.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/20/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class Projectile:SKSpriteNode {
    var damage:CGFloat = 0
    var owner:String = ""
    var gameScene:GameScene?
    var direction:CGFloat?
    
    func setUp(_ damage:CGFloat, direction:CGFloat, owner:String) {
        gameScene = self.parent as! GameScene?
        self.damage = damage
        self.owner = owner
        self.direction = direction
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: (self.texture?.size())!)
        self.physicsBody!.allowsRotation = false
        self.physicsBody!.friction = 5.0
        self.physicsBody!.restitution = 0
        self.physicsBody!.contactTestBitMask = 1
        self.physicsBody!.contactTestBitMask = ProjectileCategory | WorldCategory | CharacterCategory
        self.physicsBody!.categoryBitMask = ProjectileCategory
        self.physicsBody!.collisionBitMask = WorldCategory | CharacterCategory
        
        if direction == 1 {
            self.zRotation = 80
        } else {
            self.zRotation = -80
        }
        self.run(SKAction.wait(forDuration: 5), completion:{
            self.removeFromParent()
        })
    }
}
