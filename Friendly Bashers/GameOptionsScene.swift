//
//  GameOptionsScene.swift
//  Friendly Bashers
//
//  Created by Bryan Mazariegos on 10/30/16.
//  Copyright © 2016 Bryan Mazariegos. All rights reserved.
//

import SpriteKit

class GameOptionsScene:SKScene {
    var backButton:SKSpriteNode?
    
    var sfxButton:SKSpriteNode?
    var musicButton:SKSpriteNode?
    
    var rightButton:SKSpriteNode?
    var leftButton:SKSpriteNode?
    var timeLimitLabel:SKLabelNode?
    
    var chooseBlessingPage1:SKSpriteNode?
    var blessingPageName1:SKLabelNode?
    
    var chooseBlessingPage2:SKSpriteNode?
    var blessingPageName2:SKLabelNode?
    
    var chooseBlessingPage3:SKSpriteNode?
    var blessingPageName3:SKLabelNode?
    
    var chooseBlessingPage4:SKSpriteNode?
    var blessingPageName4:SKLabelNode?
    
    var deathMode1Button:SKSpriteNode?
    var deathMode2Button:SKSpriteNode?
    
    override func sceneDidLoad() {
        self.backButton = self.childNode(withName: "//backButton") as? SKSpriteNode
        self.sfxButton = self.childNode(withName: "//sfxButton") as? SKSpriteNode
        self.musicButton = self.childNode(withName: "//musicButton") as? SKSpriteNode
        self.leftButton = self.childNode(withName: "//leftButton") as? SKSpriteNode
        self.rightButton = self.childNode(withName: "//rightButton") as? SKSpriteNode
        self.chooseBlessingPage1 = self.childNode(withName: "//choosePage1Button") as? SKSpriteNode
        self.chooseBlessingPage2 = self.childNode(withName: "//choosePage2Button") as? SKSpriteNode
        self.chooseBlessingPage3 = self.childNode(withName: "//choosePage3Button") as? SKSpriteNode
        self.chooseBlessingPage4 = self.childNode(withName: "//choosePage4Button") as? SKSpriteNode
        
        self.timeLimitLabel = self.childNode(withName: "//timeLimitLabel") as? SKLabelNode
        
        self.deathMode1Button = self.childNode(withName: "//deathMode1Button") as? SKSpriteNode
        self.deathMode2Button = self.childNode(withName: "//deathMode2Button") as? SKSpriteNode
        
        self.blessingPageName1 = chooseBlessingPage1!.childNode(withName: "//blessingName1Label") as? SKLabelNode
        self.blessingPageName2 = chooseBlessingPage2!.childNode(withName: "//blessingName2Label") as? SKLabelNode
        self.blessingPageName3 = chooseBlessingPage3!.childNode(withName: "//blessingName3Label") as? SKLabelNode
        self.blessingPageName4 = chooseBlessingPage4!.childNode(withName: "//blessingName4Label") as? SKLabelNode
    }
    
    override func didMove(to view: SKView) {
        blessingPageName1!.text = blessingNames[0]
        blessingPageName2!.text = blessingNames[1]
        blessingPageName3!.text = blessingNames[2]
        blessingPageName4!.text = blessingNames[3]
        updateUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let pos = t.location(in: self)
            
            if (self.backButton?.contains(pos))! {
                if let view = self.view {
                    view.presentScene(basherSelect)
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
            } else if (self.leftButton?.contains(pos))! {
                timeLimit -= 1
                if timeLimit < 0 {
                    timeLimit = 0
                }
            } else if (self.rightButton?.contains(pos))! {
                timeLimit += 1
                if timeLimit > 5 {
                    timeLimit = 5
                }
            } else if (self.deathMode1Button?.contains(pos))! {
                deathMode = 1
            } else if (self.deathMode2Button?.contains(pos))! {
                deathMode = 2
            } else if (self.chooseBlessingPage1?.contains(pos))! {
                chosenBlessing = 0
            } else if (self.chooseBlessingPage2?.contains(pos))! {
                chosenBlessing = 1
            } else if (self.chooseBlessingPage3?.contains(pos))! {
                chosenBlessing = 2
            } else if (self.chooseBlessingPage4?.contains(pos))! {
                chosenBlessing = 3
            }
            updateUI()
        }
    }
    
    func updateUI() {
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
        
        if timeLimit == 0 {
            leftButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Left_Grey")))
            timeLimitLabel?.text = "Unlimited"
        } else if timeLimit == 1 {
            timeLimitLabel?.text = "1 Minute"
            leftButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Left")))
        } else if timeLimit == 2 {
            timeLimitLabel?.text = "2 Minutes"
        } else if timeLimit == 3 {
            timeLimitLabel?.text = "3 Minutes"
        } else if timeLimit == 4 {
            timeLimitLabel?.text = "4 Minutes"
            rightButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Right")))
        } else if timeLimit == 5 {
            timeLimitLabel?.text = "5 Minutes"
            rightButton?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Right_Grey")))
        }
        
        if chosenBlessing == 0 {
            chooseBlessingPage1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            chooseBlessingPage2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        } else if chosenBlessing == 1 {
            chooseBlessingPage1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            chooseBlessingPage3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        } else if chosenBlessing == 2 {
            chooseBlessingPage1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            chooseBlessingPage4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        } else if chosenBlessing == 3 {
            chooseBlessingPage1?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage2?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage3?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            chooseBlessingPage4?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        }
        
        if deathMode == 1 {
            deathMode1Button?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
            deathMode2Button?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
        } else if deathMode == 2 {
            deathMode1Button?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Enabled")))
            deathMode2Button?.run(SKAction.setTexture(SKTexture(imageNamed: "Button_Disabled")))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
