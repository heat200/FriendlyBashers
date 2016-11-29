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
    var direction:CGFloat?
    
    func setUp(_ damage:CGFloat, direction:CGFloat, owner:String) {
        self.damage = damage
        self.owner = owner
        self.direction = direction
        let width = self.texture?.size().width
        let height = self.texture?.size().height
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width!, height: height!))
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.friction = 5.0
        self.physicsBody!.restitution = 0
        self.physicsBody!.linearDamping = 0.2
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.contactTestBitMask = CharacterCategory
        self.physicsBody!.categoryBitMask = ProjectileCategory
        self.physicsBody!.collisionBitMask = ItemCategory | CharacterCategory
        
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
