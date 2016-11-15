//
//  OptionsScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/30/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class OptionsScene:SKScene, UITextFieldDelegate {
    var textField:UITextField!
    
    var backButton:SKSpriteNode?
    
    var sfxButton:SKSpriteNode?
    var musicButton:SKSpriteNode?
    
    var playerNameLabel:SKLabelNode?
    var renamePlayer:SKSpriteNode?
    
    var editing = false
    
    override func sceneDidLoad() {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.sfxButton = self.childNode(withName: "//sfxButton") as? SKSpriteNode
        self.musicButton = self.childNode(withName: "//musicButton") as? SKSpriteNode
        self.renamePlayer = self.childNode(withName: "//renameButton") as? SKSpriteNode
        self.playerNameLabel = self.childNode(withName: "//playerNameLabel") as? SKLabelNode
    }
    
    override func didMove(to view: SKView) {
        textField = UITextField(frame: CGRect(x: self.size.width/2, y: self.size.height/2 - 50, width: 100, height: 20))
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.alphabet
        self.view?.addSubview(textField)
        playerNameLabel?.text = playerName
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
            } else if (self.renamePlayer?.contains(pos))! {
                editing = true
                textField.becomeFirstResponder()
            }
            
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if editing {
            if textField.text! == "" {
                playerName = "No Name"
            } else {
                playerName = textField.text!
            }
            textField.text = ""
        }
        
        editing = false
        
        playerNameLabel!.text = playerName
    }
}
