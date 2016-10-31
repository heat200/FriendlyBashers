//
//  OptionsScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/30/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class OptionsScene:SKScene {
    var backButton:SKSpriteNode?
    
    var sfxButton:SKSpriteNode?
    var musicButton:SKSpriteNode?
    
    
    override func sceneDidLoad() {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.sfxButton = self.childNode(withName: "//sfxButton") as? SKSpriteNode
        self.musicButton = self.childNode(withName: "//musicButton") as? SKSpriteNode
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if let view = self.view {
                    view.presentScene(mainMenu)
                    view.ignoresSiblingOrder = false
                    
                    view.showsFPS = false
                }
            } else if (self.sfxButton?.contains(pos))! {
                if sfxEnabled {
                    sfxEnabled = false
                } else {
                    sfxEnabled = true
                }
            } else if (self.musicButton?.contains(pos))! {
                if musicEnabled {
                    musicEnabled = false
                } else {
                    musicEnabled = true
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if sfxEnabled {
            sfxButton!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Sfx_On")))
        } else {
            sfxButton!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Sfx_Off")))
        }
        
        if musicEnabled {
            musicButton!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Music_On")))
        } else {
            musicButton!.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Music_Off")))
        }
    }
}
