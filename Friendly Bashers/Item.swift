//
//  Item.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 11/19/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class Item:SKSpriteNode {
    var itemName:String = ""
    var hp:CGFloat = 5
    var removeCounter = 0
    
    func setUp(_ nameOfItem:String) {
        self.name = "Item"
        self.zPosition = charLayer
        self.itemName = nameOfItem
        let width = self.texture?.size().width
        let height = self.texture?.size().height
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width!, height: height!))
        self.physicsBody!.allowsRotation = true
        self.physicsBody!.friction = 0.8
        self.physicsBody!.restitution = 0.05
        self.physicsBody!.linearDamping = 0.8
        self.physicsBody!.affectedByGravity = true
        self.physicsBody!.categoryBitMask = ItemCategory
        self.physicsBody!.collisionBitMask = WorldCategory | ItemCategory
        
        self.floatInWater()
    }
    
    func floatInWater() {
        let tile = returnBlockBelow()
        if tile == "Water" {
            self.physicsBody?.affectedByGravity = false
            self.physicsBody?.allowsRotation = false
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 15))
        } else {
            self.physicsBody?.affectedByGravity = true
            self.physicsBody?.allowsRotation = true
        }
    
        removeCounter += 1
        
        self.run(SKAction.wait(forDuration: 0.25),completion:{
            if self.removeCounter < 35 {
                self.floatInWater()
            } else {
                self.removeAllChildren()
                self.removeFromParent()
                self.removeAllActions()
            }
        })
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
    
    func applyDamage(_ player:Character, damage:CGFloat) {
        self.hp -=  damage
        
        if self.hp <= 0 {
            player.pickUpItem(self.itemName)
            if player == gameScene!.playerNode {
                gameScene?.setMasteryButtonOverlay()
            }
            
            self.removeFromParent()
            self.removeAllActions()
        } else {
            let X_MOD:CGFloat = (1 - (self.hp/25)) * 10
            let Y_MOD:CGFloat = (1 - (self.hp/25)) * 8
            let impX:CGFloat = (damage * player.xScale) * X_MOD
            let impY:CGFloat = damage * Y_MOD
            
            self.physicsBody?.applyImpulse(CGVector(dx: impX, dy: impY))
        }
    }
}
