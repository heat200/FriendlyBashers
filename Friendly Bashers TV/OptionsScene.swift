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
    
    var backgroundAtlas = bgAtlas
    var UIAtlas = uiAtlas
    
    override func sceneDidLoad() {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.sfxButton = self.childNode(withName: "//sfxButton") as? SKSpriteNode
        self.musicButton = self.childNode(withName: "//musicButton") as? SKSpriteNode
        self.renamePlayer = self.childNode(withName: "//renameButton") as? SKSpriteNode
        self.playerNameLabel = self.childNode(withName: "//playerNameLabel") as? SKLabelNode
    }
    
    override func didMove(to view: SKView) {
        if mainMenu!.isPaused {
            mainMenu?.isPaused = false
        }
        textField = UITextField(frame: CGRect(x: self.size.width/2, y: self.size.height/2 - 50, width: 100, height: 20))
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.alphabet
        self.view?.addSubview(textField)
        updateUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                defaults.set(sfxEnabled, forKey: "SFX")
                defaults.set(musicEnabled, forKey: "MUSIC")
                defaults.setValue(playerName, forKey: "PLAYERNAME")
                self.run(SKAction.wait(forDuration: 0.03),completion:{
                    self.backToMainMenu()
                })
            } else if (self.sfxButton?.contains(pos))! {
                if sfxEnabled {
                    sfxEnabled = false
                } else {
                    sfxEnabled = true
                    self.run(clickSound)
                }
            } else if (self.musicButton?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                if musicEnabled {
                    musicEnabled = false
                    SKTAudio.sharedInstance().backgroundMusicPlayer?.stop()
                } else {
                    musicEnabled = true
                    SKTAudio.sharedInstance().playBackgroundMusic(filename: "Calamity_airwolf89.mp3")
                }
            } else if (self.renamePlayer?.contains(pos))! {
                if sfxEnabled {
                    self.run(clickSound)
                }
                
                editing = true
                textField.becomeFirstResponder()
            }
            updateUI()
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
        updateUI()
        
        editing = false
    }
    
    func updateUI() {
        playerNameLabel!.text = playerName
        
        if sfxEnabled {
            sfxButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Sfx_On")))
        } else {
            sfxButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Sfx_Off")))
        }
        
        if musicEnabled {
            musicButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Music_On")))
        } else {
            musicButton!.run(SKAction.setTexture(UIAtlas.textureNamed("Button_Music_Off")))
        }
    }
    
    func backToMainMenu() {
        if let view = self.view {
            view.presentScene(mainMenu)
            self.removeFromParent()
            view.ignoresSiblingOrder = false
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
}
